#include <WiFi.h>
#include <WebSocketsClient.h>
#include <DHT.h>
#include <DHT_U.h>

#ifndef LED_BUILTIN
#define LED_BUILTIN 2  // Define the built-in LED pin for your board
#endif

// Wi-Fi credentials
#define WIFI_SSID "ASUS"
#define WIFI_PASSWORD "123456789"

WebSocketsClient webSocket;
DHT dht(4, DHT22);

// Timers
unsigned long lastDataSendTime = 0;
unsigned long lastSensorReadTime = 0;
const unsigned long dataSendInterval = 5000; // Send data every 15 seconds
const unsigned long sensorReadInterval = 2000; // Read sensor every 2 seconds

void webSocketEvent(WStype_t type, uint8_t *payload, size_t length) {
  if (type == WStype_CONNECTED) {
    Serial.println("WebSocket connected");
  } else if (type == WStype_DISCONNECTED) {
    Serial.println("WebSocket disconnected");
  } else if (type == WStype_TEXT) {
    String command = String((char *)payload);
    Serial.println("Received message: " + command);
    if (command == "turn_on") {
      digitalWrite(LED_BUILTIN, HIGH);
    } else if (command == "turn_off") {
      digitalWrite(LED_BUILTIN, LOW);
    }
  }
}

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);

  Serial.begin(115200);

  // Connect to Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected to WiFi!");
  Serial.printf("IP Address: %s\n", WiFi.localIP().toString().c_str());

  // Initialize WebSocket
  webSocket.begin("192.168.137.11", 4000);  // Replace with your server IP and port
  webSocket.onEvent(webSocketEvent);

  // Initialize DHT sensor
  dht.begin();
  delay(3000);  // Wait for DHT sensor initialization
}

void loop() {
  webSocket.loop();  // Handle WebSocket events

  unsigned long currentMillis = millis();

  // Read sensor data at intervals
  if (currentMillis - lastSensorReadTime >= sensorReadInterval) {
    lastSensorReadTime = currentMillis;

    float humidity = dht.readHumidity();
    float temperature = dht.readTemperature();

    if (isnan(humidity) || isnan(temperature)) {
      Serial.println("Failed to read from DHT sensor!");
      return;
    }

    // Print sensor data for debugging
    Serial.print("Humidity: ");
    Serial.print(humidity);
    Serial.print(" %\t");
    Serial.print("Temperature: ");
    Serial.print(temperature);
    Serial.println(" °C\t");
  }

  // Send data to WebSocket server at intervals
  if (currentMillis - lastDataSendTime >= dataSendInterval) {
    lastDataSendTime = currentMillis;

    float humidity = dht.readHumidity();
    float temperature = dht.readTemperature();

    if (!isnan(humidity) && !isnan(temperature)) {
      String jsonData = "{\"humidity\": " + String(humidity) + ", \"temperature\": " + String(temperature) + "}";
      webSocket.sendTXT(jsonData);
      Serial.println("Data sent: " + jsonData);
    }
  }

  yield();  // Allow other tasks to run
}
