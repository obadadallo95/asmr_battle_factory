import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/core/utils/url_launcher_helper.dart';
import 'package:asmr_battle_factory/config/di/injection.dart';
import 'package:asmr_battle_factory/core/services/security/biometric_vault.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SetupStepper extends StatefulWidget {
  final ProviderCatalogEntry provider;

  const SetupStepper({super.key, required this.provider});

  @override
  State<SetupStepper> createState() => _SetupStepperState();
}

class _SetupStepperState extends State<SetupStepper> {
  final TextEditingController _apiKeyController = TextEditingController();
  bool _isSecure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.provider.requiresKey) {
       return _buildOneTapSetup();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('marketplace_page.steps_title'),
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 15.h),
        
        _buildStep(
          number: 1,
          title: context.tr('marketplace_page.step1_title'),
          description: widget.provider.requiresCreditCard 
              ? context.tr('marketplace_page.step1_desc_card') 
              : context.tr('marketplace_page.step1_desc_free'),
          action: OutlinedButton.icon(
            icon: const Icon(Icons.open_in_new, size: 16),
            label: Text(context.tr('marketplace_page.step1_btn')),
            style: OutlinedButton.styleFrom(
              foregroundColor: widget.provider.brandColorValue,
              side: BorderSide(color: widget.provider.brandColorValue),
            ),
            onPressed: () => _launchUrl(widget.provider.signupUrl ?? widget.provider.websiteUrl),
          ),
        ),
        
        _buildStep(
          number: 2,
          title: context.tr('marketplace_page.step2_title'),
          description: context.tr('marketplace_page.step2_desc'),
          action: TextButton(
             onPressed: () => _launchUrl(widget.provider.docsUrl ?? widget.provider.websiteUrl),
             child: Text(context.tr('marketplace_page.step2_btn')),
          ),
        ),
        
        _buildStep(
          number: 3,
          title: context.tr('marketplace_page.step3_title'),
          description: context.tr('marketplace_page.step3_desc'),
          content: Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Row(
               children: [
                 Expanded(
                   child: TextField(
                     controller: _apiKeyController,
                     obscureText: _isSecure,
                     style: const TextStyle(color: Colors.white),
                     decoration: InputDecoration(
                       hintText: context.tr('marketplace_page.key_placeholder'),
                       hintStyle: const TextStyle(color: Colors.white30),
                       filled: true,
                       fillColor: Colors.black26,
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                       suffixIcon: IconButton(
                         icon: Icon(_isSecure ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
                         onPressed: () => setState(() => _isSecure = !_isSecure),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(width: 10.w),
                 _isLoading 
                 ? const CircularProgressIndicator()
                 : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.provider.brandColorValue,
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    ),
                    onPressed: _saveKey,
                    child: const Icon(Icons.save, color: Colors.white),
                 ),
               ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildOneTapSetup() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: widget.provider.brandColorValue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: widget.provider.brandColorValue),
      ),
      child: Column(
        children: [
           Icon(Icons.bolt, size: 40.sp, color: widget.provider.brandColorValue),
           SizedBox(height: 10.h),
           SizedBox(height: 10.h),
           Text(
             context.tr('marketplace_page.one_tap_title'),
             style: GoogleFonts.cairo(
               fontSize: 18.sp,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),
           ),
           Text(
             context.tr('marketplace_page.one_tap_desc'),
             textAlign: TextAlign.center,
             style: GoogleFonts.cairo(color: Colors.white70),
           ),
           SizedBox(height: 15.h),
           ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: widget.provider.brandColorValue,
               foregroundColor: Colors.white,
               minimumSize: Size(double.infinity, 50.h),
             ),
             onPressed: () {
               Fluttertoast.showToast(msg: context.tr('marketplace_page.activate_success'));
               Navigator.pop(context);
             },
             child: Text('✅ ${context.tr('marketplace_page.one_tap_btn')}'),
           ),
        ],
      ),
    );
  }

  Widget _buildStep({required int number, required String title, required String description, Widget? action, Widget? content}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Center(child: Text('$number', style: const TextStyle(color: Colors.white))),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.cairo(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(description, style: GoogleFonts.cairo(fontSize: 12.sp, color: Colors.white54)),
                if (action != null) ...[
                   SizedBox(height: 5.h),
                   Align(alignment: Alignment.centerLeft, child: action),
                ],
                if (content != null) content,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    await UrlLauncherHelper.launch(
      url,
      context: context,
      errorMessage: context.tr('marketplace.link_error'),
    );
  }

  Future<void> _saveKey() async {
    final key = _apiKeyController.text.trim();
    if (key.isEmpty) return;

    setState(() => _isLoading = true);
    
    try {
      await getIt<BiometricVault>().secureApiKey(widget.provider.id, key);
      if (mounted) {
        Fluttertoast.showToast(
          msg: context.tr('marketplace_page.save_success'),
          backgroundColor: Colors.green,
        );
        Navigator.pop(context); // Close sheet
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: context.tr('marketplace_page.save_fail', args: [e.toString()]),
          backgroundColor: Colors.red,
        );
      }
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }
}
