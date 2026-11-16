from ultralytics import YOLO
import cv2

model = YOLO("yolov8n.pt")

image_path = r"E:\Projects\Final year 2025\Phase 2\ML\image6.jpg"

results = model(image_path)

annotated = results[0].plot()

# resize to standard display size
annotated = cv2.resize(annotated, (900, 600))

cv2.imshow("Detection", annotated)

cv2.waitKey(0)
cv2.destroyAllWindows()
