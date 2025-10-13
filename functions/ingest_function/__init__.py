
import logging
import azure.functions as func
from datetime import datetime

def main(myblob: func.InputStream, outputBlob: func.Out[bytes]):
    try:
        data = myblob.read().decode('utf-8')
    except Exception as e:
        logging.error(f"Failed to read blob: {e}")
        data = ""
    transformed = data + f"\n_ingested_at: {datetime.utcnow().isoformat()}"
    outputBlob.set(transformed.encode('utf-8'))
    logging.info(f"Processed blob: {myblob.name}")
