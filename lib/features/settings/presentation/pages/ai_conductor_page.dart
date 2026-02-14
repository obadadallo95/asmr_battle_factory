
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../features/ai/data/provider_registry.dart';
import '../../../../features/ai/data/services/smart_router.dart';

class AIConductorPage extends StatefulWidget {
  const AIConductorPage({super.key});

  @override
  State<AIConductorPage> createState() => _AIConductorPageState();
}

class _AIConductorPageState extends State<AIConductorPage> with SingleTickerProviderStateMixin {
  final _registry = GetIt.I<ProviderRegistry>();
  final _router = GetIt.I<SmartRouter>();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: 2.seconds)..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profiles = _registry.getAllProfiles();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('AI Conductor', style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: ListView(
              children: [
                _buildNetworkMap(),
                SizedBox(height: 20.h),
                _buildControls(),
                SizedBox(height: 20.h),
                _buildProviderList(profiles),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkMap() {
    return GlassCard(
      height: 300.h,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Background Grid
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
          
          // Central Node (The Brain)
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent.withValues(alpha: 0.2),
                border: Border.all(color: Colors.cyanAccent, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.cyanAccent.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 5),
                ],
              ),
              child: Icon(Icons.psychology, color: Colors.white, size: 40.sp),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),

          // Provider Nodes (Orbiting)
          ...List.generate(4, (index) {
            final radius = 100.w;
            return Positioned(
              left: 150.w + (radius * -0.2) + (radius * 1.2 *  (index == 0 ? 0 : index == 1 ? 1 : index == 2 ? 0 : -1)), 
              // Simplified positioning for demo - ideally calculated with cos/sin
              // Let's use Alignment instead for easy positioning
              child: const SizedBox.shrink(),
            );
          }),
          
          // Manual positioning for visual clarity
          const Positioned(top: 30, left: 30, child: _ProviderNode(label: 'OpenAI', color: Colors.green)),
          const Positioned(top: 30, right: 30, child: _ProviderNode(label: 'Groq', color: Colors.orange)),
          const Positioned(bottom: 30, left: 30, child: _ProviderNode(label: 'Gemini', color: Colors.blue)),
          const Positioned(bottom: 30, right: 30, child: _ProviderNode(label: 'DeepSeek', color: Colors.purple)),

        ],
      ),
    );
  }

  Widget _buildControls() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Routing Strategy', style: GoogleFonts.cairo(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StrategyButton(icon: Icons.flash_on, label: 'Speed', onPressed: () => _router.setPriority(RoutingPriority.speed)),
              _StrategyButton(icon: Icons.star, label: 'Quality', isActive: true, onPressed: () => _router.setPriority(RoutingPriority.quality)),
              _StrategyButton(icon: Icons.attach_money, label: 'Cost', onPressed: () => _router.setPriority(RoutingPriority.cost)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderList(List profiles) {
    return Column(
      children: profiles.map<Widget>((profile) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: GlassCard(
            child: ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(Icons.dns, color: Colors.white70),
              ),
              title: Text(profile.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(profile.description, style: TextStyle(color: Colors.white54, fontSize: 10.sp), maxLines: 2),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(profile.speed.tier.toUpperCase(), style: TextStyle(color: Colors.greenAccent, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                   Text(profile.cost.tier.toUpperCase(), style: TextStyle(color: Colors.orangeAccent, fontSize: 10.sp)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ProviderNode extends StatelessWidget {
  final String label;
  final Color color;

  const _ProviderNode({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color),
             boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 10),
            ],
          ),
          child: Icon(Icons.api, color: Colors.white, size: 24.sp),
        ),
        SizedBox(height: 5.h),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
      ],
    ).animate().fadeIn().scale();
  }
}

class _StrategyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const _StrategyButton({required this.icon, required this.label, this.isActive = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? Colors.cyanAccent.withValues(alpha: 0.2) : Colors.white10,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: isActive ? Colors.cyanAccent : Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.cyanAccent : Colors.white54, size: 18.sp),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(color: isActive ? Colors.cyanAccent : Colors.white54, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
