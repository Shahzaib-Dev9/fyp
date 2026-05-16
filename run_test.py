import sys
import importlib.util

# dynamically import mock-backend.py
spec = importlib.util.spec_from_file_location("mock_backend", "mock-backend.py")
mock_backend = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mock_backend)

print("Testing RealDeepfakeDetectionModel Initialization...")
model = mock_backend.RealDeepfakeDetectionModel

print("Loading models...")
model.load_models()

print("\nRunning a dummy inference test...")
# Create a dummy image to test inference
import numpy as np
from PIL import Image

# Create a random image
dummy_img_array = np.random.randint(0, 255, (300, 300, 3), dtype=np.uint8)
dummy_img = Image.fromarray(dummy_img_array)

# Save temporarily
dummy_img.save("test_dummy.jpg")

res = model.analyze_file("test_dummy.jpg", "image")
print("\nInference Result:")
for key, value in res.items():
    if key != "frame_scores":
        print(f"{key}: {value}")
