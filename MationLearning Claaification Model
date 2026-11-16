from ultralytics import YOLO
import cv2

model = YOLO("yolov8n.pt")

# your image path
image_path = r"E:\Projects\Final year 2025\Phase 2\Phase2FY_ML\image2.jpg"

results = model(image_path)

image = cv2.imread(image_path)

names = model.names

stationary = 0
moving = 0
fast = 0

for box in results[0].boxes:

    x1, y1, x2, y2 = map(int, box.xyxy[0])
    cls = int(box.cls[0])
    conf = float(box.conf[0])  # YOLO confidence score
    label = names[cls]

    # behavior classification rule
    if label == "truck":
        status = "Fast"
        fast += 1
    elif label in ["car", "bus", "motorcycle", "bicycle"]:
        status = "Moving"
        moving += 1
    else:
        status = "Stationary"
        stationary += 1

    text = f"{label} {conf:.2f} | {status}"

    cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)

    cv2.putText(
        image,
        text,
        (x1, y1 - 10),
        cv2.FONT_HERSHEY_SIMPLEX,
        0.6,
        (0, 255, 0),
        2
    )

# calculate percentages
total = stationary + moving + fast

if total > 0:
    st_pct = int((stationary/total)*100)
    mv_pct = int((moving/total)*100)
    fs_pct = int((fast/total)*100)
else:
    st_pct = mv_pct = fs_pct = 0

summary1 = f"Stationary: {st_pct}%"
summary2 = f"Moving: {mv_pct}%"
summary3 = f"Fast: {fs_pct}%"

# bottom-right placement
h, w, _ = image.shape

cv2.putText(image, summary1, (w-300, h-80),
            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2)

cv2.putText(image, summary2, (w-300, h-50),
            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2)

cv2.putText(image, summary3, (w-300, h-20),
            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2)

image = cv2.resize(image, (900, 600))

cv2.imshow("Detection", image)
cv2.waitKey(0)
cv2.destroyAllWindows()
