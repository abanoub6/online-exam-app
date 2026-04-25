# 📝 Online Exam App

A comprehensive online examination mobile application built with Flutter, enabling students to browse subjects, take exams, view results, and manage their profiles seamlessly.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Login** | Email & password login with Remember Me support |
| 📝 **Register** | Create a new account |
| 🔑 **Forgot Password** | Reset password via email OTP verification |
| 🔍 **Explore** | Browse subjects with search functionality |
| 📚 **Exams** | View and start exams by subject |
| 📊 **Results** | View exam results history with detailed question review |
| 👤 **Profile** | View, edit profile and change password |

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
- **Interceptors** for token management and 401 handling

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

## 📊 Results Feature

Results are stored **locally using Hive** — no API needed.

| Screen | Description |
|---|---|
| **ResultsListScreen** | Shows all past exam results |
| **ResultsDetailsScreen** | Shows detailed question review with correct/wrong answers highlighted |

---

## 🔗 API

- **Base URL:** `https://exam.elevateegy.com/api/v1`
- **Postman Collection:** [View Collection](https://documenter.getpostman.com/view/5709532/2sAXxMfYUf)

---

## 🎨 Design

- **Figma:** [View Design](https://www.figma.com/design/xQqC79GT8hoJ2NFKGaBiRM/Online-exam--Copy-?node-id=23-2962&t=gn6MOfCErXsRVYGH-0)

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
