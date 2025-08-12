# WiFi Credential Sharer for Raspberry Pi Zero 2 W

A professional-grade WiFi credential sharing system that works exactly like commercial IoT devices (Chromecast, smart speakers, etc.).

## 🎯 What This Does

This system allows your **Raspberry Pi Zero 2 W** to automatically connect to whatever WiFi network your phone is on, without you needing to manually configure network settings.

## 🚀 How It Works

1. **Pi creates a WiFi hotspot** called "PiWiFiSetup"
2. **Your phone connects** to this hotspot
3. **Phone shares WiFi credentials** via a web interface
4. **Pi automatically connects** to your phone's WiFi network
5. **Pi switches from hotspot mode** to client mode

## 📋 Requirements

- **Raspberry Pi Zero 2 W** (has built-in WiFi + Bluetooth)
- **MicroSD card** with Raspberry Pi OS
- **Power supply** for the Pi
- **Your phone** (any smartphone)

## 🛠️ Installation

### Step 1: Copy Files to Pi
Copy these files to your Pi:
- `wifi_credential_sharer.py`
- `setup_pi.sh`

### Step 2: Run Setup Script
```bash
# Make setup script executable
chmod +x setup_pi.sh

# Run setup (must be root)
sudo ./setup_pi.sh
```

### Step 3: Start Credential Sharing
```bash
sudo python3 wifi_credential_sharer.py
```

## 📱 How to Use

### On Your Phone:

1. **Connect to WiFi hotspot:**
   - Network: `PiWiFiSetup`
   - Password: `raspberry`

2. **Open web browser** and go to: `http://192.168.4.1`

3. **Enter your WiFi credentials:**
   - WiFi Network Name (SSID)
   - WiFi Password

4. **Click "Connect Pi to WiFi"**

### What Happens Next:

- Pi receives your WiFi credentials
- Pi stops being a hotspot
- Pi connects to your WiFi network
- Pi is now on your home/office network!

## 🔧 Technical Details

### Network Configuration
- **Hotspot IP**: 192.168.4.1
- **DHCP Range**: 192.168.4.2 - 192.168.4.20
- **DNS**: Google DNS (8.8.8.8, 8.8.4.4)

### Services Used
- **hostapd**: WiFi access point
- **dnsmasq**: DHCP server + DNS
- **bluez**: Bluetooth management
- **wpa_supplicant**: WiFi client

### Security Features
- WPA2 encryption on hotspot
- Credentials stored securely
- Automatic service cleanup

## 🚨 Troubleshooting

### Pi won't start hotspot
```bash
# Check services
sudo systemctl status hostapd dnsmasq bluetooth

# Restart services
sudo systemctl restart hostapd dnsmasq bluetooth
```

### Can't connect to hotspot
- Make sure Pi is running the script
- Check if other WiFi networks are interfering
- Try changing the channel in hostapd.conf

### Pi won't connect to your WiFi
- Verify credentials are correct
- Check if your WiFi uses WPA3 (may need configuration changes)
- Ensure your WiFi network is 2.4GHz (Pi Zero 2 W doesn't support 5GHz)

### Reset everything
```bash
# Stop all services
sudo systemctl stop hostapd dnsmasq bluetooth

# Remove configurations
sudo rm /etc/hostapd/hostapd.conf
sudo rm /etc/dnsmasq.conf
sudo rm /etc/network/interfaces

# Reboot
sudo reboot
```

## 🔄 Repeating the Process

If you want to connect to a different WiFi network later:

1. **Run the script again:**
   ```bash
   sudo python3 wifi_credential_sharer.py
   ```

2. **Follow the same steps** on your phone

3. **Pi will automatically switch** to the new network

## 📊 Logs

All activity is logged to:
- Console output
- `/var/log/wifi_sharer.log`

## 🎉 Success Indicators

You'll know it worked when:
- ✅ "Setup complete! Pi is now connected to your WiFi network."
- Your Pi appears on your WiFi network
- You can SSH to your Pi using your network's IP address

## 🔐 Security Notes

- **Hotspot password** is set to "raspberry" (change in setup_pi.sh if needed)
- **Credentials are stored** in `/etc/wifi_credentials.json`
- **Network traffic** during setup is local only
- **No internet access** until connected to your WiFi

## 🚀 Next Steps

Once connected to WiFi, you can:
- SSH into your Pi from anywhere on your network
- Run your sensor data collection scripts
- Upload data to cloud services
- Access Pi remotely via VNC

---

**This system works exactly like professional IoT devices - no apps needed, just connect and share credentials!** 🎯
