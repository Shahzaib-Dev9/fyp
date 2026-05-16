@echo off
REM Quick fix for frontend issues

echo 🔧 Frontend Quick Fix Script
echo ===============================

REM Detect compose file
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    set COMPOSE_FILE=docker-compose.yml
) else (
    set COMPOSE_FILE=docker-compose.cpu.yml
)

echo 🛠️  Fixing frontend build issues...

REM Stop frontend service
echo 1. Stopping frontend service...
docker-compose -f %COMPOSE_FILE% stop frontend

REM Remove frontend container
echo 2. Removing frontend container...
docker-compose -f %COMPOSE_FILE% rm -f frontend

REM Remove frontend image to force rebuild
echo 3. Removing frontend image...
docker rmi deepfake-frontend >nul 2>&1

REM Rebuild and start frontend
echo 4. Rebuilding and starting frontend...
docker-compose -f %COMPOSE_FILE% up --build -d frontend

echo 5. Waiting for frontend to build...
timeout /t 60 /nobreak >nul

REM Check if frontend is working
echo 6. Testing frontend...
curl -f http://localhost:3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Frontend is now working at http://localhost:3000
) else (
    echo ⏳ Frontend may still be building. Check logs:
    echo    docker-compose -f %COMPOSE_FILE% logs frontend
)

echo.
echo 🎉 Frontend fix completed!
pause