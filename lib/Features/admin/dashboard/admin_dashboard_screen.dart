import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:readytogo/widgets/customscfaffold_widget.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appbartitle: 'Health Admin Dashboard',
      isDrawerRequired: true,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome
                const Text('Welcome, Admin',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text("Here's your dashboard overview.",
                    style: TextStyle(color: _Brand.textSecondary)),
                const SizedBox(height: 16),
                // Grid cards
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: const [
                    _StatCard(
                      icon: Icons.groups_2_rounded,
                      iconBg: Color(0xFFE8ECFF),
                      label: 'Total Users',
                      value: '2,893',
                    ),
                    _StatCard(
                      icon: Icons.fact_check_rounded,
                      iconBg: Color(0xFFEAF1FF),
                      label: 'Surveys Completed',
                      value: '1,420',
                    ),
                    _StatCard(
                      icon: Icons.apartment_rounded,
                      iconBg: Color(0xFFEFF3FF),
                      label: 'Organization',
                      value: '87',
                    ),
                    _StatCard(
                      icon: Icons.medical_services_rounded,
                      iconBg: Color(0xFFE9EEFF),
                      label: 'Professionals',
                      value: '312',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Survey completion card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + percent
                      Row(
                        children: const [
                          Expanded(
                            child: Text('Survey Completion',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _Brand.textPrimary)),
                          ),
                          Text('65%',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: _Brand.primary)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Donut chart
                      const _Donut(percent: 0.65),
                      const SizedBox(height: 8),
                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          _LegendDot(color: _Brand.primary, label: 'Completed'),
                          SizedBox(width: 16),
                          _LegendDot(color: _Brand.pending, label: 'Pending'),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconBg;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2;
    return SizedBox(
      width: math.min(w, 360),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon + label
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: _Brand.primary, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: _Brand.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Donut extends StatelessWidget {
  final double percent; // 0..1
  const _Donut({required this.percent});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8, // to match screenshot spacing
      child: Center(
        child: SizedBox(
          height: 170,
          width: 170,
          child: CustomPaint(
            painter: _DonutPainter(percent: percent),
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percent;

  const _DonutPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 18.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;

    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE8ECFF);

    final completed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = _Brand.primary;

    // background circle (pending)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2,
      false,
      bg,
    );

    // completed arc (start top, clockwise)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * percent,
      false,
      completed,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.percent != percent;
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: _Brand.textSecondary)),
      ],
    );
  }
}

class _Brand {
  const _Brand();
  static const primary = Color(0xFF5871FF); // bluish-purple accent
  static const pending = Color(0xFFDCE3FF);
  // static const bg = Color(0xFFF3F4F8); // Removed unused field
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
}
