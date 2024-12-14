import mongoose from "mongoose";

const feedSchema = new mongoose.Schema({
    company: { type: String, required: true },        // Company that provided the feed
    grainType: { type: String, required: true },      // Type of grain (e.g., corn, wheat)
    weight: { type: Number, required: true },         // Weight of the feed (in kg)
    price: { type: Number, required: true },          // Price of the feed (in currency)
    date: { type: Date, default: Date.now }           // Date the feed was provided
}, { _id: false });  // Disable creating a new _id for each feed record.

const chickenSchema = new mongoose.Schema({
    userId: { type: String, required: true },
    type: { type: String, required: true },
    numberPurchased: { type: Number, required: true },
    purchasePrice: { type: Number, required: true },
    growthStartDate: { type: Date, default: Date.now },
    soldCount: { type: Number, default: 0 },
    mortalityCount: { type: Number, default: 0 },
    supplier: {
        type: String,
        required: true,
    },
    feedDetails: [feedSchema], // New field to track feed information for the chickens
});

export default mongoose.model("Chicken", chickenSchema);
