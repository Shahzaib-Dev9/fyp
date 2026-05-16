@echo off
echo ========================================
echo     DeepFake Detection System - Enhanced
echo ========================================
echo.
echo Starting enhanced mock backend with improved features:
echo - Decreased accuracy for detected deepfakes
echo - Higher accuracy for authentic content  
echo - Perfect accuracy for webcam captures
echo - PDF report generation
echo - Working admin features (retrain/logs)
echo.

REM Start the enhanced mock backend
echo 🚀 Starting Enhanced Mock Backend...
echo 📍 Backend API: http://localhost:8000
echo 📚 API Documentation: http://localhost:8000/docs
echo 🎯 Enhanced Features: Webcam + PDF + Admin
echo.

start "DeepFake Backend" cmd /k "cd /d %~dp0 && python mock-backend.py"

REM Give backend time to start
timeout /t 3 >nul

REM Start the frontend server
echo 🌐 Starting Frontend Server...
echo 📍 Frontend URL: http://localhost:3001
echo 🔧 Enhanced UI with webcam capture
echo.

cd frontend\public
start "DeepFake Frontend" cmd /k "python -m http.server 3001"

REM Give frontend time to start
timeout /t 2 >nul

REM Open the enhanced demo in browser
echo 🔗 Opening Enhanced Demo in Browser...
start http://localhost:3001/demo.html

echo.
echo ✅ Enhanced DeepFake Detection System Started!
echo 📱 Features Available:
echo    - File Upload Analysis with Enhanced Accuracy
echo    - Live Webcam Detection with Perfect Accuracy  
echo    - PDF Report Generation
echo    - Working Admin Dashboard (Retrain/Logs)
echo    - Improved UI/UX with Progress Tracking
echo.
echo 📖 Usage Instructions:
echo    1. Upload files: Authentic content gets high scores (85-96%%)
echo    2. Upload deepfakes: Detected fakes get lower scores (52-75%%)
echo    3. Webcam capture: Perfect accuracy for live detection (90-98%%)
echo    4. Download PDF reports instead of JSON
echo    5. Use admin features to retrain model and view logs
echo.
echo Press any key to exit...
pause >nul