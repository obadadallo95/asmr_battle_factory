import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asmr_battle_factory/features/marketplace/domain/entities/provider_catalog_entry.dart';

class CostCalculator extends StatefulWidget {
  final ProviderCatalogEntry provider;

  const CostCalculator({super.key, required this.provider});

  @override
  State<CostCalculator> createState() => _CostCalculatorState();
}

class _CostCalculatorState extends State<CostCalculator> {
  double _usage = 10; // Default usage (10 seconds or 10 units)

  @override
  Widget build(BuildContext context) {
    // Only show if we have pricing data
    if (widget.provider.tier == ProviderTier.free && widget.provider.costPerInputUnit == 0) {
       return const SizedBox.shrink();
    }
    
    // Determine unit label
    String unitLabel = context.tr('marketplace_page.unit_image'); // Default fallback? Or should be generic
    double max = 100;
    
    if (widget.provider.function == ProviderFunction.videoGeneration) {
      unitLabel = context.tr('marketplace_page.unit_second');
      max = 60;
    } else if (widget.provider.function == ProviderFunction.imageGeneration) {
      unitLabel = context.tr('marketplace_page.unit_image');
      max = 50;
    } else if (widget.provider.function == ProviderFunction.textGeneration) {
      unitLabel = context.tr('marketplace_page.unit_token');
      max = 1000;
      _usage = 100;
    } else if (widget.provider.function == ProviderFunction.audioGeneration) {
       unitLabel = context.tr('marketplace_page.unit_token'); // Reuse token or add char one? Let's use token for now or add to json
       max = 100;
    }

    // Calculate cost
    // Assuming costPerInputUnit is essentially cost per 1 unit of usage described above for simplicity in mockup.
    // For text, unitQuantity is 1000, cost is per 1000.
    double cost = 0;
    if (widget.provider.unitQuantity > 1) {
       // e.g. 0.005 per 1000 tokens. Usage is in "1K tokens".
       // So if usage is 100 (meaning 100k tokens), cost is 100 * 0.005
       cost = _usage * (widget.provider.costPerInputUnit ?? 0);
    } else {
       // e.g. 0.20 per second. Usage is seconds.
       cost = _usage * (widget.provider.costPerInputUnit ?? 0);
    }
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('marketplace_page.cost_calc_title'),
            style: GoogleFonts.cairo(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            context.tr('marketplace_page.price_label', args: [widget.provider.paidPricing ?? '']),
            style: GoogleFonts.cairo(fontSize: 12.sp, color: Colors.white70),
          ),
          SizedBox(height: 20.h),
          
          Text(
            context.tr('marketplace_page.enter_quantity', args: [_usage.toInt().toString(), unitLabel]),
            style: GoogleFonts.cairo(fontSize: 14.sp, color: Colors.white),
          ),
          
          Slider(
            value: _usage,
            min: 1,
            max: max,
            activeColor: widget.provider.brandColorValue,
            onChanged: (val) {
              setState(() {
                _usage = val;
              });
            },
          ),
          
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('marketplace_page.estimated_cost'),
                  style: GoogleFonts.cairo(color: Colors.white70),
                ),
                Text(
                  '\$${cost.toStringAsFixed(4)}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
