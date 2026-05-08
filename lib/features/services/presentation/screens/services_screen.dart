import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Colors (mirrors home_screen.dart AppColors exactly) ─────────────────────
class _C {
  _C._();
  static const navyBlue        = Color(0xFF1B3F8B);
  static const darkNavy        = Color(0xFF0F2557);
  static const bg              = Color(0xFFF8F9FA);
  static const surface         = Color(0xFFFFFFFF);
  static const surfaceGrey     = Color(0xFFF1F3F5);
  static const border          = Color(0xFFE5E7EB);
  static const textPrimary     = Color(0xFF111827);
  static const textSecondary   = Color(0xFF6B7280);
  static const textHint        = Color(0xFF9CA3AF);
  static const successGreen    = Color(0xFF16A34A);
  static const successSurface  = Color(0xFFDCFCE7);
  static const warningAmber    = Color(0xFFD97706);
  static const warningSurface  = Color(0xFFFEF3C7);
  static const errorRed        = Color(0xFFDC2626);
  static const errorSurface    = Color(0xFFFEE2E2);
  static const infoBlue        = Color(0xFF2563EB);
  static const infoBlueSurface = Color(0xFFEFF6FF);
}

// ─── Domain models ────────────────────────────────────────────────────────────
enum RequestStatus { submitted, routed, inProgress, resolved, rejected }

class ServiceCategory {
  final String id, name;
  final IconData icon;
  final Color color;
  final List<String> subtypes;
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.subtypes,
  });
}

class TimelineEvent {
  final String stage, detail, time;
  final bool done, active;
  const TimelineEvent({
    required this.stage,
    required this.detail,
    required this.time,
    this.done = false,
    this.active = false,
  });
}

class ServiceRequest {
  final String id, title, categoryName, subtype, description, submittedDate;
  final RequestStatus status;
  final double slaPercent;   // 0.0 – 1.0
  final String slaRemaining; // e.g. "18 hrs"
  final Color categoryColor;
  final IconData categoryIcon;
  final List<TimelineEvent> timeline;
  const ServiceRequest({
    required this.id,
    required this.title,
    required this.categoryName,
    required this.subtype,
    required this.description,
    required this.submittedDate,
    required this.status,
    required this.slaPercent,
    required this.slaRemaining,
    required this.categoryColor,
    required this.categoryIcon,
    required this.timeline,
  });
}

// ─── Mock data ────────────────────────────────────────────────────────────────
class _Mock {
  static const categories = [
    ServiceCategory(
      id: 'academic',
      name: 'Academic',
      icon: Icons.school_outlined,
      color: Color(0xFF2563EB),
      subtypes: [
        'Transcript issuance',
        'Degree verification',
        'Course registration issue',
        'Attendance dispute',
        'Semester freeze',
        'Exam rechecking',
      ],
    ),
    ServiceCategory(
      id: 'finance',
      name: 'Finance',
      icon: Icons.account_balance_wallet_outlined,
      color: Color(0xFF16A34A),
      subtypes: [
        'Fee voucher error',
        'Installment request',
        'Scholarship adjustment',
        'Refund request',
        'Dues transfer',
      ],
    ),
    ServiceCategory(
      id: 'hostel',
      name: 'Hostel',
      icon: Icons.bed_outlined,
      color: Color(0xFFDB2777),
      subtypes: [
        'Hostel allocation',
        'Room change',
        'Maintenance complaint',
        'Bus route issue',
        'Transport card',
      ],
    ),
    ServiceCategory(
      id: 'career',
      name: 'Career / RIC',
      icon: Icons.work_outline,
      color: Color(0xFFEA580C),
      subtypes: [
        'Internship placement',
        'Career counselling',
        'Industrial visit',
        'Startup guidance',
      ],
    ),
    ServiceCategory(
      id: 'affairs',
      name: 'Student Affairs',
      icon: Icons.groups_outlined,
      color: Color(0xFF7C3AED),
      subtypes: [
        'Club registration',
        'Event approval',
        'Society funding',
        'Grievance redressal',
      ],
    ),
    ServiceCategory(
      id: 'ict',
      name: 'ICT / Digital',
      icon: Icons.computer_outlined,
      color: Color(0xFF0891B2),
      subtypes: [
        'LMS issue',
        'Email activation',
        'WiFi problem',
        'Portal error',
        'Password reset',
      ],
    ),
    ServiceCategory(
      id: 'medical',
      name: 'Medical',
      icon: Icons.local_hospital_outlined,
      color: Color(0xFFDC2626),
      subtypes: [
        'Appointment scheduling',
        'Medical leave',
        'Emergency assistance',
        'Counselling referral',
      ],
    ),
    ServiceCategory(
      id: 'general',
      name: 'General Query',
      icon: Icons.help_outline_rounded,
      color: Color(0xFF6B7280),
      subtypes: ['Other / General'],
    ),
  ];

  static final requests = [
    ServiceRequest(
      id: 'REQ-2024-0842',
      title: 'Transcript issuance',
      categoryName: 'Academic',
      subtype: 'Transcript issuance',
      description: 'Need official transcript for graduate school applications.',
      submittedDate: '2 May',
      status: RequestStatus.inProgress,
      slaPercent: 0.35,
      slaRemaining: '18 hrs',
      categoryColor: Color(0xFF2563EB),
      categoryIcon: Icons.school_outlined,
      timeline: [
        TimelineEvent(stage: 'Submitted', detail: 'Request received', time: '2 May, 9:31 AM', done: true),
        TimelineEvent(stage: 'Routed', detail: 'Sent to Academic Directorate', time: '2 May, 9:45 AM', done: true),
        TimelineEvent(stage: 'In Progress', detail: 'Registrar verifying records', time: 'Today, 10:00 AM', active: true),
        TimelineEvent(stage: 'Ready', detail: 'Pending collection', time: '—'),
        TimelineEvent(stage: 'Resolved', detail: 'Awaiting completion', time: '—'),
      ],
    ),
    ServiceRequest(
      id: 'REQ-2024-0831',
      title: 'Fee voucher error',
      categoryName: 'Finance',
      subtype: 'Fee voucher error',
      description: 'Voucher shows incorrect amount for Spring 2024.',
      submittedDate: '28 Apr',
      status: RequestStatus.submitted,
      slaPercent: 0.72,
      slaRemaining: '6 hrs',
      categoryColor: Color(0xFF16A34A),
      categoryIcon: Icons.account_balance_wallet_outlined,
      timeline: [
        TimelineEvent(stage: 'Submitted', detail: 'Request received', time: '28 Apr, 2:10 PM', done: true),
        TimelineEvent(stage: 'Routed', detail: 'Pending triage', time: '—', active: true),
        TimelineEvent(stage: 'In Progress', detail: '—', time: '—'),
        TimelineEvent(stage: 'Resolved', detail: '—', time: '—'),
      ],
    ),
    ServiceRequest(
      id: 'REQ-2024-0799',
      title: 'Password reset',
      categoryName: 'ICT / Digital',
      subtype: 'Password reset',
      description: 'CMS portal password reset request.',
      submittedDate: '20 Apr',
      status: RequestStatus.resolved,
      slaPercent: 1.0,
      slaRemaining: 'Done',
      categoryColor: Color(0xFF0891B2),
      categoryIcon: Icons.computer_outlined,
      timeline: [
        TimelineEvent(stage: 'Submitted', detail: 'Request received', time: '20 Apr', done: true),
        TimelineEvent(stage: 'Routed', detail: 'Sent to ICT', time: '20 Apr', done: true),
        TimelineEvent(stage: 'In Progress', detail: 'ICT team processing', time: '20 Apr', done: true),
        TimelineEvent(stage: 'Resolved', detail: 'Password reset completed', time: '21 Apr', done: true),
      ],
    ),
  ];
}

// ─── SERVICES SCREEN (tab root) ───────────────────────────────────────────────
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _ServicesHeader()),
            SliverToBoxAdapter(child: _SearchBar()),
            SliverToBoxAdapter(child: _ActiveRequestsBanner()),
            SliverToBoxAdapter(child: _CategoriesGrid()),
            SliverToBoxAdapter(child: _RecentRequestsSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
      floatingActionButton: _NewRequestFab(),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────
class _ServicesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Services',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _C.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Student Support Services Centre',
                style: TextStyle(
                  fontSize: 12,
                  color: _C.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyRequestsScreen()),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _C.border),
              ),
              child: Row(
                children: const [
                  Icon(Icons.list_alt_outlined, size: 15, color: _C.navyBlue),
                  SizedBox(width: 5),
                  Text(
                    'My Requests',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _C.navyBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Search bar ───────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.border),
        ),
        child: Row(
          children: const [
            SizedBox(width: 12),
            Icon(Icons.search, color: _C.textHint, size: 18),
            SizedBox(width: 8),
            Text(
              'Search services or FAQs…',
              style: TextStyle(
                fontSize: 13,
                color: _C.textHint,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Active requests banner ───────────────────────────────────────────────────
class _ActiveRequestsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final active = _Mock.requests
        .where((r) => r.status != RequestStatus.resolved && r.status != RequestStatus.rejected)
        .toList();
    if (active.isEmpty) return const SizedBox.shrink();

    // SLA warning: show if any request is >60% through SLA
    final urgent = active.where((r) => r.slaPercent > 0.6).toList();
    final isUrgent = urgent.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyRequestsScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isUrgent ? _C.warningSurface : _C.infoBlueSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUrgent ? const Color(0xFFFCD34D) : const Color(0xFFBFDBFE),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isUrgent ? _C.warningAmber : _C.infoBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isUrgent ? Icons.warning_amber_rounded : Icons.pending_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isUrgent
                          ? '${urgent.length} request${urgent.length > 1 ? 's' : ''} nearing SLA deadline'
                          : '${active.length} active request${active.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isUrgent ? _C.warningAmber : _C.infoBlue,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      isUrgent ? 'Tap to check status' : 'Tap to view all',
                      style: const TextStyle(fontSize: 11, color: _C.textSecondary),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: isUrgent ? _C.warningAmber : _C.infoBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Categories grid ──────────────────────────────────────────────────────────
class _CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _C.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _C.border),
            ),
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:  4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 0.70,
              ),
              itemCount: _Mock.categories.length,
              itemBuilder: (_, i) => _CategoryTile(cat: _Mock.categories[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final ServiceCategory cat;
  const _CategoryTile({required this.cat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SubmitRequestScreen(category: cat),
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cat.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cat.icon, color: cat.color, size: 20),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                cat.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: _C.textPrimary,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Recent requests on services home ────────────────────────────────────────
class _RecentRequestsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recent = _Mock.requests.take(2).toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Requests',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _C.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyRequestsScreen()),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 13,
                    color: _C.navyBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...recent.map((r) => _RequestCard(request: r, showDivider: r != recent.last)),
        ],
      ),
    );
  }
}

// ─── New request FAB ──────────────────────────────────────────────────────────
class _NewRequestFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SubmitRequestScreen()),
      ),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _C.navyBlue,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _C.navyBlue.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add, color: Colors.white, size: 18),
            SizedBox(width: 6),
            Text(
              'New Request',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Request card (reused in services home + my requests) ─────────────────────
class _RequestCard extends StatelessWidget {
  final ServiceRequest request;
  final bool showDivider;
  const _RequestCard({required this.request, this.showDivider = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RequestDetailScreen(request: request),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _C.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: request.categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(request.categoryIcon,
                          color: request.categoryColor, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _C.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${request.categoryName}  ·  ${request.submittedDate}',
                            style: const TextStyle(
                                fontSize: 11, color: _C.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    _StatusBadge(status: request.status),
                  ],
                ),
                // SLA bar — only for non-resolved
                if (request.status != RequestStatus.resolved) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: request.slaPercent,
                            minHeight: 4,
                            backgroundColor: _C.surfaceGrey,
                            valueColor: AlwaysStoppedAnimation(
                              request.slaPercent > 0.7
                                  ? _C.warningAmber
                                  : _C.infoBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        request.slaRemaining,
                        style: TextStyle(
                          fontSize: 10,
                          color: request.slaPercent > 0.7
                              ? _C.warningAmber
                              : _C.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                // Request ID row
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      request.id,
                      style: const TextStyle(
                          fontSize: 10, color: _C.textHint),
                    ),
                    const Spacer(),
                    const Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 11,
                        color: _C.navyBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.arrow_forward_ios,
                        size: 10, color: _C.navyBlue),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (showDivider) const SizedBox(height: 8),
      ],
    );
  }
}

// ─── Status badge ─────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final RequestStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      RequestStatus.submitted   => ('Submitted',   const Color(0xFFEFF6FF), _C.infoBlue),
      RequestStatus.routed      => ('Routed',       const Color(0xFFF5F3FF), const Color(0xFF6D28D9)),
      RequestStatus.inProgress  => ('In Progress',  const Color(0xFFEFF6FF), _C.navyBlue),
      RequestStatus.resolved    => ('Resolved',     _C.successSurface,      _C.successGreen),
      RequestStatus.rejected    => ('Rejected',     _C.errorSurface,        _C.errorRed),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// SUBMIT REQUEST SCREEN — 3-step wizard
// ═════════════════════════════════════════════════════════════════════════════
class SubmitRequestScreen extends StatefulWidget {
  final ServiceCategory? category;
  const SubmitRequestScreen({super.key, this.category});

  @override
  State<SubmitRequestScreen> createState() => _SubmitRequestScreenState();
}

class _SubmitRequestScreenState extends State<SubmitRequestScreen> {
  int _step = 0; // 0 = category, 1 = type, 2 = details
  ServiceCategory? _selectedCategory;
  String? _selectedSubtype;
  final _descController = TextEditingController();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category;
    if (_selectedCategory != null) _step = 1;
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 2) setState(() => _step++);
  }

  void _back() {
    if (_step > 0) setState(() => _step--);
  }

  bool get _canProceed {
    if (_step == 0) return _selectedCategory != null;
    if (_step == 1) return _selectedSubtype != null;
    if (_step == 2) return _descController.text.trim().length > 10;
    return false;
  }

  void _submit() {
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) return _SuccessScreen();

    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: _C.textPrimary),
          onPressed: _step == 0 ? () => Navigator.pop(context) : _back,
        ),
        title: const Text(
          'New Request',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _StepIndicator(currentStep: _step),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: _stepWidget(),
              ),
            ),
          ),
          _BottomBar(
            canProceed: _canProceed,
            isLastStep: _step == 2,
            onNext: _step == 2 ? _submit : _next,
          ),
        ],
      ),
    );
  }

  Widget _stepWidget() {
    if (_step == 0) {
      return _StepOneCategory(
        key: const ValueKey(0),
        selected: _selectedCategory,
        onSelect: (cat) => setState(() {
          _selectedCategory = cat;
          _selectedSubtype = null;
        }),
      );
    }
    if (_step == 1) {
      return _StepTwoType(
        key: const ValueKey(1),
        category: _selectedCategory!,
        selected: _selectedSubtype,
        onSelect: (t) => setState(() => _selectedSubtype = t),
      );
    }
    return _StepThreeDetails(
      key: const ValueKey(2),
      category: _selectedCategory!,
      subtype: _selectedSubtype!,
      controller: _descController,
      onChanged: (_) => setState(() {}),
    );
  }
}

// Step indicator
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  static const _labels = ['Category', 'Type', 'Details'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Row(
        children: List.generate(_labels.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepIndex = i ~/ 2;
            return Expanded(
              child: Container(
                height: 1.5,
                color: stepIndex < currentStep ? _C.navyBlue : _C.border,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final done = stepIndex < currentStep;
          final active = stepIndex == currentStep;
          return Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: done
                      ? _C.navyBlue
                      : active
                          ? _C.navyBlue
                          : _C.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active || done ? _C.navyBlue : _C.border,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: done
                      ? const Icon(Icons.check, color: Colors.white, size: 13)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: active ? Colors.white : _C.textHint,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                _labels[stepIndex],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? _C.textPrimary : _C.textSecondary,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// Step 1 — Category picker
class _StepOneCategory extends StatelessWidget {
  final ServiceCategory? selected;
  final ValueChanged<ServiceCategory> onSelect;
  const _StepOneCategory({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What can we help you with?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select the category that best fits your request.',
          style: TextStyle(fontSize: 13, color: _C.textSecondary),
        ),
        const SizedBox(height: 16),
        ...List.generate(_Mock.categories.length, (i) {
          final cat = _Mock.categories[i];
          final isSelected = selected?.id == cat.id;
          return GestureDetector(
            onTap: () => onSelect(cat),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? cat.color.withOpacity(0.06)
                    : _C.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? cat.color : _C.border,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: cat.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(cat.icon, color: cat.color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      cat.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: _C.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle_rounded, color: cat.color, size: 20)
                  else
                    const Icon(Icons.arrow_forward_ios,
                        size: 12, color: _C.textHint),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Step 2 — Subtype picker
class _StepTwoType extends StatelessWidget {
  final ServiceCategory category;
  final String? selected;
  final ValueChanged<String> onSelect;
  const _StepTwoType({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category chip at top
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(category.icon, color: category.color, size: 14),
              const SizedBox(width: 5),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 12,
                  color: category.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Select request type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Choose the most specific option available.',
          style: TextStyle(fontSize: 13, color: _C.textSecondary),
        ),
        const SizedBox(height: 16),
        ...category.subtypes.map((t) {
          final isSelected = selected == t;
          return GestureDetector(
            onTap: () => onSelect(t),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: isSelected ? category.color.withOpacity(0.06) : _C.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? category.color : _C.border,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      t,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: _C.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle_rounded,
                        color: category.color, size: 20)
                  else
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(
                            BorderSide(color: _C.border, width: 1.5),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// Step 3 — Description + SLA hint
class _StepThreeDetails extends StatelessWidget {
  final ServiceCategory category;
  final String subtype;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _StepThreeDetails({
    super.key,
    required this.category,
    required this.subtype,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary chips
        Wrap(
          spacing: 6,
          children: [
            _Chip(label: category.name, color: category.color),
            _Chip(label: subtype, color: _C.textSecondary),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Describe your issue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'The more detail you provide, the faster we can help.',
          style: TextStyle(fontSize: 13, color: _C.textSecondary),
        ),
        const SizedBox(height: 14),
        // Description box
        Container(
          decoration: BoxDecoration(
            color: _C.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _C.border),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: 6,
            minLines: 6,
            style: const TextStyle(fontSize: 14, color: _C.textPrimary),
            decoration: const InputDecoration(
              hintText: 'Describe your issue in detail…',
              hintStyle: TextStyle(fontSize: 13, color: _C.textHint),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Attachment row
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _C.border, style: BorderStyle.solid),
            ),
            child: Row(
              children: const [
                Icon(Icons.attach_file_rounded, size: 18, color: _C.textSecondary),
                SizedBox(width: 8),
                Text(
                  'Attach a file  (optional)',
                  style: TextStyle(fontSize: 13, color: _C.textSecondary),
                ),
                Spacer(),
                Text(
                  'Browse',
                  style: TextStyle(
                    fontSize: 12,
                    color: _C.navyBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // SLA estimate card
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: _C.surfaceGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 16, color: _C.textSecondary),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Typical resolution time',
                  style: TextStyle(fontSize: 12, color: _C.textSecondary),
                ),
              ),
              const Text(
                '2–3 working days',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _C.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color == _C.textSecondary ? _C.textSecondary : color,
        ),
      ),
    );
  }
}

// Bottom bar
class _BottomBar extends StatelessWidget {
  final bool canProceed, isLastStep;
  final VoidCallback onNext;
  const _BottomBar({
    required this.canProceed,
    required this.isLastStep,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: _C.surface,
        border: Border(top: BorderSide(color: _C.border)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: canProceed ? onNext : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _C.navyBlue,
            disabledBackgroundColor: _C.border,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isLastStep ? 'Submit Request' : 'Continue',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: canProceed ? Colors.white : _C.textHint,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Success screen ───────────────────────────────────────────────────────────
class _SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: _C.successSurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: _C.successGreen, size: 36),
              ),
              const SizedBox(height: 20),
              const Text(
                'Request Submitted',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _C.textPrimary,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your request has been received. You\'ll get a notification when its status updates.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _C.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: _C.surfaceGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'REQ-2024-0843',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _C.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.navyBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Track Request',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                child: const Text(
                  'Back to Services',
                  style: TextStyle(
                    fontSize: 14,
                    color: _C.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// MY REQUESTS SCREEN
// ═════════════════════════════════════════════════════════════════════════════
class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  List<ServiceRequest> _filtered(String filter) {
    return switch (filter) {
      'active'   => _Mock.requests.where((r) =>
          r.status != RequestStatus.resolved &&
          r.status != RequestStatus.rejected).toList(),
      'resolved' => _Mock.requests.where((r) =>
          r.status == RequestStatus.resolved ||
          r.status == RequestStatus.rejected).toList(),
      _          => _Mock.requests,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: _C.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Requests',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 36,
            decoration: BoxDecoration(
              color: _C.surfaceGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tab,
              labelStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400),
              labelColor: _C.textPrimary,
              unselectedLabelColor: _C.textSecondary,
              indicator: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _C.border),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Active'),
                Tab(text: 'Resolved'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: ['all', 'active', 'resolved'].map((f) {
          final list = _filtered(f);
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox_outlined, size: 40, color: _C.textHint),
                  const SizedBox(height: 10),
                  Text(
                    'No ${f == 'all' ? '' : f} requests',
                    style: const TextStyle(
                        fontSize: 14, color: _C.textSecondary),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) =>
                _RequestCard(request: list[i]),
          );
        }).toList(),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// REQUEST DETAIL SCREEN — full timeline + SLA + rating
// ═════════════════════════════════════════════════════════════════════════════
class RequestDetailScreen extends StatefulWidget {
  final ServiceRequest request;
  const RequestDetailScreen({super.key, required this.request});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  int? _rating;

  @override
  Widget build(BuildContext context) {
    final r = widget.request;
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        backgroundColor: _C.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 18, color: _C.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          r.id,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _C.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + status row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: r.categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(r.categoryIcon, color: r.categoryColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _C.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${r.categoryName}  ·  ${r.submittedDate}',
                        style: const TextStyle(
                            fontSize: 12, color: _C.textSecondary),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: r.status),
              ],
            ),
            const SizedBox(height: 16),
            // Description card
            _DetailCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _C.textSecondary,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    r.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _C.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // SLA card — only for non-resolved
            if (r.status != RequestStatus.resolved) ...[
              _DetailCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'SLA Progress',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _C.textSecondary,
                            letterSpacing: 0.4,
                          ),
                        ),
                        Text(
                          '${r.slaRemaining} remaining',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: r.slaPercent > 0.7
                                ? _C.warningAmber
                                : _C.infoBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: r.slaPercent,
                        minHeight: 6,
                        backgroundColor: _C.surfaceGrey,
                        valueColor: AlwaysStoppedAnimation(
                          r.slaPercent > 0.7 ? _C.warningAmber : _C.infoBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            // Timeline
            _DetailCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _C.textSecondary,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(r.timeline.length, (i) {
                    final event = r.timeline[i];
                    final isLast = i == r.timeline.length - 1;
                    return _TimelineRow(
                      event: event,
                      isLast: isLast,
                    );
                  }),
                ],
              ),
            ),
            // Rating card — only for resolved
            if (r.status == RequestStatus.resolved) ...[
              const SizedBox(height: 12),
              _DetailCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate your experience',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _C.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'How satisfied were you with the resolution?',
                      style: TextStyle(fontSize: 12, color: _C.textSecondary),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        final filled = _rating != null && i < _rating!;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = i + 1),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              filled ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: filled
                                  ? const Color(0xFFF59E0B)
                                  : _C.textHint,
                              size: 32,
                            ),
                          ),
                        );
                      }),
                    ),
                    if (_rating != null) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _C.navyBlue,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Submit Rating',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final Widget child;
  const _DetailCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _C.border),
      ),
      child: child,
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final TimelineEvent event;
  final bool isLast;
  const _TimelineRow({required this.event, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final dotColor = event.done
        ? _C.navyBlue
        : event.active
            ? _C.warningAmber
            : _C.border;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dot + line column
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: event.done ? _C.navyBlue : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: dotColor, width: 2),
                  ),
                  child: event.done
                      ? const Icon(Icons.check, color: Colors.white, size: 7)
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: event.done ? _C.navyBlue : _C.border,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.stage,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: event.active
                          ? _C.warningAmber
                          : event.done
                              ? _C.textPrimary
                              : _C.textHint,
                    ),
                  ),
                  if (event.detail.isNotEmpty && event.detail != '—') ...[
                    const SizedBox(height: 2),
                    Text(
                      event.detail,
                      style: const TextStyle(
                          fontSize: 12, color: _C.textSecondary),
                    ),
                  ],
                  if (event.time.isNotEmpty && event.time != '—') ...[
                    const SizedBox(height: 1),
                    Text(
                      event.time,
                      style: const TextStyle(
                          fontSize: 11, color: _C.textHint),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
