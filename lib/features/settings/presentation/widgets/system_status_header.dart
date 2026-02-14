import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/golden_ratio.dart';
import '../../../../core/utils/responsive_extensions.dart';
import '../../../../core/widgets/glass_card.dart';
import '../providers/settings_provider.dart';

class SystemStatusHeader extends ConsumerWidget {
  const SystemStatusHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiHealth = ref.watch(apiHealthProvider);
    final latency = ref.watch(averageLatencyProvider);
    
    return GlassCard(
      padding: context.gPadding(Factor.md),
      color: Colors.green.withValues(alpha: 0.1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatusPulse(),
              SizedBox(width: 1.g),
              Text(
                'settings.status.online'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 2.t,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.g),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatusItem(
                label: 'settings.status.apis'.tr(),
                value: '${apiHealth.connected}/${apiHealth.total}',
                icon: Icons.api,
                color: Colors.cyanAccent,
              ),
              Container(width: 1, height: 4.g, color: Colors.white12),
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
          width: 1.g,
          height: 1.g,
          decoration: BoxDecoration(
            color: Colors.greenAccent.withValues(alpha: _animation.value),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withValues(alpha: 0.5 * _animation.value),
                blurRadius: 1.g * _animation.value,
                spreadRadius: 2,
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
    return Column(
      children: [
        Icon(icon, color: color.withValues(alpha: 0.7), size: 2.t),
        SizedBox(height: 0.g),
        Text(
          value,
          style: GoogleFonts.sourceCodePro(
            color: Colors.white,
            fontSize: 2.t,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 1.t,
          ),
        ),
      ],
    );
  }
}
