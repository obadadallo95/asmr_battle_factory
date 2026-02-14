import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        
        final canExit = await ref.read(navigationGuardProvider.notifier).canPop(context);
        
        if (canExit && context.mounted) {
          final location = GoRouterState.of(context).uri.toString();
          if (location.startsWith('/app/') && location != '/app/home') {
            context.go('/app/home');
            return;
          }

          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      },
      child: child,
    );
  }
}
