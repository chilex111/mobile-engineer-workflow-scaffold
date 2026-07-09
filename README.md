# Mobile Engineer's Workflow Playbook — Companion Scaffold

A companion scaffold for **The Mobile Engineer's Workflow Playbook**.

Demonstrates the feature-based layered architecture:

```
DataSource → Repository → ViewModel/Provider → UI
```

Built with Flutter, Riverpod (code-gen), go_router, FVM, Hive, and Dio.

---

## Project structure

```
lib/
├── core/
│   ├── constants/          # AppColors, AppSpacing, AppTextStyles
│   ├── error/              # Failure types
│   ├── network/            # Dio client setup
│   └── router/             # GoRouter definition + AppRoute enum
├── features/
│   └── user_profile/       # Complete sample feature
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       └── presentation/
│           ├── providers/
│           ├── screens/
│           └── widgets/
└── main.dart
```

## Running the project

1. Install FVM: `dart pub global activate fvm`
2. `fvm install` (reads `.fvmrc`)
3. `fvm flutter pub get`
4. `fvm flutter pub run build_runner build --delete-conflicting-outputs`
5. `fvm flutter run`

---

## Key conventions

| Convention | Decision |
|---|---|
| State management | Riverpod (code-gen, `@riverpod`) |
| Routing | go_router — named routes via `AppRoute` enum |
| Local storage | Hive |
| HTTP client | Dio |
| Error handling | `Either<Failure, T>` via fpdart |
| Folder structure | Feature-first, not layer-first |

See the playbook for the reasoning behind each of these decisions.
