# Sheba App - AI Coding Assistant Instructions

## Project Overview
**Sheba** is a Bengali-language Flutter civic services mobile app enabling citizens to report community issues and verify asset security. The app integrates with Supabase for backend persistence.

### Core Purpose
- **Civic Reporting**: Users submit geolocated issue reports (potholes, broken street lights, waste, water supply problems)
- **Asset Verification**: Users check if devices (by IMEI) are reported stolen
- **Multi-platform**: Builds for Android, iOS, web, Linux, macOS, and Windows

---

## Architecture & Key Components

### Single-File Structure
All UI and business logic currently resides in `lib/main.dart` (558 lines). This monolithic approach will eventually need refactoring as features grow.

**Main Classes:**
- `ShebaApp`: Material3 theme configuration with Bangladesh color scheme (Green: `#006A4E`, Red: `#F42A41`)
- `HomeScreen`: Landing page with two service cards (civic report, asset check)
- `CivicReportScreen`: Form-based issue submission with optional image upload
- `AssetCheckScreen`: IMEI lookup with mock data validation

### Supabase Integration
- **Init Point**: `main()` initializes Supabase async before `runApp()`
- **Client**: Global `final supabase` instance provides database/storage access
- **Credentials**: Hard-coded in `main.dart` (URL, anon key) - move to environment variables before production
- **Tables**: `reports` table stores civic complaints (`issue_type`, `location`, `description`, `image_url`, `status`)
- **Storage**: Optional image uploads to `reports` bucket; errors gracefully skipped if bucket missing

### Typography & Styling
- **Font**: Google Fonts Poppins for all text (loaded globally via `GoogleFonts.poppinsTextTheme()`)
- **Form Fields**: Custom-styled with `OutlineInputBorder` (borderRadius: 12)
- **Colors**: Use `Color(0xFF006A4E)` for primary, `Color(0xFFF42A41)` for secondary/warnings
- **Responsive**: Uses `SafeArea` + `Padding` padding; NetworkImage for hero backgrounds

---

## Developer Workflows

### Setup & Run
```bash
flutter pub get          # Install dependencies
flutter run -d <device>  # Run on specific device/emulator
flutter run -d web       # Run web version locally
```

### Build
```bash
flutter build apk       # Release Android APK
flutter build ios       # Release iOS app
flutter build web       # Release web build
```

### Database Migrations
- Migrations stored in `supabase/migrations/` (e.g., `001_create_reports_table.sql`)
- Execute via Supabase dashboard or `supabase db push`
- Current schema: `reports` table with auto-increment `id` and pending/resolved `status`

### Testing
- Currently uses `flutter_test` (dev dependency) with placeholder `test/widget_test.dart`
- Add widget tests for form validation and Supabase error handling
- Mock Supabase client for unit tests

---

## Project-Specific Patterns & Conventions

### UI Patterns
1. **Service Cards**: Use `_buildServiceCard()` helper pattern with icon, title, subtitle, background image
2. **Form Validation**: Implement via `GlobalKey<FormState>` with `TextFormField.validator` callbacks
3. **Loading States**: Manage with boolean flags (`_isLoading`), disable buttons and show progress spinners
4. **Async Dialogs**: Use `showDialog()` with custom AlertDialog for success/error feedback

### Error Handling
- **Storage Failures**: Wrap image uploads in try-catch; continue form submission if bucket unavailable
- **Validation Errors**: Show inline form validation + SnackBar for submission failures
- **Network**: No retry logic currently; consider adding for production

### State Management
- Currently stateful widgets with local state only
- No state management package (Provider, Riverpod, GetX) — suitable for current app size
- **Future consideration**: Migrate to Provider if adding multiple screens with shared state

### Naming Conventions
- **Dart**: `camelCase` for variables/functions, `PascalCase` for classes
- **Bengali Text**: Use Bengali labels throughout (e.g., 'সেবায় স্বাগতম' not 'Welcome')
- **Colors**: Define as class constants (`static const Color bdGreen = ...`)

---

## Critical Integration Points

### Supabase Dependencies
- `supabase_flutter: ^2.3.4` (note: README lists ^0.2.0, but pubspec.yaml shows ^2.3.4; use ^2.3.4)
- Requires Supabase project with authenticated anonymous access
- Image storage optional; app degrades gracefully without it

### External Services
- **Google Fonts**: Requires internet for font loading (caches locally)
- **Unsplash**: Card backgrounds load from Unsplash URLs (ensure CORS permissions)
- **Image Picker**: Requires camera/gallery permissions on Android/iOS

### Platform-Specific Notes
- **Android**: Gradle 8.x+; permissions in `AndroidManifest.xml` for camera/gallery
- **iOS**: Configure `Info.plist` for camera/photo library permissions
- **Web**: Image picker restricted to browser file dialogs; Supabase setup required
- **Desktop (Linux/macOS/Windows)**: Limited testing; focus on mobile first

---

## Key Files Reference

| File | Purpose |
|------|---------|
| `lib/main.dart` | App entry point, all UI/business logic (refactor candidate) |
| `pubspec.yaml` | Dependencies (Flutter SDK ^3.9.2, Supabase ^2.3.4, Google Fonts, image_picker) |
| `supabase/migrations/001_create_reports_table.sql` | Reports table schema |
| `analysis_options.yaml` | Linting configuration |
| `android/app/build.gradle.kts` | Android build config |
| `ios/Runner/Info.plist` | iOS permissions/metadata |

---

## Common Tasks for AI Agents

### Adding a New Feature
1. Add UI to appropriate `StatefulWidget` or create new widget in `main.dart`
2. Use existing patterns: `TextFormField` for forms, `ElevatedButton` for actions
3. Wire Supabase calls in button callbacks with try-catch error handling
4. Test on at least Android and web before committing

### Fixing Bugs
- Check form validation first (most common in `_submitReport`, `_checkAsset`)
- Verify Supabase connectivity (check dashboard for table/bucket existence)
- Use `debugPrint()` for logging; avoid print() in production
- Check Bengali text encoding if UI text appears corrupted

### Refactoring
- Extract large widgets (CivicReportScreen, AssetCheckScreen) to separate files
- Create `lib/models/` for data classes (Report, Asset) instead of inline Maps
- Add `lib/services/` for Supabase operations (reportService, assetService)
- Consider `lib/screens/` or `lib/pages/` folder structure as app grows

### Database Changes
- Update `supabase/migrations/` with new SQL file (e.g., `002_add_column_to_reports.sql`)
- Ensure NULL constraints and defaults are explicit
- Test migration locally before pushing to production

---

## Production Readiness Checklist

Before deploying:
- [ ] Move Supabase credentials to environment variables (not hard-coded)
- [ ] Enable Row-Level Security (RLS) policies in Supabase
- [ ] Set up proper image storage bucket with signed URLs (not public)
- [ ] Add input validation/sanitization for user text
- [ ] Test on real devices (not just emulators)
- [ ] Add analytics/error reporting (Firebase Crashlytics, Sentry)
- [ ] Configure proper app signing and publishing credentials
- [ ] Add unit/widget tests for critical paths (form submission, asset check)

---

## Questions to Ask Before Starting Work

1. **Multi-screen architecture**: Should each service (report, asset check) be separate widgets/files?
2. **State management**: At what feature count should we migrate to Provider/Riverpod?
3. **Real vs. mock data**: Is asset check using actual DB or mock (currently mock)?
4. **Image requirements**: Should cropping/compression be built in before upload?
5. **Offline support**: Does the app need offline report drafting capability?
