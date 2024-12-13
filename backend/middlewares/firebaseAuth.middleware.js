// import admin from "../config/firebaseAdmin.js";
import asyncHandler from "../utils/asyncHandler.js";
import { ApiError } from "../utils/apiError.js";
import ApiResponse from "../utils/apiResponse.js";

const verifyFirebaseToken = async (req, res, next) => {
  const token = req.headers.authorization?.split(" ")[1];

  if (!token)
    return res.status(401).json(new ApiError(401, "Token not provided"));

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.userId = decodedToken.uid; // Attach UID to request object
    next();
  } catch (error) {
    return res.status(401).json(new ApiError(401, "Invalid token"));
  }
};

export default verifyFirebaseToken;
