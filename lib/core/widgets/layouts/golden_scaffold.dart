import 'package:flutter/material.dart';
import 'package:asmr_battle_factory/core/theme/golden_ratio.dart';
import 'package:asmr_battle_factory/core/utils/responsive_extensions.dart';

/// Scaffold with Golden Ratio proportions
/// Ensures consistent layout structure with proportional AppBar and padding
class GoldenScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  
  const GoldenScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar ?? (title != null
          ? AppBar(
              title: Text(
                title!,
                style: TextStyle(fontSize: context.gTextSize(TextScale.lg)),
              ),
              toolbarHeight: context.gComponentSize(ComponentSize.sm),
              actions: actions,
            )
          : null),
      body: SafeArea(
        minimum: context.gSymmetricPadding(
          horizontal: Factor.sm,
          vertical: Factor.xs,
        ),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
