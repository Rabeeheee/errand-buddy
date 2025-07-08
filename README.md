# 📝 Errand Buddy

Errand Buddy is a multi-screen Flutter application — a shared task management tool designed for households or roommates.  
The app helps users to collaboratively create, assign, and track daily errands, with priority levels, due dates, and an automatic escalation system for overdue tasks.

---

## ✨ **Features**

✅ Splash screen  
✅ Onboarding screens (redesigned Onboarding Screen 1 + two new screens)  
✅ Task list with priority and due date  
✅ Add new task and assign to members  
✅ Member dashboard with assigned, completed, and overdue tasks  
✅ Escalation log showing overdue tasks sorted by most overdue  

---

## 🛠 **Screens Implemented**

- Splash Screen  
- Onboarding Screens (1, 2 & 3)
- Tasks Screen
- Add Task Screen
- Members Screen
- Escalation Log Screen

---

## 📦 **Packages Used**

- `flutter_bloc` – State management  
- `firebase_core` & `cloud_firestore` – Backend and database
- `google_fonts` – Custom fonts
- `go_router` – Navigation
- `image_picker` – Pick images for tasks
- `uuid` – Generate unique IDs for tasks
- `equatable`, `dartz` – Functional programming & data modeling
- `cached_network_image` – Efficient image loading
- and more (see `pubspec.yaml`)

---

## 📱 **Screenshots**

![WhatsApp Image 2025-07-08 at 13 12 58_0433241f](https://github.com/user-attachments/assets/b6157325-ab5a-4f9f-9716-4e82b5dd58c7)
![WhatsApp Image 2025-07-08 at 13 12 58_19cd8908](https://github.com/user-attachments/assets/9b11b595-0dcb-43f5-93b6-eb9c6bd2154d)
![WhatsApp Image 2025-07-08 at 13 12 58_7ba55bdd](https://github.com/user-attachments/assets/09e3dbd3-2fa4-47f0-8c28-4f1024192197)

---

## 🚀 **How to Run**

Make sure you have Flutter and Firebase configured.

```bash
git clone https://github.com/Rabeeheee/errand_buddy.git
cd errand_buddy
flutter pub get
flutter run
