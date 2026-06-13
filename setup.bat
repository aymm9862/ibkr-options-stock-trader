@echo off
REM ── One-step setup: create a virtual environment and install dependencies ──
cd /d "%~dp0"

echo Creating virtual environment (.venv)...
python -m venv .venv
if errorlevel 1 (
    echo.
    echo [ERROR] Could not create the venv. Make sure Python 3.10+ is installed
    echo         and on your PATH ^(https://www.python.org/downloads/^).
    pause
    exit /b 1
)

echo Installing dependencies from requirements.txt...
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements.txt
if errorlevel 1 (
    echo.
    echo [ERROR] Dependency installation failed. See the messages above.
    pause
    exit /b 1
)

echo.
echo ============================================================
echo  Setup complete.
echo  1) Start TWS or IB Gateway and enable the API.
echo  2) Run:  python main.py          ^(options^)
echo           python stock_trader.py  ^(stocks^)
echo ============================================================
pause
