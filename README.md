Khazna — Personal Finance Tracker
Flutter • Clean Architecture • Offline-First • Isar • BLoC

> A modern, offline-first personal finance application built with Flutter.  
> Designed to track income \& expenses, visualize spending patterns, and manage transactions with a polished, production-ready UI.

---

## 📱 App Screenshots

<p align="center">
  <img src="screen1.jpg" width="180" />
  <img src="screen2.jpg" width="180" />
  <img src="screen3.jpg" width="180" />
  <img src="screen4.jpg" width="180" />
  <img src="screen5.jpg" width="180" />
</p>

---

Project Overview
Khazna (Arabic for "treasury / vault") is a complete personal finance mobile application that allows users to:
Record income and expense transactions with optional product images
View real-time balance, income, and expense summaries
Analyze spending by category and over the last 7 days
Customize preferences (currency, notifications, theme readiness)
Delete transactions with a smooth swipe gesture
The app is fully offline, uses a local NoSQL database, and follows a layered architecture suitable for scaling into a production product.

---

Key Features
Feature Description
Transaction Management Add, view, and delete income/expense records with product name, source, category, amount, date, and optional cropped image
Wallet Summary Card Live total balance, revenues, and expenses with gradient design
Statistics Dashboard Category breakdown (pie chart) + 7-day income/expense trend (bar chart) using `fl\_chart`
Image Picker + Cropper Gallery selection with circular crop (1:1 aspect ratio) and local storage
Swipe-to-Delete Custom gesture-based deletion with animated feedback
Bottom Navigation Home / Statistics / Settings with hide-on-scroll behavior
Settings Notifications toggle, Dark mode (UI ready), Currency selector (USD / EUR / IQD), Export & Clear data (stubs)
Offline-First All data stored locally with Isar — no internet required

---

Tech Stack
Layer Technology
Framework Flutter (Dart)
State Management `flutter\_bloc` (Cubit pattern)
Dependency Injection `get\_it`
Local Database `isar\_community` (NoSQL, high performance)
Charts `fl\_chart`
Image Handling `image\_picker` + `image\_cropper`
Path & Storage `path\_provider`
Formatting `intl`
UI Material Design + custom components, glassmorphism accents, green-based design system

---

Architecture
The project follows a feature-first + layered (Clean Architecture inspired) structure:

```
lib/
├── core/
│   ├── data/datasources/          # Shared infrastructure (image directory init)
│   └── presentation/pages/        # MainShell (root navigation)
├── features/
│   ├── transactions/
│   │   ├── data/                  # Datasources, Models, Repository Implementations
│   │   ├── domain/                # Entities, Repositories (interfaces), UseCases
│   │   └── presentation/          # Cubits, Pages, Widgets
│   ├── statistics/
│   │   ├── domain/                # Entities, UseCases, Cubit
│   │   └── presentation/          # Pages \& Widgets (charts)
│   └── settings/
│       └── presentation/          # Cubit, Pages, Widgets
└── service\_locator.dart           # GetIt registration
```

Design Principles Applied
Separation of Concerns: Domain logic is independent of Flutter/UI and database
Dependency Inversion: Repositories defined as abstractions; implementations injected
Single Responsibility: Each UseCase has one clear purpose
Reactive UI: Cubits emit states → UI rebuilds via `BlocBuilder` / `BlocListener`
Scoped Providers: Screen-level Cubits where appropriate + shared `TransactionCubit` at shell level

---

Core Domain Model

```dart
class Transaction {
  final int? id;
  final String productName;
  final String? imageUrl;
  final String source;
  final DateTime date;
  final double price;        // positive = income, negative = expense
  final String category;
}
```

Price sign determines transaction type (income / expense)
Images are stored as local file paths under the app documents directory
Isar auto-increment ID is used for persistence and deletion

---

Notable Implementation Details

1. Shared TransactionCubit across tabs
   `MainShell` provides a single `TransactionCubit`. Statistics listens to it via `BlocListener`, so adding a transaction on the Home tab immediately updates the Statistics dashboard without extra API calls.
2. Custom Swipe-to-Delete
   A fully custom gesture widget (`SwipeToDeleteTransaction`) with:
   Drag tracking
   Threshold-based dismissal
   Animated size collapse after delete
   Visual delete icon that scales with drag distance
3. Hide-on-Scroll Bottom Navigation
   `HideOnScroll` listens to the active `ScrollController` and translates + fades the bottom bar smoothly while scrolling.
4. Image Pipeline

```
Gallery → ImagePicker → ImageCropper (circle, 1:1) → Copy to app documents/images → Store path in Transaction
```

5. Statistics Calculation (Pure Dart UseCases)
   Category breakdown with percentage and color palette
   7-day trend aggregated by weekday labels
   All calculations are side-effect free and testable
6. Design System
   Consistent use of:
   Primary green: `#2ECC71`
   Background: `#F5F7FA` / `#F7FDF9`
   Soft shadows, 20–24px border radius
   Glassmorphism on navigation bar (`BackdropFilter`)

---

Current Limitations & Future Improvements
Area Current State Suggested Next Steps
Settings persistence In-memory only Integrate `shared\_preferences` or Isar
Clear all data UI only (TODO) Implement `DeleteAllTransactionsUseCase`
Export data Placeholder CSV / JSON export
Dark mode Toggle present Full theme switching
Currency Stored but not applied globally Format all amounts with selected currency
Edit transaction Not implemented Add edit flow
Filtering & Search Not present Date range, category filter, search
Tests None visible Unit tests for UseCases + Cubit tests
Localization Mixed Arabic comments + English UI Full `intl` / ARB support

---

Skills Demonstrated
This project showcases the following competencies relevant for a Flutter / Mobile Developer role:
Clean / Layered Architecture in a real feature-based structure
BLoC / Cubit state management with proper separation of UI and business logic
Dependency Injection with GetIt
Local database design with Isar (schema, write transactions, queries)
Custom gestures & animations (swipe-to-delete, hide-on-scroll, scale feedback)
Charts & data visualization (`fl\_chart`)
Image picking, cropping, and local file management
Responsive & polished UI with consistent design tokens
Offline-first mindset
Ability to structure a multi-feature app that is maintainable and extensible

---

How to Run
Clone the repository
Run `flutter pub get`
Ensure Isar code generation is up to date (`dart run build\_runner build` if needed)
Launch on emulator or physical device:

```bash
   flutter run
```

> Requires Android/iOS permissions for gallery access (image_picker).

---

Project Status
MVP — Feature Complete for Core Flows
Home (wallet + transaction list) — Fully functional
Add Transaction (with image) — Fully functional
Delete Transaction — Fully functional
Statistics — Fully functional
Settings — UI complete, persistence & destructive actions pending
The codebase is clean, readable, and ready for further iteration or portfolio demonstration.

---

Author Notes (for CV / Interview)
This project was built to demonstrate:
End-to-end ownership of a Flutter application
Understanding of state management, architecture, and local persistence
Attention to UX details (animations, gestures, visual consistency)
Ability to deliver a usable product rather than a collection of disconnected widgets
Happy to discuss architecture decisions, trade-offs, or possible improvements in an interview.

---

Generated as a professional project summary for resume / portfolio use.
