// ─────────────────────────────────────────────────────────────────────────────
// RC ROLLBACK — FRONTEND CLEANUP CHANGELOG
// ─────────────────────────────────────────────────────────────────────────────
// This file documents all changes made to the rc_rollback screens and routing
// as part of the UI standardization and architecture alignment pass.
//
// Date    : 2026-04-12
// Author  : [Your name]
// Purpose : Align rc_rollback with the rest of the Classic Engine app's
//           architecture, coding patterns, and typography standards.
//
// IMPORTANT : Design / visual appearance is UNCHANGED.
//             Only internal structure, font references, navigation, and
//             widget class types have been updated.
// ─────────────────────────────────────────────────────────────────────────────

/// ════════════════════════════════════════════════════════════════════════════
/// PART 1 — SCREENS CONVERTED FROM StatefulWidget → HookWidget
/// ════════════════════════════════════════════════════════════════════════════
///
/// All 5 rc_rollback screens now use HookWidget (from flutter_hooks).
/// This is the standard pattern for every screen in the project —
/// see UninstallationSaveScreen, RcRollbackListScreen, FollowUpDetailScreen, etc.
///
/// WHY HookWidget?
///   • Controllers (TextEditingController, AnimationController) are
///     automatically disposed — no more manual dispose() in _State classes.
///   • State variables use useState<T>() — cleaner than setState(fn).
///   • useEffect() replaces initState() + dispose().
///   • flutter_hooks is already exported from classic_common_imports.dart,
///     so no extra import is needed on screens.
///
/// CONVERTED SCREENS:
///
///   1. rc_customer_details_screen.dart
///      BEFORE : StatelessWidget
///      AFTER  : HookWidget
///      CHANGE : Navigation callbacks are now plain functions inside build().
///               No widget-level member methods needed due to HookWidget closure.
///
///   2. rc_no_reason_screen.dart
///      BEFORE : StatefulWidget + _RcNoReasonScreenState
///      AFTER  : HookWidget
///      CHANGE :
///        • _notesController   → useTextEditingController()
///        • _remarksController → useTextEditingController()
///        • _revisitDate       → useState<DateTime?>(null)
///        • _toggles           → useState<Map<String,bool>>({})
///        • setState(...)      → direct value assignment on useState
///        • dispose()          → removed (hooks auto-dispose)
///
///   3. rc_recharge_screen.dart
///      BEFORE : StatefulWidget + _RcRechargeScreenState
///      AFTER  : HookWidget
///      CHANGE :
///        • _selectedPackage   → useState<String?>(null)
///        • _selectedPeriod    → useState<String?>(null)
///        • _selectedOnu       → useState<String?>(null)
///        • _amountVisible     → useState<bool>(false)
///        • _totalAmount       → useState<int>(0)
///        • _breakdown         → useState<String>('')
///        • setState(...)      → direct .value = assignments
///        • SnackBar usage     → ClassicSnackBar.error(context, msg)
///
///   4. rc_qr_payment_screen.dart
///      BEFORE : StatefulWidget + _RcQrPaymentScreenState
///      AFTER  : HookWidget
///      CHANGE :
///        • _secondsLeft       → useState<int>(299)
///        • _expired           → useState<bool>(false)
///        • _checking          → useState<bool>(false)
///        • _confirmed         → useState<bool>(false)
///        • Timer in initState → useEffect() returns timer.cancel for auto-disposal
///        • _qrData = '...'    → useMemoized(() => '...', []) computed once
///        • dispose()          → removed
///
///   5. rc_payment_sucess_screen.dart (note: typo in filename preserved)
///      BEFORE : StatefulWidget + SingleTickerProviderStateMixin
///      AFTER  : HookWidget
///      CHANGE :
///        • AnimationController → useAnimationController(duration: ...)
///        • CurvedAnimation     → useMemoized(() => CurvedAnimation(...), [anim])
///        • _ringAnim.forward() → useEffect(() { ringAnim.forward(); return null; }, [])
///        • _phoneEditorOpen    → useState<bool>(false)
///        • _phoneSaved         → useState<bool>(false)
///        • _phoneController    → useTextEditingController()
///        • _taskDone map       → useState<Map<String,bool>>({...})
///        • Explicit dispose()  → removed (useAnimationController auto-disposes)
///
///   6. rc_rollback_screen.dart
///      BEFORE : StatefulWidget
///      AFTER  : HookWidget
///      CHANGE :
///        • All _selected...    → useState<String?>(null)
///        • All controllers     → useTextEditingController(text: ...)
///        • _uploadedFileName   → useState<String?>(null)
///        • _signatureCaptured  → useState<bool>(false)
///        • _gpsState           → useState<String>('...')

/// ════════════════════════════════════════════════════════════════════════════
/// PART 2 — TYPOGRAPHY: GoogleFonts.plusJakartaSans → AppTextStyle
/// ════════════════════════════════════════════════════════════════════════════
///
/// BEFORE : GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: ...)
/// AFTER  : AppTextStyle.bold(12)   or   AppTextStyle.medium(12)
///          AppTextStyle.regular(12) or   AppTextStyle.semiBold(12)
///
/// WHY?
///   • AppTextStyle (lib/core/constants/app_text_styles.dart) uses Inter —
///     the same font as the rest of the app. Plus Jakarta Sans was inconsistent.
///   • AppTextStyle wrappers ensure consistent letterSpacing, scaling, and
///     make future font changes a one-line edit.
///
/// MAPPING USED:
///   FontWeight.w800 / w700 → AppTextStyle.bold(size)
///   FontWeight.w600        → AppTextStyle.semiBold(size)
///   FontWeight.w500        → AppTextStyle.medium(size)
///   FontWeight.w400        → AppTextStyle.regular(size)
///
/// NOTE: RcColors and the overall visual design are UNCHANGED.
///       This change only affects the font family and how sizes are specified.

/// ════════════════════════════════════════════════════════════════════════════
/// PART 3 — NAVIGATION: Navigator.push / goNamed → context.pushNamed
/// ════════════════════════════════════════════════════════════════════════════
///
/// All navigation in rc_rollback screens now uses go_router:
///
///   BEFORE:
///     Navigator.of(context).push(MaterialPageRoute(builder: (_) => SomeScreen()))
///     context.goNamed('RcCustomerDetailsScreen')   // wrong case, not registered
///
///   AFTER (go_router named route):
///     context.pushNamed('rcCustomerDetails')   // push = keeps back-stack
///     context.pop()                            // go back
///
///   WHY pushNamed instead of goNamed?
///     goNamed replaces the ENTIRE route stack (like replace).
///     pushNamed adds on top — correct for drilling into detail screens.
///     Use goNamed only when you want to clear history (e.g. after logout).
///
///   NAVIGATION CALLS PER SCREEN:
///     rc_customer_details  → pushNamed('rcRecharge')   or pushNamed('rcNoReason')
///     rc_no_reason         → pushNamed('rcRollbackEquipment')
///                          → pop()
///     rc_recharge          → pushNamed('rcQrPayment', extra: { ... })
///     rc_qr_payment        → pushNamed('rcPaymentSuccess', extra: { ... })
///     rc_payment_success   → pop()
///     rc_rollback_screen   → pop()

/// ════════════════════════════════════════════════════════════════════════════
/// PART 4 — ROUTING (app_routes.dart) UPDATED
/// ════════════════════════════════════════════════════════════════════════════
///
/// BEFORE:
///   • Only RcCustomerDetailsScreen was registered (unnamed, no data passing).
///   • Route path had wrong case: 'RcCustomerDetailsScreen'.
///   • RcRechargeScreen, RcQrPaymentScreen, RcPaymentSuccessScreen,
///     RcNoReasonScreen, RcRollbackScreen were NOT registered — any
///     context.pushNamed()/goNamed() call would crash at runtime.
///
/// AFTER (all 6 screens registered, properly nested):
///
///   rcRollBackList
///   └── rcRollBackDetails               (existing close/retention)
///       ├── rcRollBackClose
///       ├── retentionForm
///       └── rcCustomerDetails           ← FIXED: was 'RcCustomerDetailsScreen'
///           ├── rcRecharge              ← NEW
///           │   └── rcQrPayment         ← NEW (extra: Map)
///           │       └── rcPaymentSuccess ← NEW (extra: Map)
///           ├── rcNoReason              ← NEW
///           └── rcRollbackEquipment     ← NEW (the equipment form)
///
///   Data passing via `extra` uses Map<String, dynamic> for screens that need
///   multiple values (payment screens). For screens that need a model,
///   TODO comments show how to pass the UninstallationList or real API model.
///
///   Imports added to app_routes.dart:
///     rc_recharge_screen.dart
///     rc_qr_payment_screen.dart
///     rc_payment_sucess_screen.dart
///     rc_no_reason_screen.dart
///     rc_rollback_screen.dart

/// ════════════════════════════════════════════════════════════════════════════
/// PART 5 — GUIDE FILES CREATED
/// ════════════════════════════════════════════════════════════════════════════
///
///   api.txt
///     → Describes all API endpoints to be implemented, expected request bodies,
///       response shapes, and which screen/Bloc event to wire them to.
///
///   bloc.txt
///     → Step-by-step Bloc integration guide using the project's Bloc pattern.
///       Includes code samples, list of files to create/modify, and references
///       to existing (working) implementations to follow.

/// ════════════════════════════════════════════════════════════════════════════
/// PART 6 — NOT CHANGED (INTENTIONALLY KEPT)
/// ════════════════════════════════════════════════════════════════════════════
///
///   ✅ All screen layouts and visual designs — preserved exactly.
///   ✅ RcColors, rc_theme.dart — kept (senior approved the color design).
///   ✅ All custom rc_ widgets (RcTopBar, RcHeroCard, RcInfoCard, etc.) — kept.
///   ✅ RcBanner, RcCategoryCard, RcPillColor — kept.
///   ✅ Data / existing rollback routes (rcRollBackDetails, retentionForm) — kept.
///   ✅ Dummy data models — kept until real API models are available.

/// ════════════════════════════════════════════════════════════════════════════
/// FUTURE WORK (post-API integration)
/// ════════════════════════════════════════════════════════════════════════════
///
///   1. Replace all dummyCustomer.xxx with real model fields.
///   2. Connect each screen to Bloc (see bloc.txt for step-by-step).
///   3. Pass real data via go_router extra (see TODOs in each screen file).
///   4. Add form validators using the project's existing ClassicValidator.
///   5. Replace RcUploadZone with ClassicImagePicker from core/widgets.
///   6. Integrate signature pad for RcRollbackScreen.
///   7. Register BlocProviders for rc_rollback Blocs in route builders.
// ─────────────────────────────────────────────────────────────────────────────
library;

// Intentionally kept as a documentation-only file.
// No exports or Dart code here — only comments for the developer.
