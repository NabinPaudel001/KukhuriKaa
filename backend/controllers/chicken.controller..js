import Chicken from '../models/chicken.model.js';
import asyncHandler from "../utils/asyncHandler.js";
import { ApiError } from "../utils/apiError.js";
import ApiResponse from "../utils/apiResponse.js";

// Add a new chicken along with feed details
export const addChicken = asyncHandler(async (req, res) => {
    const { type, numberPurchased, purchasePrice, feedDetails } = req.body;

    // Create a new chicken document with the provided data
    const chicken = new Chicken({
        userId: req.userId,
        type,
        numberPurchased,
        purchasePrice,
        feedDetails: feedDetails || []  // If no feed details are provided, set to empty array
    });

    // Save the chicken document to the database
    await chicken.save();

    // Respond with the created chicken data
    res.status(201).json(new ApiResponse(201, chicken, 'Chicken added successfully'));
});

// Get all chickens for the authenticated user
export const getChickens = asyncHandler(async (req, res) => {
    const chickens = await Chicken.find({ userId: req.userId });

    // Check if chickens are found
    if (!chickens || chickens.length === 0) {
        throw new ApiError(404, 'No chickens found for the user');
    }

    res.status(200).json(new ApiResponse(200, chickens, 'Chickens retrieved successfully'));
});

//update feed details for a chicken
export const updateFeedDetails = asyncHandler(async (req, res) => {
    const { feedDetails } = req.body;
    const { chickenId } = req.params;

    // Find the chicken document by id
    const chicken = await Chicken.findById(chickenId);

    // Check if chicken is found
    if (!chicken) {
        throw new ApiError(404, 'Chicken not found');
    }

    // Update the feed details for the chicken
    chicken.feedDetails = feedDetails;

    // Save the updated chicken document
    await chicken.save();

    res.status(200).json(new ApiResponse(200, chicken, 'Feed details updated successfully'));
});

//update chicken sold details
//update chicken details according to the provided data
//update chicken details according to the provided data
