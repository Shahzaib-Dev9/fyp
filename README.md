# DeepFake Detection System

A production-ready deepfake detection system that uses ResNet + LSTM architecture to analyze videos and images for authenticity.

## Features

- **Video/Image Upload**: Support for MP4, MOV, JPG, PNG formats
- **Webcam Capture**: Real-time capture and analysis
- **AI-Powered Detection**: ResNet + LSTM model trained on DFDC, FaceForensics++, Celeb-DF
- **Explainable Results**: Per-frame analysis with heatmaps and confidence scores
- **Admin Dashboard**: Model management and retraining capabilities
- **Privacy-First**: No persistent storage of uploads by default
- **Production-Ready**: Containerized with Docker, GPU-optimized

## Quick Start

### Option 1: One-Command Startup (Recommended)

**Windows:**
```batch
run.bat
```

**Linux/Mac:**
```bash
chmod +x run.sh
./run.sh
```

### Option 2: Manual Docker Startup

```bash
# GPU-enabled (if NVIDIA GPU available)
docker-compose up --build

# CPU-only (fallback)
docker-compose -f docker-compose.cpu.yml up --build
```

### Troubleshooting

If you encounter issues:

**Windows:**
```batch
# Interactive troubleshooting menu
troubleshoot.bat

# Quick frontend fix
fix-frontend.bat
```

**Common Issues:**
- Frontend build taking long: Wait 2-3 minutes for initial build
- Services not responding: Check logs with `docker-compose logs [service-name]`
- Port conflicts: Ensure ports 3000, 8000, 8001 are available

Visit `http://localhost:3000` to access the application.

## Project Structure

```
deepfake/
├── frontend/           # React TypeScript frontend
├── backend/           # FastAPI backend
├── inference/         # Model serving service
├── models/           # Training scripts and model artifacts
├── infra/            # Docker and deployment configs
├── docs/             # Documentation
└── ci/               # CI/CD pipelines
```

## Documentation

- [Setup Guide](docs/setup.md)
- [Model Training](docs/training.md)
- [Deployment Guide](docs/deployment.md)
- [API Documentation](docs/api.md)
- [Ethics & Privacy](docs/ethics.md)

## License


MIT License - See [LICENSE](LICENSE) for details.
