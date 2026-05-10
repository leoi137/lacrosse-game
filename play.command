#!/bin/bash
cd "$(dirname "$0")"
python3 -m http.server 8765 >/dev/null 2>&1 &
PID=$!
sleep 0.7
open "http://localhost:8765/"
echo "Server running on http://localhost:8765/  (PID $PID)"
echo "Close this window to stop the server."
wait $PID
