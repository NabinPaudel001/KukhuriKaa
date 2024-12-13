import mongoose from "mongoose";

const chickenSchema = new mongoose.Schema({
    userId: { type: String, required: true },
    type: { type: String, required: true },
    numberPurchased: { type: Number, required: true },
    purchasePrice: { type: Number, required: true },
    growthStartDate: { type: Date, default: Date.now },
    soldCount: { type: Number, default: 0 },
    mortalityCount: { type: Number, default: 0 },
    profitOrLoss: { type: Number, default: 0 },
});

export default mongoose.model("Chicken", chickenSchema);
