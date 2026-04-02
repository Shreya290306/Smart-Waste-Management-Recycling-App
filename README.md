# 🌍 GreenCity - Smart Waste Management & Recycling App

A complete, production-ready Flutter application to manage municipal waste tracking, collection schedules, and recycling efforts.

## ✨ Key Features
This app offers a **Dual-Interface System**:

### 🧑‍🤝‍🧑 Citizen Interface
* **Schedule Pickups:** Select a waste category (Organic, Plastic, E-Waste) and schedule a pickup.
* **Earn Rewards:** Automatically earn points for every pickup successfully scheduled.
* **Interactive Map:** Locate nearby recycling centers directly on an interactive GPS map (powered by OpenStreetMap).

### 🏛️ Municipal Authority Interface
* **Track Collection Requests:** View incoming citizen pickup requests in real-time.
* **Status Updates:** Mark completed tasks as "Collected" with an instant dashboard update.
* **Optimize Routes:** Dedicated interface to check route availability and notify drivers.

### 🔌 Robust Offline Capabilities
* **Full Offline Support:** If a user loses connectivity, their requests are securely cached on the device using **Hive** local databases.
* **Seamless Sync:** Once connectivity is restored, cached tickets instantly synchronize with the system seamlessly.

## 🛠️ Technology Stack
* **Framework:** Flutter & Dart
* **State Management:** Provider (`provider`)
* **Local Database:** Hive / Hive Flutter (`hive`, `hive_flutter`)
* **Persistence:** Shared Preferences (`shared_preferences`)
* **Mapping:** Flutter Map (`flutter_map`) & LatLong2 

---

## 🚀 How to Run the Project Locally

### 1. Prerequisites
Ensure you have the Flutter SDK installed on your machine.
Verify your installation by running:
```bash
flutter doctor
```

### 2. Install Dependencies
Navigate into the root of the application directory and run:
```bash
flutter clean
flutter pub get
```

### 3. Run the App
Launch the app on Windows, Web, or your Mobile emulator:
```bash
# To run on Windows desktop specifically
flutter run -d windows
```

---

## 🧠 Educational Details (For Evaluation)
* **API Compliance:** Employs an updated `userAgentPackageName` inside the TileLayer configuration. This avoids rate-limiting algorithms associated with OpenStreetMaps, demonstrating enterprise networking standards.
* **Data Lifecycle:** The local NoSQL Hive database safely holds un-synced requests during offline states, and only finalizes state updates explicitly once `put()` is securely processed across `Consumer` widgets. 

*Developed beautifully with Flutter.*
