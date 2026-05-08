import 'package:flutter/material.dart';

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

class InboxMessage {
  final String id;
  final String title;
  final String content;
  final String time;
  final String type; // "Announcement", "Service", "Academic", "Finance"
  final IconData icon;
  final Color color;
  final bool isUnread;

  const InboxMessage({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    required this.icon,
    required this.color,
    required this.isUnread,
  });
}

class _Mock {
  static final List<InboxMessage> messages = [
    const InboxMessage(
      id: '1',
      title: 'Request Update: Transcript issuance',
      content: 'Your request (REQ-2024-0842) stage changed to "In Progress". The Registrar is currently verifying your records.',
      time: '10:05 AM',
      type: 'Service',
      icon: Icons.school_outlined,
      color: Color(0xFF2563EB),
      isUnread: true,
    ),
    const InboxMessage(
      id: '2',
      title: 'Spring 2024 Mid-Term Schedule',
      content: 'The official datesheet for the Spring Mid-term examinations has been uploaded to your portal.',
      time: 'Yesterday',
      type: 'Announcement',
      icon: Icons.campaign_outlined,
      color: Color(0xFFEA580C),
      isUnread: true,
    ),
    const InboxMessage(
      id: '3',
      title: 'Hostel Allotment Notice',
      content: 'Dear Student, hostel room allocations for the new semester have been finalized. Please check your CMS.',
      time: '2 May',
      type: 'Announcement',
      icon: Icons.bed_outlined,
      color: Color(0xFFDB2777),
      isUnread: false,
    ),
    const InboxMessage(
      id: '4',
      title: 'Outstanding Fee Reminder',
      content: 'This is a gentle reminder that your tuition fee voucher for Spring 2024 is due on May 10th.',
      time: '29 Apr',
      type: 'Finance',
      icon: Icons.account_balance_wallet_outlined,
      color: Color(0xFF16A34A),
      isUnread: false,
    ),
    const InboxMessage(
      id: '5',
      title: 'LMS Maintenance Scheduled',
      content: 'LMS will be down for scheduled maintenance this Sunday from 02:00 AM to 06:00 AM.',
      time: '28 Apr',
      type: 'Announcement',
      icon: Icons.computer_outlined,
      color: Color(0xFF0891B2),
      isUnread: false,
    ),
  ];
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: _C.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Inbox',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_all_outlined, color: _C.navyBlue, size: 22),
            tooltip: 'Mark all as read',
          ),
        ],
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
              controller: _tabController,
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
                Tab(text: 'Important'),
                Tab(text: 'All Messages'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _InboxList(messages: _Mock.messages.where((m) => m.isUnread).toList()),
          _InboxList(messages: _Mock.messages),
        ],
      ),
    );
  }
}

class _InboxList extends StatelessWidget {
  final List<InboxMessage> messages;
  
  const _InboxList({required this.messages});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.inbox_outlined, size: 48, color: _C.border),
            SizedBox(height: 12),
            Text(
              'No messages here',
              style: TextStyle(fontSize: 14, color: _C.textSecondary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final msg = messages[index];
        return _InboxCard(message: msg);
      },
    );
  }
}

class _InboxCard extends StatelessWidget {
  final InboxMessage message;

  const _InboxCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: message.isUnread ? _C.surface : _C.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: message.isUnread ? _C.navyBlue.withValues(alpha: 0.3) : _C.border,
          width: message.isUnread ? 1.5 : 1.0,
        ),
        boxShadow: message.isUnread
            ? [BoxShadow(color: _C.navyBlue.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {}, // Detail view could go here
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: message.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(message.icon, color: message.color, size: 22),
                ),
                const SizedBox(width: 14),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              message.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: message.isUnread ? FontWeight.w700 : FontWeight.w600,
                                color: _C.textPrimary,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            message.time,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: message.isUnread ? FontWeight.w600 : FontWeight.w500,
                              color: message.isUnread ? _C.navyBlue : _C.textHint,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        message.content,
                        style: TextStyle(
                          fontSize: 13,
                          color: message.isUnread ? _C.textPrimary.withValues(alpha: 0.8) : _C.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _C.surfaceGrey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              message.type,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _C.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
