import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/services/security/biometric_vault.dart';
import '../../../../config/di/injection.dart';
import '../../../../core/widgets/glass_card.dart';

class SecureApiKeyField extends StatefulWidget {
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
  State<SecureApiKeyField> createState() => _SecureApiKeyFieldState();
}

class _SecureApiKeyFieldState extends State<SecureApiKeyField> {
  final _vault = getIt<BiometricVault>();
  final _controller = TextEditingController();
  bool _isObscured = true;
  bool _isUnlocked = false; // Has user authenticated purely to view/edit?

  @override
  void initState() {
    super.initState();
    _checkExistingKey();
  }

  Future<void> _checkExistingKey() async {
    // Check if key exists without requiring auth initially, just to show "Key Saved" state
    // But Key retrieval normally requires auth.
    // We can try to read it silently or just check if it's not null.
    // If vault requires auth for retrieval, we can't know if it's set without auth.
    // Strategy: Try to retrieve with requireAuth: false.
    final key = await _vault.retrieveApiKey(widget.providerId, requireAuth: false);
    if (mounted) {
      if (key != null && key.isNotEmpty) {
        _controller.text = key; // Populate it but keep obscured
      }
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
      reason: 'Authenticate to view/edit ${widget.label} API Key'
    );

    if (authenticated && mounted) {
       // Fetch the latest key securely just in case
       final key = await _vault.retrieveApiKey(widget.providerId, requireAuth: false);
       _controller.text = key ?? '';
       
      setState(() {
        _isUnlocked = true;
        _isObscured = false;
      });
    }
  }

  Future<void> _saveKey(String value) async {
    await _vault.secureApiKey(widget.providerId, value.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('common.api_key_saved'.tr(args: [widget.label]))),
      );
      // Lock it back after saving
      setState(() {
        _isUnlocked = false;
        _isObscured = true;
      });
    }
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
               Text(
                 widget.label,
                 style: GoogleFonts.cairo(
                   fontSize: 16.sp, 
                   fontWeight: FontWeight.bold,
                   color: Colors.white
                 ),
               ),
               const Spacer(),
               // Status Indicator
               Container(
                 width: 8.w,
                 height: 8.w,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: _controller.text.isNotEmpty ? Colors.greenAccent : Colors.redAccent,
                   boxShadow: [
                     BoxShadow(
                       color: (_controller.text.isNotEmpty ? Colors.green : Colors.red).withValues(alpha: 0.5),
                       blurRadius: 5
                     )
                   ]
                 ),
               ),
            ],
          ),
          
          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  obscureText: _isObscured,
                  enabled: _isUnlocked, // Disable editing until unlocked
                  style: GoogleFonts.sourceCodePro(color: Colors.white, fontSize: 13.sp),
                  decoration: InputDecoration(
                    hintText: _isUnlocked ? (widget.hint ?? 'Enter API Key') : '••••••••••••••••',
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
                ),
              ),
              
              SizedBox(width: 8.w),
              
              // Unlock/Lock Button
              IconButton(
                onPressed: _handleUnlock,
                style: IconButton.styleFrom(
                  backgroundColor: _isUnlocked ? Colors.redAccent.withValues(alpha: 0.2) : Colors.purpleAccent.withValues(alpha: 0.2),
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
              ]
            ],
          ),
          
          if (!_isUnlocked && _controller.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Biometric Secured 🔒',
                style: GoogleFonts.cairo(color: Colors.white38, fontSize: 10.sp),
              ),
            ),
        ],
      ),
    );
  }
}
