@echo off
TITLE FireWatch Field Maintenance Tool
cls
echo =========================================================
echo [MAINTENANCE] Initializing Field Reset Protocol...
echo =========================================================
set /p NODE_ID="Enter 4-Character Unique Node ID to Clear (e.g., B403): "
python field_reset.py %NODE_ID%
echo =========================================================
pause
