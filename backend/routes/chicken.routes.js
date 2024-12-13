import express from "express";
import {
  addChicken,
  getChickens,
  updateChicken,
} from "../controllers/chicken.controller..js";
import verifyFirebaseToken from "../middlewares/firebaseAuth.middleware.js";

const router = express.Router();

router.use(verifyFirebaseToken); // Protect all routes

router.post("/", addChicken);
router.get("/", getChickens);
router.patch("/:id", updateChicken);

export default router;
