import admin from "firebase-admin";
import serviceAccount from "./kukhurikaa-66d69-firebase-adminsdk-5q9se-601219f1fb.json" assert { type: "json" };

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

console.log("Firebase Admin Initialized Successfully");
//to check if the admin has been initialized successfully
console.log(admin)

export default admin;