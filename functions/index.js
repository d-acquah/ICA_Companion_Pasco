const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.paystackWebhook = functions.https.onRequest(async (req, res) => {
  // Step 1: Only accept POST requests
  if (req.method !== "POST") {
    return res.status(405).send("Method Not Allowed");
  }

  try {
    const event = req.body;

    console.log("🔔 Webhook event received:", event.event);

    // Step 2: Handle only successful charge events
    if (event.event !== "charge.success") {
      console.log("ℹ️ Not a charge.success event. Skipping.");
      return res.status(200).send("Event ignored");
    }

    const data = event.data;

    // Step 3: Extract firebase_uid from custom_fields
    const customFields = data.metadata?.custom_fields;
    if (!Array.isArray(customFields)) {
      console.error("❌ custom_fields is not an array:", customFields);
      return res.status(400).send("Invalid custom_fields format");
    }

    console.log("🧩 Full custom_fields received:", JSON.stringify(customFields, null, 2));

    const uidField = customFields.find(
      field => field.variable_name === "firebase_uid"
    );

    if (!uidField || !uidField.value) {
      console.error("❌ Missing UID in webhook payload metadata.");
      return res.status(400).send("Missing UID");
    }

    const uid = uidField.value;

    if (!uid || typeof uid !== "string") {
      console.error("❌ Invalid UID format:", uid);
      return res.status(400).send("Invalid UID");
    }

    console.log("✅ UID extracted:", uid);
    console.log("🧾 About to write to Firestore at: users/" + uid);

    // Step 4: Convert paid_at to Firestore Timestamp
    const paidAt = admin.firestore.Timestamp.fromDate(new Date(data.paid_at));

    // Step 5: Build subscription object
    const subscriptionData = {
      subscription: {
        status: data.status,
        reference: data.reference,
        amount: data.amount / 100, // convert from Kobo to GHS
        currency: data.currency,
        paid_at: paidAt,
        payment_channel: data.channel,
        updated_at: admin.firestore.FieldValue.serverTimestamp()
      }
    };

    // Step 6: Update user's subscription in Firestore
    await admin.firestore()
      .collection("users")
      .doc(uid)
      .set(subscriptionData, { merge: true });

    console.log(`✅ Subscription updated in Firestore for UID: ${uid}`);
    return res.status(200).send("Subscription updated");
  } catch (error) {
    console.error("🔥 Error handling webhook:", error);
    return res.status(500).send("Internal Server Error");
  }
});