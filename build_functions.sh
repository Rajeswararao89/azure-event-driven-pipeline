
#!/bin/bash
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/functions/ingest_function"
zip -r "$ROOT/ingest_function.zip" . -x "*.pyc"
cd "$ROOT/functions/report_function"
zip -r "$ROOT/report_function.zip" . -x "*.pyc"
echo "Created ingest_function.zip and report_function.zip in repo root."
