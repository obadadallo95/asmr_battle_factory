import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/navigation_guard_service.dart';

class GuardedScaffold extends ConsumerWidget {
  final Widget child;
  
  const GuardedScaffold({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false, // Handle manually
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final canExit = await ref.read(navigationGuardProvider.notifier).canPop(context);
        
        if (canExit && context.mounted) {
           Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}
