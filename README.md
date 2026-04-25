# 📝 Online Exam App

A comprehensive online examination mobile application built with Flutter, enabling students to browse subjects, take exams, view results, and manage their profiles seamlessly.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Login** | Email & password login with Remember Me support |
| 📝 **Register** | Create a new account |
| 🔑 **Forgot Password** | Reset password via email OTP verification |
| 🔍 **Explore** | Browse subjects with search functionality and image preloading |
| 📚 **Exams** | View and start exams by subject with shimmer loading |
| 📖 **Exam Screen** | Answer questions with timer, progress bar, back/next navigation |
| 🏆 **Score Screen** | View score with circular progress, correct/incorrect count |
| 📊 **Results** | View exam results history with detailed question review |
| 👤 **Profile** | View, edit profile and change password |

---

## 📸 Screenshots
Below are the app's screenshots that highlight its functionality:

| Login | Sign Up | Forget password | OTP Code | Reset Password | Profile | Change Password |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| <img width="200" src="https://github.com/user-attachments/assets/69af2054-388f-4344-b1c0-91f54e206131" /> | <img width="200" src="https://github.com/user-attachments/assets/fe8628da-a23f-44f9-b3c7-fbc5f1238b75" /> | <img width="200" src="https://github.com/user-attachments/assets/d7dbea34-778e-4d47-83d7-063682c79511" /> | <img width="200" src="https://github.com/user-attachments/assets/b764c1e3-49eb-4cbe-a86b-c189a9dbe8bd" /> | <img width="200" src="https://github.com/user-attachments/assets/148f720c-0b5c-45d2-bc75-7041a7d13329" /> | <img width="200" src="https://github.com/user-attachments/assets/2b2f5648-77ad-474d-a8c4-f1afc781b155" /> | <img width="200" src="https://github.com/user-attachments/assets/a6e7486f-ee9c-4c1b-8af9-7b43b7ae0408" /> |

| Explore | All Exams | Start Exam | Question | Time Out | Score | Answers |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| <img width="200" src="https://github.com/user-attachments/assets/d2cbf548-ea66-4ca1-9ab6-038b5ba98f57" /> | <img width="200" src="https://github.com/user-attachments/assets/59630795-46b1-4c4d-9b62-81d4d528ff8b" /> | <img width="200" src="https://github.com/user-attachments/assets/1e85a6ab-5007-4bac-9d86-34632cfe4de4" /> | <img width="200" src="https://github.com/user-attachments/assets/d97a732d-2694-41e7-8a9b-a5aecad36cdb" /> | <img width="200" src="https://github.com/user-attachments/assets/41b31f45-c812-4f41-83a7-6da91d2b9927" /> | <img width="200" src="https://github.com/user-attachments/assets/5e2316d6-d36a-47f3-86ce-c939c8c3261a" /> | <img width="200" src="https://github.com/user-attachments/assets/8bf83076-d417-4037-93da-a863a4744af3" /> |

---

## 🛠️ Tech Stack

### Architecture
- **Clean Architecture** — Data, Domain, Presentation layers
- **Feature-based** folder structure

### State Management
- **Flutter Bloc / Cubit** — with Events pattern

### Dependency Injection
- **Injectable** + **GetIt**

### Networking
- **Dio** + **Retrofit** for API calls
- **Interceptors** for token management and 401 auto-logout

### Storage
- **Flutter Secure Storage** — for token and remember me
- **Hive** — for local exam results storage

### UI
- **Shimmer** for loading effects
- **Pin Code Fields** for OTP verification
- **Cached Network Image** for image caching
- **ScreenUtil** for responsive design

---

## 📁 Project Structure

```
lib/
├── config/
│   ├── di/                  # Dependency injection
│   ├── base_response/       # BaseResponse sealed class
│   ├── base_state/          # BaseState class
│   ├── storage/             # Hive service
│   └── services/            # Navigation service
├── core/
│   ├── constants/           # App strings, endpoints, params
│   ├── network/             # API error handler
│   ├── theme/               # Colors, text styles, sizes
│   └── widgets/             # Shared widgets
└── features/
    ├── login/
    ├── register/
    ├── forgot_password/
    ├── explore/
    ├── exams/
    ├── exam_details/
    ├── results/
    └── profile/
```

---

## 🏗️ Feature Architecture

Each feature follows the same structure:

```
feature/
├── data/
│   ├── api/                 # Retrofit API client
│   ├── data_sources/        # Remote/Local data source contract & impl
│   └── models/              # DTOs and request/response models
├── domain/
│   ├── entities/            # Domain entities
│   ├── repo/                # Repository contract
│   └── use_cases/           # Use cases
└── presentation/
    ├── screens/             # UI screens
    ├── view_model/
    │   ├── cubit/           # ViewModel (Cubit)
    │   └── states/          # States and Events
    └── widgets/             # Feature widgets
```

---

## 📖 Exam Feature

| Screen | Description |
|---|---|
| **ExamsScreen** | Lists exams by subject with shimmer loading |
| **ExamStartScreen** | Shows exam details and instructions before starting |
| **ExamDetailsScreen** | Questions with timer, progress bar, back/next navigation |
| **ScoreScreen** | Shows score with circular progress and correct/incorrect count |

### Exam Flow
```
ExploreScreen → ExamsScreen → ExamStartScreen → ExamDetailsScreen → ScoreScreen → ResultsListScreen
```

### Timer
- Countdown timer displayed in the AppBar
- Auto-submits exam when time runs out
- Shows timeout dialog with option to view score

---

## 📊 Results Feature

Results are stored **locally using Hive** — no API needed.

| Screen | Description |
|---|---|
| **ResultsListScreen** | Shows all past exam results |
| **ResultsDetailsScreen** | Shows detailed question review with correct/wrong answers highlighted in green/red |

---

## 🔗 API

- **Base URL:** `https://exam.elevateegy.com/api/v1`
- **Postman Collection:** [View Collection](https://documenter.getpostman.com/view/5709532/2sAXxMfYUf)

### Endpoints Used

| Method | Endpoint | Description |
|---|---|---|
| POST | `/auth/signup` | Register |
| POST | `/auth/signin` | Login |
| POST | `/auth/forgotPassword` | Send reset code |
| POST | `/auth/verifyResetCode` | Verify OTP |
| PUT | `/auth/resetPassword` | Reset password |
| GET | `/auth/profileData` | Get profile |
| PUT | `/auth/editProfile` | Edit profile |
| PATCH | `/auth/changePassword` | Change password |
| GET | `/subjects` | Get all subjects |
| GET | `/exams` | Get all exams |
| GET | `/exams?subject={id}` | Get exams by subject |
| GET | `/questions?exam={id}` | Get questions by exam |

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

---

## 📋 Requirements

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

---

## 👨‍💻 Team

| Name | GitHub |
|---|---|
| Ahmed Emam | [@ahmedemam55](https://github.com/ahmedemam55) |
| Abanoub | [@abanoub6](https://github.com/abanoub6) |
| NoorElden Wael | [@NoorEldenWael](https://github.com/NoorEldenWael) |
