# 🚗 ADAPTIVE CRUISE CONTROL (ACC)

**Embedded Vehicle Control System**

---

## 📌 Problem Statement

Conventional cruise control systems maintain a constant vehicle speed but do not account for traffic conditions. This can lead to unsafe following distances and frequent driver intervention.
This project implements an **Adaptive Cruise Control (ACC)** system that automatically adjusts vehicle speed to maintain a safe distance from the vehicle ahead.

---

## 🎯 Objective

* Measure distance to the preceding vehicle
* Maintain a predefined safe following distance
* Automatically adjust vehicle speed based on traffic conditions
* Reduce driver workload while improving safety

---

## 🧩 System Overview

The ACC system continuously monitors the distance to the vehicle ahead using a distance sensor. Based on this input, a control algorithm adjusts the vehicle’s speed by increasing or decreasing throttle (or motor speed) to maintain a safe gap.

---

## 🛠 Hardware Components

* Distance sensor (Ultrasonic / IR / Radar – prototype level)
* Microcontroller (Arduino / equivalent)
* Motor driver / throttle control interface
* DC motor / BLDC motor (vehicle model)
* Power supply

---

## 💻 Software & Tools

* Embedded C / Arduino IDE
* Control logic based on distance thresholds
* Serial communication for monitoring and debugging

---

## ⚙️ Methodology

1. Distance to the leading vehicle is measured using the sensor
2. Measured distance is compared with a predefined safe distance
3. If distance decreases below threshold, speed is reduced
4. If distance increases beyond threshold, speed is increased
5. Control loop runs continuously for real-time response

---

## 📊 Results

* Successful detection of obstacles/vehicles ahead
* Automatic speed adjustment based on distance variation
* Stable system response under controlled test conditions

---

## ⚠️ Limitations

* Sensor accuracy affected by noise and environmental conditions
* No vehicle-to-vehicle communication
* Fixed threshold-based control (no adaptive control tuning)
* Prototype-level implementation

---

## 🔮 Future Improvements

* PID-based speed control
* Sensor fusion (radar + camera)
* Vehicle-to-vehicle (V2V) communication
* Integration with braking system
* Real-time testing on full-scale vehicle platform

---

## 👤 My Role

* System design and control logic development
* Sensor interfacing and calibration
* Embedded programming and testing
* Performance evaluation and documentation

