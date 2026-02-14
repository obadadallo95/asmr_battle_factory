// Lines: 40/100
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/widgets/legal_document_viewer.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({super.key});

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  String _content = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final lang = context.locale.languageCode;
      final data = await rootBundle.loadString('assets/docs/terms_of_service_$lang.md');
      if (mounted) setState(() => _content = data);
    } catch (e) {
      debugPrint('Error loading terms of service: $e');
       if (mounted) setState(() => _content = 'Error loading document.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LegalDocumentViewer(
      title: context.locale.languageCode == 'ar' ? 'شروط الاستخدام' : 'Terms of Service',
      content: _content,
    );
  }
}
