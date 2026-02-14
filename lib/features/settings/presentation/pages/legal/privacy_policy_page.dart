// Lines: 40/100
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/widgets/legal_document_viewer.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String _content = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final lang = context.locale.languageCode;
      final data = await rootBundle.loadString('assets/docs/privacy_policy_$lang.md');
      if (mounted) setState(() => _content = data);
    } catch (e) {
      debugPrint('Error loading privacy policy: $e');
      if (mounted) setState(() => _content = context.tr('legal.load_error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LegalDocumentViewer(
      title: 'settings_page.privacy_policy'.tr(),
      content: _content,
    );
  }
}
