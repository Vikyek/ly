#!/usr/bin/env bash
set -euo pipefail

echo "==> Building Ly display manager (ReleaseSafe)..."
zig build -Doptimize=ReleaseSafe

echo "==> Installing Ly binary into /usr/bin and /usr/sbin..."
sudo cp zig-out/bin/ly /usr/bin/ly
sudo cp zig-out/bin/ly /usr/sbin/ly
sudo chmod 755 /usr/bin/ly /usr/sbin/ly

echo "==> Installing configuration and service files..."
sudo mkdir -p /etc/ly /etc/ly/lang /etc/ly/custom-sessions

if [ ! -f /etc/ly/config.ini ]; then
    sudo cp res/config.ini /etc/ly/config.ini 2>/dev/null || true
fi

echo "==> Installation complete! Test with: sudo ly"
