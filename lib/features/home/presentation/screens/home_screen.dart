// Main dashboard - greeting, essentials, schedule
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../services/presentation/screens/services_screen.dart' as nust_services;
import '../../../../features/inbox/presentation/screens/inbox_screen.dart' as nust_inbox;

// ─── App Colors ───────────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const navyBlue = Color(0xFF1B3F8B);
  static const darkNavy = Color(0xFF0F2557);
  static const backgroundWhite = Color(0xFFF8F9FA);
  static const surfaceWhite = Color(0xFFFFFFFF);
  static const surfaceGrey = Color(0xFFF1F3F5);
  static const borderLight = Color(0xFFE5E7EB);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const textHint = Color(0xFF9CA3AF);
  static const infoBlue = Color(0xFF2563EB);
  static const infoBlueSurface = Color(0xFFEFF6FF);
  static const successGreen = Color(0xFF16A34A);
  static const successSurface = Color(0xFFDCFCE7);

  // Category icon colors — flat, no gradient
  static const iconClasses = Color(0xFF2563EB);
  static const iconTimetable = Color(0xFF059669);
  static const iconGrades = Color(0xFF7C3AED);
  static const iconAttendance = Color(0xFFEA580C);
  static const iconFee = Color(0xFF16A34A);
  static const iconHostel = Color(0xFFDB2777);
  static const iconTransport = Color(0xFF0891B2);
  static const iconLibrary = Color(0xFFF59E0B);

  // Quick action colors
  static const qaNotice = Color(0xFF2563EB);
  static const qaRequests = Color(0xFF7C3AED);
  static const qaExams = Color(0xFFDC2626);
  static const qaSocieties = Color(0xFF059669);
  static const qaCareers = Color(0xFFEA580C);
}

// ─── App Theme ────────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundWhite,
    fontFamily: 'SF Pro Display', // falls back to system sans-serif
    colorScheme: const ColorScheme.light(
      primary: AppColors.navyBlue,
      surface: AppColors.surfaceWhite,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundWhite,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.borderLight,
      thickness: 1,
    ),
  );
}

// ─── Mock Data ────────────────────────────────────────────────────────────────
class MockData {
  static const studentName = 'Hamza';
  static const studentCms = '22F-3841';
  static const studentDept = 'BE-SE · SEECS';

  static const todayClass = _ClassSlot(
    courseName: 'OOP (CS-212)',
    room: 'CR-10',
    school: 'SEECS',
    startTime: '2:00 PM',
    endTime: '2:50 PM',
    minutesUntil: 20,
  );

  static const updates = [
    'Final Exams starting from 18th May 2026.',
  ];
}

class _ClassSlot {
  final String courseName, room, school, startTime, endTime;
  final int minutesUntil;
  const _ClassSlot({
    required this.courseName,
    required this.room,
    required this.school,
    required this.startTime,
    required this.endTime,
    required this.minutesUntil,
  });
}

// ─── Home Screen ──────────────────────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _TopBar()),
            SliverToBoxAdapter(child: _NustBanner()),
            SliverToBoxAdapter(child: _EssentialsSection()),
            SliverToBoxAdapter(child: _TodaysScheduleSection()),
            SliverToBoxAdapter(child: _QuickActionsSection()),
            SliverToBoxAdapter(child: _ImportantUpdatesSection()),
            SliverToBoxAdapter(child: _ServicesSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          // Hamburger
          GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HamLine(width: 22),
                const SizedBox(height: 5),
                _HamLine(width: 16),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Good morning, ${MockData.studentName} ',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                const Text(
                  'Welcome to NUST',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Notification bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.navyBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderLight, width: 2),
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HamLine extends StatelessWidget {
  final double width;
  const _HamLine({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 2,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// ─── NUST Banner ──────────────────────────────────────────────────────────────
class _NustBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.darkNavy,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // NUST logo area
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simple crest placeholder — replace with actual SVG asset
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/nust_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.school, color: AppColors.navyBlue, size: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'NUST',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const Text(
                  'Defining Futures',
                  style: TextStyle(
                    color: Color(0xFFADB5C8),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Quote
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\u201C',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.2),
                      fontSize: 48,
                      height: 0.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'The best way\nto predict the future\nis to create it.',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Essentials Section ───────────────────────────────────────────────────────
class _EssentialsSection extends StatelessWidget {
  static const _items = [
    _EssentialItem('Classes', Icons.school_outlined, AppColors.iconClasses),
    _EssentialItem('Timetable', Icons.calendar_month_outlined, AppColors.iconTimetable),
    _EssentialItem('Grades', Icons.grade_outlined, AppColors.iconGrades),
    _EssentialItem('Attendance', Icons.how_to_reg_outlined, AppColors.iconAttendance),
    _EssentialItem('Fee & Dues', Icons.account_balance_wallet_outlined, AppColors.iconFee),
    _EssentialItem('Hostel', Icons.bed_outlined, AppColors.iconHostel),
    _EssentialItem('Transport', Icons.directions_bus_outlined, AppColors.iconTransport),
    _EssentialItem('Library', Icons.menu_book_outlined, AppColors.iconLibrary),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _SectionHeader(
            title: 'My Essentials',
            actionLabel: 'Customize',
            onAction: () {},
            actionIcon: Icons.edit_outlined,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: _items.length,
              itemBuilder: (_, i) => _EssentialTile(item: _items[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _EssentialItem {
  final String label;
  final IconData icon;
  final Color color;
  const _EssentialItem(this.label, this.icon, this.color);
}

class _EssentialTile extends StatelessWidget {
  final _EssentialItem item;
  const _EssentialTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Today's Schedule ─────────────────────────────────────────────────────────
class _TodaysScheduleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = MockData.todayClass;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _SectionHeader(
            title: "Today's Schedule",
            actionLabel: 'View Timetable',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Time column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          c.startTime,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c.endTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Vertical line indicator
                    Column(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.navyBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 28,
                          color: AppColors.navyBlue,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Course details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.courseName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${c.room}  •  ${c.school}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // "In X min" badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.successSurface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'In ${c.minutesUntil} min',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.textHint,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quick Actions ────────────────────────────────────────────────────────────
class _QuickActionsSection extends StatelessWidget {
  static const _actions = [
    _QuickAction('Notice Board', Icons.campaign_outlined, AppColors.qaNotice),
    _QuickAction('Apply/Requests', Icons.assignment_outlined, AppColors.qaRequests),
    _QuickAction('Exams', Icons.edit_document, AppColors.qaExams),
    _QuickAction('Societies', Icons.groups_outlined, AppColors.qaSocieties),
    _QuickAction('Careers', Icons.work_outline, AppColors.qaCareers),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _SectionHeader(
            title: 'Quick Actions',
            actionLabel: 'View All',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _actions.map((a) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _QuickActionTile(action: a),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  const _QuickAction(this.label, this.icon, this.color);
}

class _QuickActionTile extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action.icon, color: action.color, size: 22),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 72,
              child: Text(
                action.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Important Updates ────────────────────────────────────────────────────────
class _ImportantUpdatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _SectionHeader(
            title: 'Important Updates',
            actionLabel: 'View All',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          ...MockData.updates.map(
            (u) => _UpdateCard(text: u),
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final String text;
  const _UpdateCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.infoBlueSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.infoBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Services Section ─────────────────────────────────────────────────────────
class _ServicesSection extends StatelessWidget {
  static const _services = [
    _ServiceItem('IT Services', Icons.computer_outlined, Color(0xFF2563EB)),
    _ServiceItem('E-Resources', Icons.cloud_outlined, Color(0xFF0891B2)),
    _ServiceItem('Counseling', Icons.favorite_border, Color(0xFFDB2777)),
    _ServiceItem('Health Center', Icons.local_hospital_outlined, Color(0xFFDC2626)),
    _ServiceItem('Lost & Found', Icons.search_outlined, Color(0xFF059669)),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          _SectionHeader(
            title: 'Services',
            actionLabel: 'View All',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _services.map((s) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _ServiceTile(item: s),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final String label;
  final IconData icon;
  final Color color;
  const _ServiceItem(this.label, this.icon, this.color);
}

class _ServiceTile extends StatelessWidget {
  final _ServiceItem item;
  const _ServiceTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 72,
              child: Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Navigation ────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', selected: true),
              _NavItemWithBadge(
                icon: Icons.inbox_outlined,
                label: 'Inbox',
                badge: '2',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const nust_inbox.InboxScreen()),
                  );
                },
              ),
              // Central Scan FAB
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: AppColors.navyBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              _NavItem(
                icon: Icons.grid_view_outlined,
                label: 'Services',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const nust_services.ServicesScreen()),
                  );
                },
              ),
              _NavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.navyBlue : AppColors.textSecondary;
    return InkResponse(
      onTap: onTap ?? () {},
      radius: 30,
      splashColor: AppColors.navyBlue.withValues(alpha: 0.1),
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemWithBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final String badge;
  final VoidCallback? onTap;

  const _NavItemWithBadge({
    required this.icon,
    required this.label,
    required this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap ?? () {},
      radius: 30,
      splashColor: AppColors.navyBlue.withValues(alpha: 0.1),
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: AppColors.textSecondary, size: 22),
                Positioned(
                  top: -4,
                  right: -6,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: AppColors.navyBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared: Section Header ───────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionLabel;
  final VoidCallback onAction;
  final IconData? actionIcon;

  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            letterSpacing: -0.2,
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Row(
            children: [
              Text(
                actionLabel,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.navyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (actionIcon != null) ...[
                const SizedBox(width: 3),
                Icon(actionIcon, size: 13, color: AppColors.navyBlue),
              ],
            ],
          ),
        ),
      ],
    );
  }
}