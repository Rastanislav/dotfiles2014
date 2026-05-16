#!/usr/bin/env bash
# ThinkPad fan control (requires thinkfan package + /etc/thinkfan.conf)
set -euo pipefail
if [[ -f /etc/thinkfan.conf ]]; then
  sudo thinkfan -c /etc/thinkfan.conf
else
  echo "Missing /etc/thinkfan.conf — install and configure thinkfan first."
  exit 1
fi
