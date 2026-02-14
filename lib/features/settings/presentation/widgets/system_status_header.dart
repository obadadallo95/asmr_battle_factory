import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/glass_card.dart';
import '../providers/settings_provider.dart';

class SystemStatusHeader extends ConsumerWidget {
  const SystemStatusHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiHealthAsync = ref.watch(apiHealthProvider);
    final latencyAsync = ref.watch(averageLatencyProvider);
    final apiHealth = apiHealthAsync.value ?? const APIHealth(connected: 0, total: 0);
    final latency = latencyAsync.value ?? 0;
    
    return GlassCard(
      padding: const EdgeInsets.all(12),
      color: Colors.green.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _StatusPulse(),
              const SizedBox(width: 8),
              Text(
                'settings.status.online'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.greenAccent,
                ),
              ),
              const Spacer(),
              Text(
                '${apiHealth.connected}/${apiHealth.total} APIs',
                style: GoogleFonts.sourceCodePro(
                  fontSize: 11,
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatusItem(
                label: 'settings.status.apis'.tr(),
                value: '${apiHealth.connected}/${apiHealth.total}',
                icon: Icons.api,
                color: Colors.cyanAccent,
              ),
              _StatusItem(
                label: 'settings.status.latency'.tr(),
                value: '${latency}ms',
                icon: Icons.speed,
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPulse extends StatefulWidget {
  @override
  State<_StatusPulse> createState() => _StatusPulseState();
}

class _StatusPulseState extends State<_StatusPulse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: _animation.value),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withValues(alpha: 0.5 * _animation.value),
                blurRadius: 8 * _animation.value,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatusItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color.withValues(alpha: 0.9), size: 16),
        const SizedBox(width: 6),
        Text(
          value,
          style: GoogleFonts.sourceCodePro(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
      ),
    );
  }
}
