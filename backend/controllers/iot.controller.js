import admin from "../config/firebaseAdmin.js";
import asyncHandler from "../utils/asyncHandler.js";
import { ApiError } from "../utils/apiError.js";
import ApiResponse from "../utils/apiResponse.js";

export const getSensorData = asyncHandler(async (req, res) => {
  const doc = await admin
    .firestore()
    .collection("sensorData")
    .doc(req.userId)
    .get();

  if (!doc.exists) throw new ApiError(404, "No IoT data found");

  res
    .status(200)
    .json(
      new ApiResponse(200, doc.data(), "Sensor data retrieved successfully")
    );
});
