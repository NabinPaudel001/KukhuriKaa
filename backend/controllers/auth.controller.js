import admin from "../config/firebaseAdmin.js";
import asyncHandler from "../utils/asyncHandler.js";
import { ApiError } from "../utils/apiError.js";
import ApiResponse from "../utils/apiResponse.js";

const auth = admin.auth();  // Firebase Authentication

export const register = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  try {
    // Register user with Firebase Authentication
    const userRecord = await auth.createUser({ email, password });

    // Generate a token for the newly created user
    const customToken = await auth.createCustomToken(userRecord.uid);

    res.status(201).json(
      new ApiResponse(201, { uid: userRecord.uid, token: customToken }, "User created successfully")
    );
  } catch (error) {
    throw new ApiError(400, `Error occurred during registration: ${error.message}`);
  }
});

export const login = asyncHandler(async (req, res) => {
    const { email, password } = req.body;
  
    try {
      // Sign in user with Firebase Authentication
      const userRecord = await auth.getUserByEmail(email);
  
      // You should verify the password on the frontend, not in the backend.
      // Firebase Authentication does not allow password verification in the backend.
      // Instead, use Firebase SDK on the frontend to sign in and get a token.
      const customToken = await auth.createCustomToken(userRecord.uid);
  
      res.status(200).json(
        new ApiResponse(200, { uid: userRecord.uid, token: customToken }, "User logged in successfully")
      );
    } catch (error) {
      throw new ApiError(400, `Error occurred during login: ${error.message}`);
    }
  });
  