#!/bin/bash
set -e

echo "🚀 Starting Azure Functions packaging..."

# Ensure script runs from repo root
cd "$(dirname "$0")"

# Ingest Function
echo "📦 Zipping ingest_function..."
cd functions/ingest_function
zip -r ../../ingest_function.zip . > /dev/null
cd ../..

# Report Function
echo "📦 Zipping report_function..."
cd functions/report_function
zip -r ../../report_function.zip . > /dev/null
cd ../..

echo "✅ Packaging completed successfully!"
