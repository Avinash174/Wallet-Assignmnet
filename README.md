# 💸 WalletApp

A clean and simple **Flutter wallet management app** that allows users to create a profile, manage wallet balance, add/spend money, and view transaction history. Built using **MVC architecture** and **GetX** for smooth and reactive state management.

---

## ✨ Features

- 👤 **User Profile Creation**
  - Simple form to save name and mobile number using `shared_preferences`
  - Displays user info on Home screen

- 💰 **Wallet Management**
  - Add or spend money using modal dialogs
  - Real-time balance update
  - Stored data persists between app launches

- 📜 **Transaction History**
  - See list of past transactions (add/spend)
  - Shows a friendly message if there are no transactions

- 📱 **Clean UI**
  - **Curved Bottom Navigation Bar**
  - Responsive and minimal interface

---

## 🛠️ Tech Stack

- **Flutter**
- **Dart**
- **GetX** – state management and navigation
- **Shared Preferences** – for local storage
- **MVC Architecture**
- **curved_navigation_bar** package

---

## 🚀 Getting Started

To run the project locally:

```bash
git clone https://github.com/your-username/walletapp.git
cd walletapp
flutter pub get
flutter run
