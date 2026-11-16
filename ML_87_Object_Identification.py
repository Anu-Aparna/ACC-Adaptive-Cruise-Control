from ultralytics import YOLO
import cv2

model = YOLO("yolov8n.pt")

image_path = r"E:\Projects\Final year 2025\Phase 2\Phase2FY_ML\image6.jpg"

results = model(image_path)

image = cv2.imread(image_path)

names = model.names

stationary = 0
moving = 0
fast = 0

for box in results[0].boxes:

    cls = int(box.cls[0])
    label = names[cls]

    # simple rule example
    if label in ["car", "bus"]:
        moving += 1
    elif label in ["truck"]:
        fast += 1
    else:
        stationary += 1

total = stationary + moving + fast

if total > 0:
    st_pct = int((stationary/total)*100)
    mv_pct = int((moving/total)*100)
    fs_pct = int((fast/total)*100)

text1 = f"Stationary: {st_pct}%"
text2 = f"Moving: {mv_pct}%"
text3 = f"Fast: {fs_pct}%"

cv2.putText(image, text1, (20, 40),
            cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)
cv2.putText(image, text2, (20, 80),
            cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)
cv2.putText(image, text3, (20, 120),
            cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)

image = cv2.resize(image, (900, 600))

cv2.imshow("Detection", image)
cv2.waitKey(0)
cv2.destroyAllWindows()
