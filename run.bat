@echo off
REM DeepFake Detection System - Windows Quick Start Script

echo 🚀 Starting DeepFake Detection System...

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Compose is not installed. Please install Docker Compose first.
    pause
    exit /b 1
)

REM Create .env file if it doesn't exist
if not exist .env (
    echo 📝 Creating .env file from template...
    copy .env.example .env
    echo ⚠️  Please edit .env file with your configurations before running in production!
)

REM Detect GPU availability
nvidia-smi >nul 2>&1
if %errorlevel% equ 0 (
    echo 🎮 NVIDIA GPU detected. Using GPU-enabled configuration...
    set COMPOSE_FILE=docker-compose.yml
) else (
    echo 💻 No GPU detected. Using CPU-only configuration...
    set COMPOSE_FILE=docker-compose.cpu.yml
)

REM Build and start services
echo 🔨 Building and starting services...
docker-compose -f %COMPOSE_FILE% up --build -d

REM Wait for services to be ready
echo ⏳ Waiting for services to start...
echo This may take a few minutes for first-time setup...
timeout /t 60 /nobreak >nul

REM Additional wait for frontend build
echo ⏳ Waiting for frontend build to complete...
timeout /t 30 /nobreak >nul

REM Check service health
echo 🔍 Checking service health...

REM Check Frontend
echo 🔍 Checking frontend status...
curl -f http://localhost:3000 >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Frontend is running at http://localhost:3000
) else (
    echo ⚠️  Frontend may still be building. Check logs: docker-compose logs frontend
    echo 🔄 Frontend will be available shortly at http://localhost:3000
)

REM Check Backend
echo 🔍 Checking backend API...
curl -f http://localhost:8000/api/v1/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Backend API is running at http://localhost:8000
    echo 📚 API Documentation: http://localhost:8000/docs
) else (
    echo ⚠️  Backend API may still be starting. Check logs: docker-compose logs backend
    echo 🔄 API will be available shortly at http://localhost:8000
)

REM Check Inference Service
echo 🔍 Checking inference service...
curl -f http://localhost:8001/health >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Inference Service is running at http://localhost:8001
) else (
    echo ⚠️  Inference Service may still be loading models. Check logs: docker-compose logs inference
    echo 🔄 Service will be available shortly at http://localhost:8001
)

echo.
echo 🎉 DeepFake Detection System is ready!
echo.
echo 🌐 Web Application: http://localhost:3000
echo 🔧 API Documentation: http://localhost:8000/docs
echo ⚙️  Admin Panel: http://localhost:3000/admin
echo.
echo 📊 To view logs: docker-compose -f %COMPOSE_FILE% logs -f
echo 🔍 To check specific service: docker-compose -f %COMPOSE_FILE% logs [frontend|backend|inference]
echo 🛑 To stop: docker-compose -f %COMPOSE_FILE% down
echo 🔄 To restart: docker-compose -f %COMPOSE_FILE% restart
echo 🧹 To clean up: docker-compose -f %COMPOSE_FILE% down -v --rmi local
echo.
echo ⚠️  Default admin credentials:
echo    Username: admin
echo    Password: change-this-password
echo    Please change these in production!
echo.
pause