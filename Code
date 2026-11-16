#include <Servo.h>
#include <Wire.h>
#include <MPU6050.h>
#include <LiquidCrystal_I2C.h>

/* -------- Pins -------- */
#define TRIG_PIN   8
#define ECHO_PIN   9
#define ESC_PIN    3
#define BRAKE_PIN  7
#define VIB_PIN    6
#define BUZZER_PIN 5
#define LED_PIN    12

Servo esc;
MPU6050 mpu;
LiquidCrystal_I2C lcd(0x27, 16, 2);

/* -------- Variables -------- */
long duration;
int distance;

int16_t ax, ay, az;
bool fallDetected = false;

int currentPWM = 1000;   // To track motor speed sent to ESC

/* -------- Serial Send Function -------- */
void sendSerial()
{
  Serial.print(distance); Serial.print(":");
  Serial.print(digitalRead(BRAKE_PIN)); Serial.print(":");
  Serial.print(digitalRead(VIB_PIN)); Serial.print(":");
  Serial.print(fallDetected ? 1 : 0); Serial.print(":");
  Serial.println(currentPWM);
}

/* -------- Stop Motor Function -------- */
void stopMotor(String reason) {
  currentPWM = 1000;
  esc.writeMicroseconds(1000);

  digitalWrite(BUZZER_PIN, HIGH);
  digitalWrite(LED_PIN, HIGH);

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("MOTOR STOPPED");
  lcd.setCursor(0, 1);
  lcd.print(reason);

  sendSerial();   // Send stopped status
  Serial.println(reason);

  delay(300);
}

void setup() {
  Serial.begin(9600);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BRAKE_PIN, INPUT_PULLUP);
  pinMode(VIB_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(LED_PIN, OUTPUT);

  esc.attach(ESC_PIN);

  lcd.init();
  lcd.backlight();

  lcd.setCursor(0, 0);
  lcd.print("System Init...");

  // ---- ESC Arming ----
  esc.writeMicroseconds(1000);
  delay(3000);

  // ---- MPU Init ----
  Wire.begin();
  mpu.initialize();

  lcd.clear();
  lcd.print("Ready");
}

void loop() {

  /* -------- Brake Switch -------- */
  if (digitalRead(BRAKE_PIN) == LOW) {
    stopMotor("Brake Pressed");
    return;
  }

  /* -------- Vibration Sensor -------- */
  if (digitalRead(VIB_PIN) == LOW) {
    stopMotor("Vibration Alert");
    return;
  }

  /* -------- Read MPU -------- */
  mpu.getAcceleration(&ax, &ay, &az);

  fallDetected = false;

  if (ax > 15000 || ax < -15000 || ay > 15000 || ay < -15000) {
    fallDetected = true;
  }

  if (fallDetected) {
    stopMotor("Fall Detected");
    return;
  }

  /* -------- Ultrasonic -------- */
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  duration = pulseIn(ECHO_PIN, HIGH, 30000);
  distance = duration * 0.034 / 2;

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Distance:");
  lcd.print(distance);

  /* -------- Speed Control -------- */
  digitalWrite(BUZZER_PIN, LOW);
  digitalWrite(LED_PIN, LOW);

  if (distance > 150) {
    currentPWM = 1700;
    esc.writeMicroseconds(currentPWM);
    lcd.setCursor(0, 1);
    lcd.print("Speed: FAST ");
  }
  else if (distance > 100) {
    currentPWM = 1500;
    esc.writeMicroseconds(currentPWM);
    lcd.setCursor(0, 1);
    lcd.print("Speed: MED  ");
  }
  else if (distance > 50) {
    currentPWM = 1300;
    esc.writeMicroseconds(currentPWM);
    lcd.setCursor(0, 1);
    lcd.print("Speed: SLOW ");
  }
  else {
    stopMotor("Obstacle Near");
    return;
  }

  sendSerial();   // Send live running data

  delay(200);
}
