@echo off
REM DeepFake Detection System - Troubleshooting Script

echo 🔧 DeepFake Detection System Troubleshooting
echo ================================================

REM Detect which compose file to use
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    set COMPOSE_FILE=docker-compose.yml
) else (
    set COMPOSE_FILE=docker-compose.cpu.yml
)

echo Current compose file: %COMPOSE_FILE%
echo.

:menu
echo Select troubleshooting option:
echo 1. Check service status
echo 2. View all logs
echo 3. View frontend logs
echo 4. View backend logs
echo 5. View inference logs
echo 6. Restart all services
echo 7. Restart specific service
echo 8. Clean rebuild (removes all data)
echo 9. Check Docker resources
echo 0. Exit
echo.
set /p choice="Enter your choice (0-9): "

if "%choice%"=="1" goto check_status
if "%choice%"=="2" goto view_all_logs
if "%choice%"=="3" goto view_frontend_logs
if "%choice%"=="4" goto view_backend_logs
if "%choice%"=="5" goto view_inference_logs
if "%choice%"=="6" goto restart_all
if "%choice%"=="7" goto restart_specific
if "%choice%"=="8" goto clean_rebuild
if "%choice%"=="9" goto check_resources
if "%choice%"=="0" goto exit
goto menu

:check_status
echo 📊 Checking service status...
docker-compose -f %COMPOSE_FILE% ps
echo.
goto menu

:view_all_logs
echo 📝 Viewing all logs (Press Ctrl+C to stop)...
docker-compose -f %COMPOSE_FILE% logs -f
goto menu

:view_frontend_logs
echo 📝 Viewing frontend logs (Press Ctrl+C to stop)...
docker-compose -f %COMPOSE_FILE% logs -f frontend
goto menu

:view_backend_logs
echo 📝 Viewing backend logs (Press Ctrl+C to stop)...
docker-compose -f %COMPOSE_FILE% logs -f backend
goto menu

:view_inference_logs
echo 📝 Viewing inference logs (Press Ctrl+C to stop)...
docker-compose -f %COMPOSE_FILE% logs -f inference
goto menu

:restart_all
echo 🔄 Restarting all services...
docker-compose -f %COMPOSE_FILE% restart
echo ✅ All services restarted
echo.
goto menu

:restart_specific
echo Available services: frontend, backend, inference, redis
set /p service="Enter service name to restart: "
echo 🔄 Restarting %service%...
docker-compose -f %COMPOSE_FILE% restart %service%
echo ✅ %service% restarted
echo.
goto menu

:clean_rebuild
echo ⚠️  WARNING: This will remove all containers, volumes, and rebuild everything
set /p confirm="Are you sure? (y/N): "
if /i "%confirm%"=="y" (
    echo 🧹 Cleaning up and rebuilding...
    docker-compose -f %COMPOSE_FILE% down -v --rmi local
    docker-compose -f %COMPOSE_FILE% up --build -d
    echo ✅ Clean rebuild completed
) else (
    echo ❌ Operation cancelled
)
echo.
goto menu

:check_resources
echo 💾 Docker resource usage:
docker system df
echo.
echo 🐳 Running containers:
docker ps
echo.
echo 📊 Docker stats (Press Ctrl+C to stop):
docker stats
goto menu

:exit
echo 👋 Goodbye!
exit /b 0