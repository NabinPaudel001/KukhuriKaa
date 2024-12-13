import Chicken from '../models/chicken.model.js';
import asyncHandler from "../utils/asyncHandler.js";
import { ApiError } from "../utils/apiError.js";
import ApiResponse from "../utils/apiResponse.js";

export const addChicken = asyncHandler(async (req, res) => {
    const { type, numberPurchased, purchasePrice } = req.body;

    const chicken = new Chicken({ userId: req.userId, type, numberPurchased, purchasePrice });
    await chicken.save();
    res.status(201).json(new ApiResponse(201, chicken, 'Chicken added successfully'));
});

export const getChickens = asyncHandler(async (req, res) => {
    const chickens = await Chicken.find({ userId: req.userId });
    res.status(200).json(new ApiResponse(200, chickens, 'Chickens retrieved successfully'));
});  

export const updateChicken = asyncHandler(async (req, res) => {
    const chicken = await Chicken.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.status(200).json(new ApiResponse(200, chicken, 'Chicken updated successfully'));
});

