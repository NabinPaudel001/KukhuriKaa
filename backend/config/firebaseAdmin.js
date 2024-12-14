import admin from "firebase-admin";
import serviceAccount from "./firebaseServiceAccountKey.json" assert { type: "json" };

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

console.log("Firebase Admin Initialized Successfully");
//to check if the admin has been initialized successfully
console.log(admin)

export default admin;