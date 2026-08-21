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

<img width="1983" height="793" alt="Image" src="https://github.com/user-attachments/assets/33586d83-2fb9-4a98-9dce-6b44d9cc9efb" />


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
