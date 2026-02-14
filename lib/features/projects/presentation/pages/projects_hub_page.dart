import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:asmr_battle_factory/features/vault/presentation/pages/idea_vault_page.dart';
import 'package:asmr_battle_factory/features/history/presentation/pages/history_page.dart';
import 'package:asmr_battle_factory/features/projects/presentation/pages/projects_page.dart';
import 'package:asmr_battle_factory/features/projects/presentation/widgets/create_project_dialog.dart';

class ProjectsHubPage extends ConsumerStatefulWidget {
  const ProjectsHubPage({super.key});

  @override
  ConsumerState<ProjectsHubPage> createState() => _ProjectsHubPageState();
}

class _ProjectsHubPageState extends ConsumerState<ProjectsHubPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'projects.library'.tr(),
          style: TextStyle(
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF6C63FF),
          indicatorWeight: 3,
          labelColor: const Color(0xFF6C63FF),
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(icon: const Icon(Icons.work_outline_rounded), text: 'projects.my_projects'.tr()),
            Tab(icon: const Icon(Icons.lightbulb_outline_rounded), text: 'vault.title'.tr()),
            Tab(icon: const Icon(Icons.history_rounded), text: 'history.title'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProjectsPage(),
          IdeaVaultPage(),
          HistoryPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateOptions(context),
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showCreateOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161625),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.create_new_folder, color: Colors.cyanAccent),
            title: Text('projects.new_empty'.tr(), style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              showDialog(context: context, builder: (_) => CreateProjectDialog());
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_awesome, color: Colors.amberAccent),
            title: Text('projects.from_template'.tr(), style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              // Navigation to templates if implemented
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.purpleAccent),
            title: Text('projects.from_history'.tr(), style: const TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(2);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
