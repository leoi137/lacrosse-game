@echo off
cd /d "%~dp0"

set PY=
where python >nul 2>&1 && set PY=python
if "%PY%"=="" where py >nul 2>&1 && set PY=py
if "%PY%"=="" where python3 >nul 2>&1 && set PY=python3

if "%PY%"=="" (
  echo.
  echo ERROR: Python is not installed.
  echo Install from https://www.python.org/downloads/  ^(check "Add Python to PATH"^)
  echo Then double-click play.bat again.
  echo.
  pause
  exit /b 1
)

echo Starting server with %PY% ...
start "Lacrosse Server (close to stop)" %PY% -m http.server 8765
timeout /t 2 /nobreak >nul
start "" http://localhost:8765/
echo.
echo Server: http://localhost:8765/
echo Close the "Lacrosse Server" window to stop.
