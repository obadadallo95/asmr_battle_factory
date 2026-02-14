import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../core/services/security/api_key_service.dart';
import '../../../../config/di/injection.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../marketplace/presentation/providers/marketplace_provider.dart';
import '../../../marketplace/presentation/widgets/my_applications_section.dart';
import '../providers/settings_provider.dart';

class SecureApiKeyField extends ConsumerStatefulWidget {
  final String providerId; // e.g., 'openai', 'gemini'
  final String label;
  final String? hint;

  const SecureApiKeyField({
    required this.providerId,
    required this.label,
    this.hint,
    super.key,
  });

  @override
  ConsumerState<SecureApiKeyField> createState() => _SecureApiKeyFieldState();
}

class _SecureApiKeyFieldState extends ConsumerState<SecureApiKeyField> {
  final _vault = getIt<BiometricVault>();
  final _keyService = getIt<APIKeyService>();
  final _controller = TextEditingController();
  bool _isObscured = true;
  bool _isUnlocked = false; // Has user authenticated purely to view/edit?
  bool _hasSavedKey = false;

  @override
  void initState() {
    super.initState();
    _checkExistingKey();
  }

  Future<void> _checkExistingKey() async {
    final hasKey = await _vault.hasApiKey(widget.providerId);
    if (mounted) {
      setState(() => _hasSavedKey = hasKey);
    }
  }

  Future<void> _handleUnlock() async {
    if (_isUnlocked) {
      // Lock it back
      setState(() {
        _isUnlocked = false;
        _isObscured = true;
      });
      return;
    }

    // Authenticate
    final authenticated = await _vault.authenticate(
      reason: 'settings.api_vault.auth_view_reason'.tr(args: [widget.label]),
    );

    if (authenticated && mounted) {
       // Fetch the latest key securely just in case
       final key = await _vault.retrieveApiKey(widget.providerId, requireAuth: false);
       _controller.text = key ?? '';
       
      setState(() {
        _isUnlocked = true;
        _isObscured = false;
        _hasSavedKey = key != null && key.isNotEmpty;
      });
    }
  }

  Future<void> _saveKey(String value) async {
    if (value.trim().isEmpty) return;
    await _vault.secureApiKey(widget.providerId, value.trim());
    await _keyService.saveKey(widget.providerId, value.trim());
    ref.invalidate(configuredProviderIdsProvider);
    ref.invalidate(providerKeyFutureProvider(widget.providerId));
    ref.invalidate(configuredProvidersProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('common.api_key_saved'.tr(args: [widget.label]))),
      );
      // Lock it back after saving
      setState(() {
        _hasSavedKey = true;
        _isUnlocked = false;
        _isObscured = true;
      });
    }
  }

  Future<void> _deleteKey() async {
    final authenticated = await _vault.authenticate(
      reason: 'settings.api_vault.auth_delete_reason'.tr(args: [widget.label]),
    );
    if (!authenticated) return;
    await _vault.deleteApiKey(widget.providerId);
    await _keyService.removeKey(widget.providerId);
    ref.invalidate(configuredProviderIdsProvider);
    ref.invalidate(providerKeyFutureProvider(widget.providerId));
    ref.invalidate(configuredProvidersProvider);
    if (!mounted) return;
    _controller.clear();
    setState(() {
      _hasSavedKey = false;
      _isUnlocked = false;
      _isObscured = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('settings.api_vault.key_deleted'.tr(args: [widget.label]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Icon(Icons.vpn_key_outlined, color: Colors.purpleAccent, size: 20.sp),
               SizedBox(width: 8.w),
               Expanded(
                 child: Text(
                   widget.label,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: GoogleFonts.cairo(
                     fontSize: 16.sp, 
                     fontWeight: FontWeight.bold,
                     color: Colors.white
                   ),
                 ),
               ),
               // Status Indicator
               Container(
                 width: 8.w,
                 height: 8.w,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: _hasSavedKey ? Colors.greenAccent : Colors.redAccent,
                   boxShadow: [
                     BoxShadow(
                       color: (_hasSavedKey ? Colors.green : Colors.red).withValues(alpha: 0.5),
                       blurRadius: 5
                     )
                   ]
                 ),
               ),
            ],
          ),

          SizedBox(height: 12.h),

          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 360;

              return isCompact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildKeyInput(),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: _buildActionButtons(),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(child: _buildKeyInput()),
                        SizedBox(width: 8.w),
                        ..._buildActionButtons(),
                      ],
                    );
            },
          ),
          
          if (!_isUnlocked && _hasSavedKey)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'settings.api_vault.biometric_secured'.tr(),
                style: GoogleFonts.cairo(color: Colors.white38, fontSize: 10.sp),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKeyInput() {
    return TextField(
      controller: _controller,
      obscureText: _isObscured,
      enabled: _isUnlocked,
      style: GoogleFonts.sourceCodePro(color: Colors.white, fontSize: 13.sp),
      decoration: InputDecoration(
        hintText: _isUnlocked
            ? (widget.hint ?? 'settings.api_vault.enter_key'.tr())
            : (_hasSavedKey ? '••••••••••••••••' : 'settings.api_vault.enter_key'.tr()),
        hintStyle: const TextStyle(color: Colors.white30),
        isDense: true,
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
      onSubmitted: _saveKey,
    );
  }

  List<Widget> _buildActionButtons() {
    return [
      IconButton(
        onPressed: _handleUnlock,
        style: IconButton.styleFrom(
          backgroundColor: _isUnlocked
              ? Colors.redAccent.withValues(alpha: 0.2)
              : Colors.purpleAccent.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        icon: Icon(
          _isUnlocked ? Icons.lock_open : Icons.lock_outline,
          color: _isUnlocked ? Colors.redAccent : Colors.purpleAccent,
          size: 20.sp,
        ),
      ),
      if (_isUnlocked) ...[
        SizedBox(width: 4.w),
        IconButton(
          onPressed: () => _saveKey(_controller.text),
          style: IconButton.styleFrom(
            backgroundColor: Colors.green.withValues(alpha: 0.2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
          icon: Icon(Icons.check, color: Colors.green, size: 20.sp),
        ),
        if (_hasSavedKey) ...[
          SizedBox(width: 4.w),
          IconButton(
            onPressed: _deleteKey,
            style: IconButton.styleFrom(
              backgroundColor: Colors.red.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            icon: Icon(Icons.delete_outline, color: Colors.redAccent, size: 20.sp),
          ),
        ],
      ],
    ];
  }
}
