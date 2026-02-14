import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UrlLauncherHelper {
  static Future<void> launch(
    String? url, {
    BuildContext? context,
    String? errorMessage,
  }) async {
    if (url == null || url.isEmpty) {
      if (context != null) {
        _showError(context, 'marketplace.link_error'.tr());
      }
      return;
    }

    try {
      final uri = Uri.parse(url);
      
      // Check if can launch
      if (!await canLaunchUrl(uri)) {
        if (context != null && context.mounted) {
          _showError(context, errorMessage ?? 'marketplace.link_error'.tr());
        }
        return;
      }
      
      // Launch with external browser
      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      
      if (!success && context != null && context.mounted) {
        _showError(context, 'marketplace.link_error'.tr());
      }
    } catch (e) {
      if (context != null && context.mounted) {
        _showError(context, 'Error: $e');
      }
      debugPrint('URL Launch Error: $e');
    }
  }
  
  static void _showError(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
