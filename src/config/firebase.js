import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";

const firebaseConfig = {
  apiKey: "AIzaSyBsZm_rwgSKtAW713fI6zvxVK-mTKHpY2E",
  authDomain: "gacha-game-manager.firebaseapp.com",
  projectId: "gacha-game-manager",
  storageBucket: "gacha-game-manager.firebasestorage.app",
  messagingSenderId: "290620559600",
  appId: "1:290620559600:web:16a17300c6d1ccbb3cf235",
  measurementId: "G-48NF3D4RWV"
};

const app = initializeApp(firebaseConfig);

export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);

export default app;