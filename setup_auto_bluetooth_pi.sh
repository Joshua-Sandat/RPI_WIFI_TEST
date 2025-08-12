#!/bin/bash
# Setup script for Auto Bluetooth WiFi Credential Sharer on Raspberry Pi Zero 2 W

echo "🔌 Setting up Auto Bluetooth WiFi Credential Sharer for Raspberry Pi Zero 2 W"
echo "=========================================================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ This script must be run as root (use sudo)"
    exit 1
fi

# Update system
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install required packages
echo "📦 Installing required packages..."
apt install -y bluez bluez-tools wpasupplicant python3-dbus python3-gi

# Stop services that might interfere
echo "🛑 Stopping conflicting services..."
systemctl stop bluetooth

# Configure Bluetooth
echo "⚙️  Configuring Bluetooth..."
cat > /etc/bluetooth/main.conf << EOF
[General]
Name = PiWiFiSetup
Class = 0x000100
DiscoverableTimeout = 0
PairableTimeout = 0
AutoEnable = true

[Policy]
AutoEnable = true

[GATT]
Key = 0000110b-0000-1000-8000-00805f9b34fb
EOF

# Enable Bluetooth service
echo "🚀 Enabling Bluetooth service..."
systemctl enable bluetooth

# Make script executable
chmod +x auto_bluetooth_wifi_sharer.py

echo ""
echo "✅ Setup complete!"
echo ""
echo "To start automatic Bluetooth WiFi credential sharing:"
echo "  sudo python3 auto_bluetooth_wifi_sharer.py"
echo ""
echo "Your phone will see:"
echo "  - Bluetooth device: 'PiWiFiSetup'"
echo ""
echo "What happens automatically:"
echo "1. Connect your phone to Pi via Bluetooth"
echo "2. Pi automatically detects the connection"
echo "3. Pi attempts to extract WiFi credentials from your phone"
echo "4. Pi connects to your WiFi network"
echo ""
echo "No manual file creation or sending needed!"
echo "Just connect Bluetooth and Pi does the rest!"
