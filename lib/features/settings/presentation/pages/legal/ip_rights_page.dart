// Lines: 60/100
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/widgets/legal_document_viewer.dart';

class IntellectualPropertyPage extends StatefulWidget {
  const IntellectualPropertyPage({super.key});

  @override
  State<IntellectualPropertyPage> createState() => _IntellectualPropertyPageState();
}

class _IntellectualPropertyPageState extends State<IntellectualPropertyPage> {
  String _content = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final lang = context.locale.languageCode;
      final data = await rootBundle.loadString('assets/docs/ip_rights_$lang.md');
      if (mounted) setState(() => _content = data);
    } catch (e) {
      debugPrint('Error loading IP rights: $e');
      if (mounted) setState(() => _content = context.tr('legal.load_error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LegalDocumentViewer(
      title: 'settings_page.ip_rights'.tr(),
      content: _content,
    );
  }
}
