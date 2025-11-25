// Firebase config & init for shared database
// You created this config in Firebase console

// Load Firebase SDK from CDN via script tags in HTML before this file.
// Using compat style so we can use firebase.* in existing code.

var firebaseConfig = {
  apiKey: "AIzaSyBDBmQI4hYnaMvMeDyz_t8fdOFFxvli6Nc",
  authDomain: "batrieu-fc6fe.firebaseapp.com",
  projectId: "batrieu-fc6fe",
  storageBucket: "batrieu-fc6fe.firebasestorage.app",
  messagingSenderId: "748793348510",
  appId: "1:748793348510:web:40a6cf44ab27d59f62d68f",
  measurementId: "G-C83HWYXM2Z"
};

// Initialize Firebase only once
if (!firebase.apps || !firebase.apps.length) {
  firebase.initializeApp(firebaseConfig);
}

// Create references you can use in other scripts
window.firebaseApp = firebase;
window.firebaseDb = firebase.firestore ? firebase.firestore() : null;
