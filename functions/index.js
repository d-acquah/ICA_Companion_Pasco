const functions = require("firebase-functions"); // Import functions
const admin = require("firebase-admin"); // Import admin SDK
const paystackApi = require("paystack-api"); // Import Paystack API

admin.initializeApp(); // Initialize admin SDK

let paystack;

// Initialize Paystack dynamically
function getPaystack() {
  if (!paystack) {
    const secretKey = functions.config().paystack.secretkey;
    if (!secretKey) {
      throw new Error("Paystack secret key is not defined in Firebase Config.");
    }
    paystack = paystackApi(secretKey);
  }
  return paystack;
}

const createPlan = async (planDetails) => {
  try {
    const paystack = getPaystack();
    const response = await paystack.plans.create(planDetails);
    return response.data;
  } catch (error) {
    console.error("Error creating plan:", error);
    throw error;
  }
};

const planDetails = {
  name: "Monthly Subscription",
  amount: 1000, // In the lowest unit of currency (e.g., kobo for Naira)
  interval: "monthly",
  currency: "GHS",
};

createPlan(planDetails).then((plan) => {
  console.log("Plan created successfully:", plan);
}).catch((error) => {
  console.error("Failed to create plan:", error);
});

exports.handleWebhook = functions.https.onRequest(async (req, res) => {
  const event = req.body.event;
  try {
    switch (event) {
      case "charge.success":
        await handleChargeSuccess(req.body.data);
        break;
      case "subscription.cancelled":
        await handleSubscriptionCancelled(req.body.data);
        break;
      // Handle other events as needed
      default:
        console.log("Unhandled event:", event);
    }
    res.status(200).send("Event handled");
  } catch (error) {
    console.error("Error handling webhook event:", error);
    res.status(500).send("Error handling event");
  }
});

const handleChargeSuccess = async (data) => {
  const userId = data.customer.id; // Assuming customer ID maps to user ID
  const expireDate = new Date();
  expireDate.setMonth(expireDate.getMonth() + 1);
  // Set expiration date for 1 month later

  try {
    await admin.firestore().collection("users").doc(userId).update({
      subscription: {
        isActive: true,
        planId: data.plan,
        expireDate: expireDate,
      },
    });
    console.log("Subscription updated successfully for user:", userId);
  } catch (error) {
    console.error("Error updating subscription for user:", userId, error);
    throw error;
  }
};

const handleSubscriptionCancelled = async (data) => {
  const userId = data.customer.id;
  try {
    await admin.firestore().collection("users").doc(userId).update({
      "subscription.isActive": false,
      "subscription.planId": null,
      "subscription.expireDate": null,
    });
    console.log("Subscription cancelled for user:", userId);
  } catch (error) {
    console.error("Error cancelling subscription for user:", userId, error);
    throw error;
  }
};
