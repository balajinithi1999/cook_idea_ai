# 🧑‍🍳 Cook Idea AI

A smart, AI-powered Flutter application that scans your fridge or pantry and instantly generates creative recipe ideas based on the visible ingredients. 

Built with a focus on modern Flutter development practices, this app demonstrates the integration of Google's state-of-the-art Generative AI Vision models with robust state management and a scalable architecture.

## ✨ Key Features

* **Visual Ingredient Parsing:** Utilizes Google's `gemini-2.5-flash` multimodal AI to identify food items directly from device camera photos.
* **Smart Recipe Generation:** Outputs structured, easy-to-follow recipes, automatically assuming basic pantry staples (oil, salt, pepper) are available.
* **Robust State Management:** Implements **Riverpod** to handle asynchronous API calls gracefully, ensuring the UI never freezes and loading/error states are handled beautifully.
* **Secure API Handling:** Uses compile-time environment variables (`--dart-define`) to ensure API keys are never hardcoded or leaked into version control.

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter / Dart
* **AI Provider:** Google Generative AI (`google_generative_ai`)
* **State Management:** Riverpod (`flutter_riverpod`)
* **Hardware Interfacing:** Image Picker (Camera & Gallery access)
* **Design Pattern:** Clean Architecture

### Folder Structure
The project strictly adheres to Clean Architecture principles to separate concerns and ensure maintainability:
```text
lib/
├── core/             # App-wide constants, custom errors, and themes
├── data/             # API data sources, JSON models, and repositories
├── domain/           # Business logic, entities, and use cases
├── presentation/     # UI screens, custom widgets, and Riverpod notifiers
└── main.dart         # App entry point
