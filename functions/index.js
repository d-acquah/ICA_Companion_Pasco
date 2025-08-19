const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.paystackWebhook = functions.https.onRequest(async (req, res) => {
  const event = req.body;

  console.log("🔔 Webhook event received:", event.event);

  if (event.event === 'charge.success') {
    try {
      const customFields = event.data?.metadata?.custom_fields || [];
      console.log("🧩 Full custom_fields received:", JSON.stringify(customFields, null, 2));

      // Extract the Firebase UID from metadata
      const firebaseUidField = customFields.find(field => field.variable_name === 'firebase_uid');
      const firebaseUid = firebaseUidField?.value;

      if (!firebaseUid) {
        console.error("❌ Missing or invalid Firebase UID");
        return res.status(400).send("Missing Firebase UID");
      }

      const now = admin.database.ServerValue.TIMESTAMP;
      const subscriptionLengthInDays = 30;
      const subscriptionEnd = Date.now() + subscriptionLengthInDays * 24 * 60 * 60 * 1000;


      // ✅ Update the user's data in Realtime Database
      const userRef = admin.database().ref(`users/${firebaseUid}`);

      await userRef.update({
        isPremium: true,
        subscriptionStart: now,
        subscriptionEnd: subscriptionEnd
      });

      console.log(`✅ Premium subscription updated for UID: ${firebaseUid}`);
      return res.status(200).send("User upgraded to premium");
    } catch (err) {
      console.error("🔥 Error updating Realtime Database:", err);
      return res.status(500).send("Internal server error");
    }
  }

  res.status(200).send("Unhandled event");
});
