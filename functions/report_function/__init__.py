
import logging
import azure.functions as func
from azure.storage.blob import BlobServiceClient
from datetime import datetime
import csv, io, os

def main(mytimer: func.TimerRequest) -> None:
    try:
        conn_str = os.environ['AzureWebJobsStorage']
        blob_service_client = BlobServiceClient.from_connection_string(conn_str)
    except Exception as e:
        logging.error(f"Failed to create blob client: {e}")
        return

    processed_container = "processed"
    reports_container = "reports"
    try:
        blobs = blob_service_client.get_container_client(processed_container).list_blobs()
    except Exception as e:
        logging.error(f"Failed to list blobs: {e}")
        blobs = []

    csv_buffer = io.StringIO()
    writer = csv.writer(csv_buffer)
    writer.writerow(["file_name", "size_bytes", "last_modified"])

    for blob in blobs:
        writer.writerow([blob.name, blob.size, blob.last_modified])

    report_name = f"daily_summary_{datetime.utcnow().strftime('%Y-%m-%d')}.csv"
    try:
        blob_service_client.get_blob_client(reports_container, report_name).upload_blob(csv_buffer.getvalue(), overwrite=True)
        logging.info(f"Generated report: {report_name}")
    except Exception as e:
        logging.error(f"Failed to upload report: {e}")
