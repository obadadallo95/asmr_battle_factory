import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/glass_card.dart';
import '../../../../features/ai/data/provider_registry.dart';
import '../../../../features/ai/domain/models/provider_profile.dart';

class AIConductorPage extends StatefulWidget {
  const AIConductorPage({super.key});

  @override
  State<AIConductorPage> createState() => _AIConductorPageState();
}

class _AIConductorPageState extends State<AIConductorPage> {
  late final ProviderRegistry _registry;
  List<ProviderProfile> _profiles = [];

  @override
  void initState() {
    super.initState();
    _registry = GetIt.I<ProviderRegistry>();
    _profiles = _registry.getAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.withValues(alpha: 0.1),
                    Colors.black,
                    Colors.cyan.withValues(alpha: 0.05),
                  ],
                ),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverPadding(
                padding: EdgeInsets.all(20.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionHeader('Current Intelligence', Icons.psychology),
                    SizedBox(height: 15.h),
                    _buildStatusCard(),
                    SizedBox(height: 30.h),
                    _buildSectionHeader('Neural Pipeline', Icons.linear_scale),
                    SizedBox(height: 15.h),
                    _buildStaticPipeline(),
                    SizedBox(height: 30.h),
                    _buildSectionHeader('Active Engines', Icons.fact_check),
                    SizedBox(height: 15.h),
                    _buildProviderList(),
                    SizedBox(height: 100.h),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.h,
      floating: false,
      pinned: true,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          } else {
            context.go('/app/settings');
          }
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'AI CONDUCTOR',
          style: GoogleFonts.orbitron(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 18.sp),
        SizedBox(width: 10.w),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.orbitron(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return GlassCard(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.cyanAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.auto_awesome, color: Colors.cyanAccent, size: 24.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BALANCED STRATEGY',
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Optimizing for both creative depth and execution speed across all active modules.',
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticPipeline() {
    return Row(
      children: [
        _buildPipelineNode('TEXT', Icons.text_fields, 'GPT-4O'),
        _buildConnector(),
        _buildPipelineNode('SCENE', Icons.movie_filter, 'GEMINI'),
        _buildConnector(),
        _buildPipelineNode('VOICE', Icons.graphic_eq, 'GROQ'),
      ],
    );
  }

  Widget _buildPipelineNode(String label, IconData icon, String value) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
            ),
            child: Icon(icon, color: Colors.white70, size: 20.sp),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.bold)),
          Text(value, 
            style: GoogleFonts.sourceCodePro(color: Colors.cyanAccent, fontSize: 9.sp, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildConnector() {
    return Container(
      width: 20.w,
      height: 1,
      color: Colors.white12,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
    );
  }

  Widget _buildProviderList() {
    return Column(
      children: _profiles.map<Widget>((profile) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: GlassCard(
            child: ListTile(
              leading: Icon(
                _getProviderIcon(profile.id),
                color: Colors.cyanAccent,
              ),
              title: Text(
                profile.name,
                style: GoogleFonts.sourceCodePro(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                'Latency: ${profile.speed.averageLatencyMs}ms',
                style: const TextStyle(color: Colors.white54),
              ),
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

  IconData _getProviderIcon(String id) {
    switch (id.toLowerCase()) {
      case 'openai': return Icons.bolt;
      case 'gemini': return Icons.auto_awesome;
      case 'groq': return Icons.speed;
      case 'deepseek': return Icons.search;
      default: return Icons.api;
    }
  }
}
