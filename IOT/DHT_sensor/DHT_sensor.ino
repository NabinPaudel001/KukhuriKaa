#include <WiFi.h>
#include <Firebase_ESP_Client.h>

#define WIFI_SSID "ASUS"
#define WIFI_PASSWORD "123456789"
#define API_KEY "AIzaSyAZnDWsLjoKobHhJdIJWB59lD29kuzXgAU"
#define DATABASE_URL "https://kukhurikaa-66d69-default-rtdb.asia-southeast1.firebasedatabase.app/"

/*Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "sunilnath0109@gmail.com"
#define USER_PASSWORD "123456789"

// Libs for Dht sensors.
#include <DHT.h>
#include <DHT_U.h>
// Provide the token generation process info.
#include <addons/TokenHelper.h>
// Provide thde RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

DHT dht(4, DHT11);

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis =0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(921600);
  Serial.println("Connecting to WiFi...");

  WiFi.begin(WIFI_SSID,WIFI_PASSWORD);  // Start connecting to Wi-Fi

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".n");
  }

  Serial.println("\nConnected to WiFi!");
  Serial.printf("IP Address: %s\n", WiFi.localIP().toString().c_str());


  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token 
  generation task */
  config.token_status_callback = tokenStatusCallback;
  // see addons/TokenHelper.h

  // Comment or pass false value when WiFi reconnection will
  // control by your code or third party library e.g. WiFiManager
  Firebase.reconnectNetwork(true);

  // Since v4.4.x, BearSSL engine was used, the SSL buffer
  //need to be set.
  // Large data transmission may require larger RX buffer,
  //otherwise connection issue or data read time out can
  //be occurred.
  fbdo.setBSSLBufferSize(4096 /* Rx buffer size in bytes 
  from 512 - 16384 */
                         ,
                         1024 /* Tx buffer size in bytes 
  from 512 - 16384 */
  );

  // for debugging.
  Serial.println("hello from end of the setup");

  Firebase.begin(&config, &auth);
  Firebase.setDoubleDigits(5);

  // for dht sensor
  dht.begin();
  delay(3000);
}

void loop() {

  // for debugging.
  Serial.println("hello from Loop");

  // for dht 11 sensor
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  int warning = 0;

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  if (Firebase.ready()  //&& (millis() - sendDataPrevMillis > 15000
      /*|| sendDataPrevMillis == 0)*/) {
    //sendDataPrevMillis = millis();

    Firebase.RTDB.setFloat(&fbdo, "/test/humidity", humidity);
    Firebase.RTDB.setFloat(&fbdo, "/test/temp", temperature);

    // for warning system.
    Firebase.RTDB.setInt(&fbdo, "/test/warning", warning);
    delay(1000);
  }

  Serial.print("Humidity: ");
  Serial.print(humidity);
  Serial.print(" %\t");
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" °C\t");
  Serial.print("\n");
  delay(1000);
  // yeild is used to pass control to other task if
  // loop is too long
  yield();
}