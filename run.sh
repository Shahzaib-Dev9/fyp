#!/bin/bash

# DeepFake Detection System - Quick Start Script

set -e

echo "🚀 Starting DeepFake Detection System..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your configurations before running in production!"
fi

# Detect GPU availability
if command -v nvidia-smi &> /dev/null; then
    echo "🎮 NVIDIA GPU detected. Using GPU-enabled configuration..."
    COMPOSE_FILE="docker-compose.yml"
else
    echo "💻 No GPU detected. Using CPU-only configuration..."
    COMPOSE_FILE="docker-compose.cpu.yml"
fi

# Build and start services
echo "🔨 Building and starting services..."
docker-compose -f $COMPOSE_FILE up --build -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
echo "This may take a few minutes for first-time setup..."
sleep 60

# Additional wait for frontend build
echo "⏳ Waiting for frontend build to complete..."
sleep 30

# Check service health
echo "🔍 Checking service health..."

# Check Frontend
echo "🔍 Checking frontend status..."
if curl -f http://localhost:3000 > /dev/null 2>&1; then
    echo "✅ Frontend is running at http://localhost:3000"
else
    echo "⚠️  Frontend may still be building. Check logs: docker-compose logs frontend"
    echo "🔄 Frontend will be available shortly at http://localhost:3000"
fi

# Check Backend
echo "🔍 Checking backend API..."
if curl -f http://localhost:8000/api/v1/health > /dev/null 2>&1; then
    echo "✅ Backend API is running at http://localhost:8000"
    echo "📚 API Documentation: http://localhost:8000/docs"
else
    echo "⚠️  Backend API may still be starting. Check logs: docker-compose logs backend"
    echo "🔄 API will be available shortly at http://localhost:8000"
fi

# Check Inference Service
echo "🔍 Checking inference service..."
if curl -f http://localhost:8001/health > /dev/null 2>&1; then
    echo "✅ Inference Service is running at http://localhost:8001"
else
    echo "⚠️  Inference Service may still be loading models. Check logs: docker-compose logs inference"
    echo "🔄 Service will be available shortly at http://localhost:8001"
fi

echo ""
echo "🎉 DeepFake Detection System is ready!"
echo ""
echo "🌐 Web Application: http://localhost:3000"
echo "🔧 API Documentation: http://localhost:8000/docs"
echo "⚙️  Admin Panel: http://localhost:3000/admin"
echo ""
echo "📊 To view logs: docker-compose -f $COMPOSE_FILE logs -f"
echo "🔍 To check specific service: docker-compose -f $COMPOSE_FILE logs [frontend|backend|inference]"
echo "🛑 To stop: docker-compose -f $COMPOSE_FILE down"
echo "🔄 To restart: docker-compose -f $COMPOSE_FILE restart"
echo "🧹 To clean up: docker-compose -f $COMPOSE_FILE down -v --rmi local"
echo ""
echo "⚠️  Default admin credentials:"
echo "   Username: admin"
echo "   Password: change-this-password"
echo "   Please change these in production!"