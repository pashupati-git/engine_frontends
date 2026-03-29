# ⚡ Engine Mini

> **A modular Flutter application** for ISP field operations — featuring a 5-step Exit Interview Form, RC Rollback customer tools, and a shared enterprise-grade UI component library.

![Flutter](https://img.shields.io/badge/Flutter-3.x-54C5F8?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-Target-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Status](https://img.shields.io/badge/Status-Preview_v0.1.0-F59E0B?style=for-the-badge)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screen Showcase](#-screen-showcase)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Component Library](#-component-library)
- [Bug Log](#-bug-log)
- [Tech Stack](#-tech-stack)
- [Getting Started](#-getting-started)

---

## 🌐 Overview

Engine Mini is a prototype Flutter application built for **ISP field operations management**. It contains two complete feature modules:

| Module | Description |
|--------|-------------|
| 🗂️ **Exit Interview Form** | 5-step guided form — employee info, reasons, star ratings, open feedback, digital signature |
| 🔄 **RC Rollback** | Customer details screen for ISP RC rollback operations with read-only data fields |
| 🎨 **Shared Design System** | Reusable widget library with consistent theming, ScreenUtil responsive sizing, and DM Sans typography |

---

## ✨ Features

- **Multi-step PageView form** with animated step progress dots
- **Lifted state pattern** — all form state managed in a single `StatefulWidget`
- **Animated UI** — `AnimatedContainer`, `FadeTransition`, `SlideTransition` throughout
- **Validation guards** — each step validates before advancing to the next
- **Toast notification system** — auto-dismissing overlay with slide+fade animation
- **Digital signature area** — tap-to-sign with animated green confirmation state
- **Responsive sizing** — all dimensions via `flutter_screenutil` (430×932 design canvas)
- **System UI theming** — transparent status bar with light icons over navy header
- **Payload builder** — assembles complete form data into `Map<String, dynamic>` for API

---

## 📱 Screen Showcase

The Exit Interview Form guides the user through **5 connected pages**:

```
┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│  ISP COMPANY    │   │  ISP COMPANY    │   │  ISP COMPANY    │
│  Exit Interview │   │  Exit Interview │   │  Exit Interview │
│  Form           │   │  Form           │   │  Form           │
├─────────────────┤   ├─────────────────┤   ├─────────────────┤
│ Employee Info   │   │ Reason Leaving  │   │ Satisfaction    │
│ ●○○○○  1 of 5  │   │ ●●○○○  2 of 5  │   │ ●●●○○  3 of 5  │
├─────────────────┤   ├─────────────────┤   ├─────────────────┤
│ [A] Employee    │   │ [B] Primary     │   │ [C] Job         │
│     Information │   │     Reason      │   │     Satisfaction│
│                 │   │                 │   │                 │
│ Name   │ ID    │   │ ☑ Better Opp.   │   │ Environment ★★★★│
│ Title  │ Dept  │   │ ☑ Compensation  │   │ Management  ★★★ │
│ Supvsr │ DoJ   │   │ ☐ Work Balance  │   │ Compensation ★★ │
│ LWDate │ IntDt │   │ ☐ Relocation    │   │ Growth      ★★★★│
├─────────────────┤   ├─────────────────┤   ├─────────────────┤
│     [ Next → ]  │   │[← Back][Next →] │   │[← Back][Next →] │
└─────────────────┘   └─────────────────┘   └─────────────────┘

┌─────────────────┐   ┌─────────────────┐
│  ISP COMPANY    │   │  ISP COMPANY    │
│  Exit Interview │   │  Exit Interview │
│  Form           │   │  Form           │
├─────────────────┤   ├─────────────────┤
│ Open Feedback   │   │ Signature       │
│ ●●●●○  4 of 5  │   │ ●●●●●  5 of 5  │
├─────────────────┤   ├─────────────────┤
│ [D] Open-ended  │   │ [✏] Acknowledge │
│     Feedback    │   │                 │
│                 │   │ Employee Sign.  │
│ 1. What did you │   │ ┌─────────────┐ │
│    enjoy most?  │   │ │  ✓ Signed   │ │
│ ┌─────────────┐ │   │ └─────────────┘ │
│ │Your response│ │   │ ✅ Ready to     │
│ └─────────────┘ │   │    submit.      │
├─────────────────┤   ├─────────────────┤
│[← Back][Next →] │   │[← Back][Submit] │
└─────────────────┘   └─────────────────┘
```

---

## 🏗️ Architecture

### Form Flow

```
ExitFormScreen (State Host)
       │
       ▼
   PageController ──── NeverScrollableScrollPhysics
       │
       ├──▶ ExitPageEmployeeInfo   (Page 1 — StatelessWidget)
       ├──▶ ExitPageReasons        (Page 2 — StatefulWidget)
       ├──▶ ExitPageRatings        (Page 3 — StatefulWidget)
       ├──▶ ExitPageFeedback       (Page 4 — StatelessWidget)
       └──▶ ExitPageSignature      (Page 5 — StatelessWidget)
                  │
                  ▼
           exit_widgets.dart       (Shared UI Components)
                  │
                  ▼
           exit_theme.dart         (Design Tokens / Colors)
```

### State Management

```dart
// All mutable state lives in _ExitFormScreenState
int _currentStep = 0;
Set<String> _selectedReasons = {};
Map<String, int> _ratings = {};
List<TextEditingController> _feedbackControllers;
bool _signed = false;
bool _loading = false;
bool _submitted = false;
```

### Key Design Decisions

| Decision | Approach | Reason |
|----------|----------|--------|
| State pattern | Lifted state (no BLoC/Provider) | Appropriate scope for prototype |
| Navigation | `PageController` + programmatic | Prevents swipe-to-skip validation |
| Sizing | `flutter_screenutil` `.w/.h/.sp/.r` | Consistent across screen densities |
| Fonts | `google_fonts` DM Sans | Clean, readable for data-heavy forms |
| Status bar | `SystemChrome` transparent | Navy header bleeds behind system UI |

---

## 📁 Project Structure

```
lib/
├── main.dart                          # ScreenUtilInit + MaterialApp entry
│
├── features/
│   ├── exit_page/
│   │   ├── screens/
│   │   │   ├── exit_form_screen.dart          # Main state host (5-step controller)
│   │   │   ├── exit_page_employee_info.dart   # Page 1 — auto-filled fields
│   │   │   ├── exit_page_reasons.dart         # Page 2 — checkbox reasons
│   │   │   ├── exit_page_ratings.dart         # Page 3 — star ratings
│   │   │   ├── exit_page_feedback.dart        # Page 4 — open text questions
│   │   │   └── exit_page_signature.dart       # Page 5 — sign & submit
│   │   ├── widgets/
│   │   │   └── exit_widgets.dart              # 12 reusable UI components
│   │   └── exit_theme.dart                    # Color tokens + constants
│   │
│   └── rc_rollback/
│       └── screens/
│           └── rc_customer_details_screen.dart
│
└── core/
    ├── config/app_routes.dart
    ├── widgets/base_screen.dart
    ├── widgets/custom_textfield.dart
    └── widgets/no_internet.dart
```

---

## 🧩 Component Library

All UI primitives are in `exit_widgets.dart`. Each is fully self-contained and prop-driven.

| Widget | Props | Description |
|--------|-------|-------------|
| `ExitAppHeader` | — | Navy top bar with ISP branding, edge-to-edge behind status bar |
| `ExitStepBar` | `currentStep, totalSteps, stepLabel` | Animated progress dots — active dot expands 6px → 22px |
| `ExitNavFooter` | `showBack, onBack, onNext, nextStyle, loading` | Back + Next/Submit/Done footer with 3 button style variants |
| `ExitCard` | `child, padding?` | Rounded white card with border — section container |
| `ExitSectionHeader` | `badge, title` | Navy badge + title + horizontal rule divider |
| `ExitReadOnlyField` | `label, value` | Auto-filled display field with muted background |
| `ExitAutoFilledBadge` | — | Green badge indicating system-populated fields |
| `ExitCheckItem` | `label, selected, onToggled` | Animated checkbox row — blue highlight when selected |
| `ExitStarRatingRow` | `aspect, rating, onRated, isLast` | 5-star amber rating with `AnimatedSwitcher` on tap |
| `ExitFeedbackBlock` | `number, question, controller` | Numbered question with 3-line `TextFormField` |
| `ExitTextField` | `label, controller, hint, keyboardType, maxLines` | Labeled text input with consistent focus/enabled borders |
| `ExitSignatureArea` | `signed, onTap` | Tap-to-sign box, animates to green confirmation state |
| `ExitSuccessView` | `employeeName` | Full-screen success state with green circle checkmark |
| `ExitToast` | `message, visible` | Fade + slide overlay toast, auto-dismisses after 3s |

### Nav Button Styles

```dart
enum ExitNavButtonStyle {
  normal,   // Navy  — "Next →"
  submit,   // Blue  — "Submit Form"
  success,  // Green — "✓ Done" (disabled)
}
```

---

## 🐛 Bug Log

All runtime errors encountered during development, with root causes and fixes.

### 1. `BoxDecoration` + `color` conflict — **3 occurrences**

```
Failed assertion: line 276 pos 10: 'color == null || decoration == null'
```

**Locations:** `rc_customer_details_screen.dart:172`, `exit_widgets.dart:72`, `exit_form_screen.dart:219`

```dart
// ❌ Before
Container(
  color: Colors.white,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
)

// ✅ After
Container(
  decoration: BoxDecoration(
    color: Colors.white,                    // ← moved inside
    borderRadius: BorderRadius.circular(8),
  ),
)
```

---

### 2. RenderFlex overflow 199,389px on bottom

```
A RenderFlex overflowed by 199389 pixels on the bottom.
Column — exit_form_screen.dart:161
```

**Root cause:** `ExitFormScreen` was passed as the `child` parameter of `ScreenUtilInit` (built before `MaterialApp`), so `MediaQuery.of(context)` inside `ExitNavFooter` returned zero/invalid values causing massive padding.

```dart
// ❌ Before — child built before MaterialApp context exists
ScreenUtilInit(
  builder: (context, child) => MaterialApp(home: child),
  child: ExitFormScreen(),   // MediaQuery not yet available here
)

// ✅ After — screen built inside builder where MediaQuery is ready
ScreenUtilInit(
  builder: (context, child) => MaterialApp(
    home: const ExitFormScreen(),   // ← moved here
  ),
)
```

---

### 3. Google Fonts DNS failure (emulator)

```
Failed host lookup: 'fonts.gstatic.com' (errno = 7)
```

**Fix options:**
- Add `<uses-permission android:name="android.permission.INTERNET" />` to `AndroidManifest.xml`
- Fix emulator DNS in AVD Manager → Advanced Settings
- Bundle fonts locally in `pubspec.yaml` (recommended for offline reliability)

---

### 4. Status bar showing black background

**Root cause:** `SafeArea` was wrapping the `Container` instead of being inside it, and no `SystemUiOverlayStyle` was set.

```dart
// ✅ Fix in exit_form_screen.dart
SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
));

// ✅ Fix in ExitAppHeader — padding inside SafeArea, not on Container
Container(
  width: double.infinity,
  color: ExitColors.navy,
  child: SafeArea(
    bottom: false,
    child: Padding(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 16.h),
      child: Column(...),
    ),
  ),
)
```

---

### Bug Summary

| # | Error | File | Status |
|---|-------|------|--------|
| 1 | `color == null \|\| decoration == null` | rc_customer_details_screen.dart:172 | ✅ Fixed |
| 2 | `color == null \|\| decoration == null` | exit_widgets.dart:72 | ✅ Fixed |
| 3 | `color == null \|\| decoration == null` | exit_form_screen.dart:219 | ✅ Fixed |
| 4 | RenderFlex overflow 199,389px | exit_form_screen.dart:161 | ✅ Fixed |
| 5 | Failed host lookup fonts.gstatic.com | google_fonts (emulator) | ⚠️ Network |
| 6 | Black status bar background | ExitAppHeader | ✅ Fixed |

---

## 🛠️ Tech Stack

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | 3.x | UI framework |
| `flutter_screenutil` | ^5.x | Responsive sizing (`.w` `.h` `.sp` `.r`) |
| `google_fonts` | ^6.x | DM Sans typeface |
| `go_router` | ^13.x | Declarative navigation |
| `flutter/services.dart` | built-in | `SystemChrome` status bar control |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android emulator or physical device
- Android Studio / VS Code

### Installation

**1. Clone the repo**
```bash
git clone https://github.com/your-org/engine_mini.git
cd engine_mini
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Run the app**
```bash
flutter run -d android
```

**4. Switch active screen** — edit `lib/main.dart`:
```dart
// Exit Interview Form
home: const ExitFormScreen(),

// RC Rollback
// home: const RcCustomerDetailsScreen(),
```

### Android Manifest

Ensure internet permission is present for Google Fonts:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
```

---

## 📐 Design Tokens

All colors and constants defined in `exit_theme.dart`:

```dart
class ExitColors {
  static const navy       = Color(0xFF0D1B2A);
  static const blue       = Color(0xFF2563EB);
  static const blueLight  = Color(0xFFEFF6FF);
  static const green      = Color(0xFF10B981);
  static const greenLight = Color(0xFFECFDF5);
  static const amber      = Color(0xFFF59E0B);
  static const surface    = Color(0xFFFFFFFF);
  static const bg         = Color(0xFFF1F5F9);
  static const border     = Color(0xFFE2E8F0);
  static const borderMed  = Color(0xFFCBD5E1);
  static const text       = Color(0xFF1E293B);
  static const textMuted  = Color(0xFF64748B);
  static const textHint   = Color(0xFF94A3B8);
}
```

---

## 🗺️ Roadmap

- [ ] Connect to real API endpoint in `_submitForm()`
- [ ] Replace `dummyEmployee` with Bloc/Provider state
- [ ] Add actual signature capture (e.g. `signature_pad` package)
- [ ] Unit tests for validation logic
- [ ] iOS platform support
- [ ] Dark mode theming

---

## 📄 License

This project is proprietary software for internal ISP field operations use.

---

<div align="center">

**Engine Mini** · Flutter · Dart · Field Operations Tooling

*Built for ISP field staff · Confidential*

</div>