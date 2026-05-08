$projectDir = "C:\Users\DELL\OneDrive\Desktop\nust_one_S3C\nust_one"
cd $projectDir

# Update pubspec.yaml
$pubspec = @"
name: nust_one
description: "A new Flutter project."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  hooks_riverpod: ^2.5.1
  flutter_hooks: ^0.20.5
  go_router: ^13.2.0
  dio: ^5.4.3
  retrofit: ^4.1.0
  json_annotation: ^4.9.0
  shared_preferences: ^2.2.3
  flutter_secure_storage: ^9.0.0
  fl_chart: ^0.67.0
  qr_flutter: ^4.1.0
  qr_code_scanner: ^1.0.1
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  lottie: ^3.1.0
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1
  flutter_local_notifications: ^17.1.2
  intl: ^0.19.0
  timeago: ^3.6.1
  url_launcher: ^6.2.6
  image_picker: ^1.0.7
  permission_handler: ^11.3.1
  connectivity_plus: ^6.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  riverpod_generator: ^2.4.0
  retrofit_generator: ^8.1.0
  json_serializable: ^6.8.0
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
"@

Set-Content -Path "pubspec.yaml" -Value $pubspec 

$files = @{
    "lib/main.dart" = @"
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  runApp(const ProviderScope(child: NustOneApp()));
}
"@
    "lib/app.dart" = @"
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NustOneApp extends StatelessWidget {
  const NustOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Home Screen')),
          ),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'NUST One',
      routerConfig: router,
    );
  }
}
"@
    "lib/core/constants/app_colors.dart" = @"
import 'package:flutter/material.dart';

class AppColors {
  static const navyBlue = Color(0xFF1B3F8B);
  static const nustGold = Color(0xFFC8A951);
  static const darkNavy = Color(0xFF0F2557);
  static const backgroundWhite = Color(0xFFF8F9FA);
  static const surfaceGrey = Color(0xFFF1F3F5);
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF6B7280);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);
  static const error = Color(0xFFDC2626);
}
"@
    "lib/core/constants/app_dimensions.dart" = @"
class AppDimensions {
  // Spacing
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Border Radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
}
"@
    "lib/core/constants/app_text_styles.dart" = "// All TextStyle definitions referencing app fonts"
    "lib/core/constants/app_strings.dart" = "// Static strings, error messages, labels"
    "lib/core/theme/app_theme.dart" = "// ThemeData light + dark, uses AppColors"
    "lib/core/theme/app_theme_provider.dart" = "// Riverpod provider for theme mode toggle"
    "lib/core/router/app_router.dart" = "// GoRouter config - all routes declared here"
    "lib/core/router/app_routes.dart" = "// Route name constants (e.g. AppRoutes.home)"
    "lib/core/router/router_provider.dart" = "// Riverpod provider exposing the GoRouter"
    "lib/core/network/dio_client.dart" = "// Dio instance with interceptors, base URL config"
    "lib/core/network/auth_interceptor.dart" = "// Injects CMS SSO token into every request"
    "lib/core/network/connectivity_service.dart" = "// Checks network; exposes isOnline stream"
    "lib/core/network/api_endpoints.dart" = "// All API endpoint path constants"
    "lib/core/error/app_exception.dart" = "// Sealed class: NetworkError, ServerError, AuthError, etc."
    "lib/core/error/failure.dart" = "// Generic Failure model with message + code"
    "lib/core/error/error_handler.dart" = "// Maps DioException / raw errors to AppException"
    "lib/core/storage/secure_storage_service.dart" = "// flutter_secure_storage wrapper (tokens)"
    "lib/core/storage/local_storage_service.dart" = "// shared_preferences wrapper (settings, cache)"
    "lib/core/utils/date_utils.dart" = "// Format dates for timetable, SLA countdowns"
    "lib/core/utils/validators.dart" = "// Form field validators"
    "lib/core/utils/extensions/string_extensions.dart" = "// String extensions"
    "lib/core/utils/extensions/datetime_extensions.dart" = "// Datetime extensions"
    "lib/core/utils/extensions/context_extensions.dart" = "// e.g. context.theme, context.screenWidth"
    
    "lib/shared/widgets/nust_app_bar.dart" = "// Reusable AppBar with NUST branding"
    "lib/shared/widgets/nust_bottom_nav.dart" = "// The 5-tab BottomNavigationBar"
    "lib/shared/widgets/nust_scaffold.dart" = "// Wraps Scaffold + bottom nav + wallet strip"
    "lib/shared/widgets/status_badge.dart" = "// Coloured pill: In Progress / Resolved / Pending"
    "lib/shared/widgets/section_header.dart" = "// My Essentials style row with optional View All"
    "lib/shared/widgets/shimmer_loader.dart" = "// Skeleton loading using shimmer package"
    "lib/shared/widgets/empty_state.dart" = "// Illustration + message for empty lists"
    "lib/shared/widgets/error_state.dart" = "// Error card with retry button"
    "lib/shared/widgets/offline_banner.dart" = "// Yellow banner when connectivity_plus detects offline"
    
    "lib/shared/models/user_model.dart" = "// Student: cmsId, name, dept, school, photoUrl"
    "lib/shared/models/pagination_model.dart" = "// Generic pagination wrapper for list responses"
    "lib/shared/models/api_response.dart" = "// Generic ApiResponse wrapper"
    
    "lib/features/auth/data/auth_api.dart" = "// Retrofit interface for CMS SSO endpoints"
    "lib/features/auth/data/auth_repository.dart" = "// Calls auth_api; handles token storage"
    "lib/features/auth/domain/auth_provider.dart" = "// Riverpod: exposes authState (loading/authed/unauthed)"
    "lib/features/auth/presentation/screens/login_screen.dart" = "// CMS SSO login; shows NUST logo + single Sign In button"
    "lib/features/auth/presentation/widgets/login_button.dart" = "// Login button widget"
    
    "lib/features/home/data/home_api.dart" = "// Endpoints: wallet balance, announcements, quick data"
    "lib/features/home/data/home_repository.dart" = "// Home repository"
    "lib/features/home/domain/home_providers.dart" = "// Providers: walletProvider, announcementsProvider"
    "lib/features/home/presentation/screens/home_screen.dart" = "// Main dashboard - greeting, essentials, schedule, wallet"
    "lib/features/home/presentation/widgets/greeting_header.dart" = "// Good morning, Ali With notification bell"
    "lib/features/home/presentation/widgets/nust_banner.dart" = "// Navy NUST branding banner with tagline"
    "lib/features/home/presentation/widgets/essentials_grid.dart" = "// 2x4 icon grid; items from local config"
    "lib/features/home/presentation/widgets/todays_schedule_card.dart" = "// Next class from Academic feature"
    "lib/features/home/presentation/widgets/quick_actions_row.dart" = "// Horizontal scroll: Notice Board, Requests, etc."
    "lib/features/home/presentation/widgets/important_updates_card.dart" = "// Important updates card"
    "lib/features/home/presentation/widgets/wallet_strip.dart" = "// Sticky bottom strip: PKR balance + Top Up"
    
    "lib/features/academic/data/qalam_api.dart" = "// Retrofit for Qalam: grades, attendance, timetable"
    "lib/features/academic/data/lms_api.dart" = "// Retrofit for LMS: submissions, announcements"
    "lib/features/academic/data/academic_repository.dart" = "// Academic repository"
    "lib/features/academic/data/mock/mock_qalam_data.dart" = "// Hardcoded JSON mimicking Qalam responses"
    "lib/features/academic/data/mock/mock_lms_data.dart" = "// Hardcoded JSON mimicking LMS responses"
    "lib/features/academic/domain/models/timetable_model.dart" = "// CourseSlot: name, room, startTime, endTime"
    "lib/features/academic/domain/models/grade_model.dart" = "// Course grade, credit hrs, GPA contribution"
    "lib/features/academic/domain/models/attendance_model.dart" = "// Per-course present/late/absent counts"
    "lib/features/academic/domain/academic_providers.dart" = "// Academic providers"
    "lib/features/academic/presentation/screens/academic_screen.dart" = "// Tab root - contains sub-nav or TabBar"
    "lib/features/academic/presentation/screens/timetable_screen.dart" = "// Timetable screen"
    "lib/features/academic/presentation/screens/grades_screen.dart" = "// Grades screen"
    "lib/features/academic/presentation/screens/attendance_screen.dart" = "// Attendance screen"
    "lib/features/academic/presentation/screens/lms_feed_screen.dart" = "// LMS feed screen"
    "lib/features/academic/presentation/widgets/week_strip.dart" = "// Mon-Sat day selector"
    "lib/features/academic/presentation/widgets/class_slot_card.dart" = "// Single timetable entry card"
    "lib/features/academic/presentation/widgets/cgpa_card.dart" = "// Big CGPA + credit hours"
    "lib/features/academic/presentation/widgets/grade_row.dart" = "// Per-course grade list item"
    "lib/features/academic/presentation/widgets/attendance_donut.dart" = "// fl_chart PieChart for overall %"
    "lib/features/academic/presentation/widgets/attendance_course_row.dart" = "// Attendance course row"
    "lib/features/academic/presentation/widgets/lms_submission_card.dart" = "// LMS submission card"
    
    "lib/features/scan/data/scan_repository.dart" = "// Validate scanned QR tokens against backend"
    "lib/features/scan/domain/scan_providers.dart" = "// Scan providers"
    "lib/features/scan/presentation/screens/scan_screen.dart" = "// Root - Scan tab / My QR tab toggle"
    "lib/features/scan/presentation/screens/qr_scanner_screen.dart" = "// Camera viewfinder via qr_code_scanner"
    "lib/features/scan/presentation/screens/my_qr_screen.dart" = "// Student own QR via qr_flutter; works offline"
    "lib/features/scan/presentation/widgets/scan_viewfinder.dart" = "// Animated corner brackets overlay"
    "lib/features/scan/presentation/widgets/qr_result_sheet.dart" = "// BottomSheet shown after successful scan"
    
    "lib/features/services/data/services_api.dart" = "// Submit request, fetch status, rate experience"
    "lib/features/services/data/services_repository.dart" = "// Services repository"
    "lib/features/services/data/mock/mock_requests_data.dart" = "// Sample requests in all status states"
    "lib/features/services/domain/models/service_request_model.dart" = "// id, category, type, status, slaDeadline, timeline"
    "lib/features/services/domain/models/service_category_model.dart" = "// id, name, color, icon, subtypes"
    "lib/features/services/domain/models/timeline_event_model.dart" = "// stage, timestamp, note, actor"
    "lib/features/services/domain/services_providers.dart" = "// Services providers"
    "lib/features/services/presentation/screens/services_screen.dart" = "// S3C home: category tiles + active requests"
    "lib/features/services/presentation/screens/submit_request_screen.dart" = "// 3-step wizard"
    "lib/features/services/presentation/screens/request_detail_screen.dart" = "// Full timeline + SLA bar + rating"
    "lib/features/services/presentation/screens/my_requests_screen.dart" = "// All / Active / Resolved filter tabs"
    "lib/features/services/presentation/widgets/category_tile.dart" = "// Coloured icon tile for each S3C category"
    "lib/features/services/presentation/widgets/request_card.dart" = "// Summary card used in my_requests list"
    "lib/features/services/presentation/widgets/sla_progress_bar.dart" = "// Animated bar with time-remaining label"
    "lib/features/services/presentation/widgets/timeline_widget.dart" = "// Vertical stage timeline with dot connectors"
    "lib/features/services/presentation/widgets/submit_step_one.dart" = "// Step: select category"
    "lib/features/services/presentation/widgets/submit_step_two.dart" = "// Step: select request type"
    "lib/features/services/presentation/widgets/submit_step_three.dart" = "// Step: description + attachment"
    
    "lib/features/profile/data/profile_api.dart" = "// Profile API"
    "lib/features/profile/data/profile_repository.dart" = "// Profile repository"
    "lib/features/profile/domain/profile_providers.dart" = "// Profile providers"
    "lib/features/profile/presentation/screens/profile_screen.dart" = "// Root: photo, name, CMS ID, section links"
    "lib/features/profile/presentation/screens/personal_info_screen.dart" = "// Personal info screen"
    "lib/features/profile/presentation/screens/academic_info_screen.dart" = "// Academic info screen"
    "lib/features/profile/presentation/screens/fee_dues_screen.dart" = "// Pulls from Qalam mock data"
    "lib/features/profile/presentation/screens/hostel_transport_screen.dart" = "// Hostel transport screen"
    "lib/features/profile/presentation/screens/settings_screen.dart" = "// Notifications, dark mode, customize grid, logout"
    "lib/features/profile/presentation/widgets/profile_header.dart" = "// Avatar + name + CMS ID + status dot"
    "lib/features/profile/presentation/widgets/profile_menu_tile.dart" = "// Arrow list tile reused throughout profile"
    "lib/features/profile/presentation/widgets/fee_payment_card.dart" = "// Fee payment card"
    
    "l10n/app_en.arb" = "@@locale: en"
}

foreach ($item in $files.GetEnumerator()) {
    $filePath = [System.IO.Path]::Combine($projectDir, $item.Name)
    $dirPath = [System.IO.Path]::GetDirectoryName($filePath)
    if (-not (Test-Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    }
    Set-Content -Path $filePath -Value $item.Value
}
