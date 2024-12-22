#include <WiFi.h>
#include <DHT.h>
// #include <Firebase_ESP_Client.h>

// #ifndef LED_BUILTIN
// #define LED_BUILTIN 2  // Define the built-in LED pin for your board
// #endif

#define WIFI_SSID "ASUS"
#define WIFI_PASSWORD "123456789"
// #define API_KEY "AIzaSyAZnDWsLjoKobHhJdIJWB59lD29kuzXgAU"
// #define DATABASE_URL "https://kukhurikaa-66d69-default-rtdb.asia-southeast1.firebasedatabase.app/"

// /*Define the user Email and password that alreadey registerd or added in your project */
// #define USER_EMAIL "sunilnath0109@gmail.com"
// #define USER_PASSWORD "123456789"

#define DPIN 4             // Pin to connect DHT sensor (GPIO number)
#define DTYPE DHT22        // Define DHT 11 or DHT22 sensor type
// #define BLUE_LED_PIN 18     // Green LED pin (GPIO5)
// #define YELLOW_LED_PIN 21  // Yellow LED pin (GPIO19)


// Libs for Dht sensors.
// #include <DHT_U.h>
// Provide the token generation process info.
// #include <addons/TokenHelper.h>
// Provide thde RTDB payload printing info and other helper functions.
// #include <addons/RTDBHelper.h>

DHT dht(DPIN, DTYPE);

// FirebaseData fbdo;
// FirebaseAuth auth;
// FirebaseConfig config;

// unsigned long sendDataPrevMillis = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(921600);

  // pinMode(LED_BUILTIN, OUTPUT);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);  // Start connecting to Wi-Fi

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".n");
  }

  Serial.println("\nConnected to WiFi!");
  Serial.printf("IP Address: %s\n", WiFi.localIP().toString().c_str());

  // pinMode(BLUE_LED_PIN, OUTPUT);    // Set green LED pin as output
  // pinMode(YELLOW_LED_PIN, OUTPUT);  // Set yellow LED pin as output

  // digitalWrite(BLUE_LED_PIN, LOW);    // Turn off green LED initially
  // digitalWrite(YELLOW_LED_PIN, LOW);  // Turn off yellow LED initially



  // Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  // /* Assign the api key (required) */
  // config.api_key = API_KEY;

  // /* Assign the user sign in credentials */
  // auth.user.email = USER_EMAIL;
  // auth.user.password = USER_PASSWORD;

  // /* Assign the RTDB URL (required) */
  // config.database_url = DATABASE_URL;

  // /* Assign the callback function for the long running token 
  // generation task */
  // config.token_status_callback = tokenStatusCallback;
  // // see addons/TokenHelper.h

  // // Comment or pass false value when WiFi reconnection will
  // // control by your code or third party library e.g. WiFiManager
  // Firebase.reconnectNetwork(true);

  // // Since v4.4.x, BearSSL engine was used, the SSL buffer
  // //need to be set.
  // // Large data transmission may require larger RX buffer,
  // //otherwise connection issue or data read time out can
  // //be occurred.
  // fbdo.setBSSLBufferSize(4096 /* Rx buffer size in bytes 
  // from 512 - 16384 */
  //                        ,
  //                        1024 /* Tx buffer size in bytes 
  // from 512 - 16384 */
  // );

  // // for debugging.
  // Serial.println("hello from end of the setup");

  // Firebase.begin(&config, &auth);
  // Firebase.setDoubleDigits(5);


  // for dht sensor
  dht.begin();
  delay(4000);
}

void loop() {
  // Make sure WebSocket is checking for events
  // webSocket.loop();

  // Read data from DHT11 sensor
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  int warning = 0;

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  // Check if we should send data to Firebase
  // if (Firebase.ready()) {
    // Firebase.RTDB.setFloat(&fbdo, "/test/humidity", humidity);
    // Firebase.RTDB.setFloat(&fbdo, "/test/temp", temperature);

  //   // Example of setting a warning based on conditions
  //   if (humidity > 80 || temperature > 30) {
  //     warning = 1;  // Set a warning if conditions are met
  //   }

  //   Firebase.RTDB.setInt(&fbdo, "/test/warning", warning);
  //   delay(5000);  // Delay to avoid spamming Firebase
  // }


  // Debugging output
  Serial.print("Humidity: ");
  Serial.print(humidity);
  Serial.print(" %\t");
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" °C\t");

  delay(4000);  // Delay before reading again
  yield();      // Yield control to other tasks

  //   // If temperature is greater than 30°C, turn on the blue LED, turn off yellow
  // if (temperature > 30.0) {
  //   digitalWrite(BLUE_LED_PIN, HIGH);   // Turn on green LED
  //   digitalWrite(YELLOW_LED_PIN, LOW);   // Turn off yellow LED
  // }
  // // If temperature is less than or equal to 30°C, turn on the yellow LED, turn off green
  // else {
  //   digitalWrite(BLUE_LED_PIN, LOW);    // Turn off green LED
  //   digitalWrite(YELLOW_LED_PIN, HIGH);  // Turn on yellow LED
  // }
}
