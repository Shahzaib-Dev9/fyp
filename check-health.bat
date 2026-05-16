@echo off
REM Simple health check script

echo 🏥 DeepFake Detection System Health Check
echo ==========================================

REM Check if services are running
echo 🔍 Checking service health...
echo.

REM Frontend check
echo 1. Frontend (http://localhost:3000):
curl -s -o nul -w "Status: %%{http_code}" http://localhost:3000
if %errorlevel% equ 0 (
    echo  ✅ Available
) else (
    echo  ❌ Not responding
)
echo.

REM Backend API check
echo 2. Backend API (http://localhost:8000):
curl -s -o nul -w "Status: %%{http_code}" http://localhost:8000/api/v1/health
if %errorlevel% equ 0 (
    echo  ✅ Available
) else (
    echo  ❌ Not responding
)
echo.

REM Inference Service check
echo 3. Inference Service (http://localhost:8001):
curl -s -o nul -w "Status: %%{http_code}" http://localhost:8001/health
if %errorlevel% equ 0 (
    echo  ✅ Available
) else (
    echo  ❌ Not responding
)
echo.

REM Docker containers check
echo 4. Docker Containers:
for /f "tokens=*" %%i in ('docker ps --format "table {{.Names}}\t{{.Status}}" ^| findstr deepfake') do echo   %%i

echo.
echo 📊 For detailed logs: troubleshoot.bat
echo 🔧 For fixes: fix-frontend.bat
echo.
pause