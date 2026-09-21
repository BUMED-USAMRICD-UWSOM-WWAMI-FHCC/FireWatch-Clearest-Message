#!/usr/bin/env bash
# FireWatch Field Maintenance Shortcut Utility

clear
echo "========================================================="
echo "[MAINTENANCE] Initializing Field Reset Protocol..."
echo "========================================================="
read -p "Enter 4-Character Unique Node ID to Clear (e.g., B403): " NODE_ID
python3 field_reset.py "$NODE_ID"
echo "========================================================="
read -p "Press [Enter] to exit..."
