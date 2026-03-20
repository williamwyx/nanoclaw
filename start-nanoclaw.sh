#!/bin/bash
# start-nanoclaw.sh — Start NanoClaw without systemd
# To stop: kill \$(cat /Users/william/nanoclaw-sandbox-2603/nanoclaw.pid)

set -euo pipefail

cd "/Users/william/nanoclaw-sandbox-2603"

# Stop existing instance if running
if [ -f "/Users/william/nanoclaw-sandbox-2603/nanoclaw.pid" ]; then
  OLD_PID=$(cat "/Users/william/nanoclaw-sandbox-2603/nanoclaw.pid" 2>/dev/null || echo "")
  if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
    echo "Stopping existing NanoClaw (PID $OLD_PID)..."
    kill "$OLD_PID" 2>/dev/null || true
    sleep 2
  fi
fi

echo "Starting NanoClaw..."
nohup "/usr/bin/node" "/Users/william/nanoclaw-sandbox-2603/dist/index.js" \
  >> "/Users/william/nanoclaw-sandbox-2603/logs/nanoclaw.log" \
  2>> "/Users/william/nanoclaw-sandbox-2603/logs/nanoclaw.error.log" &

echo $! > "/Users/william/nanoclaw-sandbox-2603/nanoclaw.pid"
echo "NanoClaw started (PID $!)"
echo "Logs: tail -f /Users/william/nanoclaw-sandbox-2603/logs/nanoclaw.log"
