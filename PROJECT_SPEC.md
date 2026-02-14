
# 🎬 ASMR Battle Royale Generator - Technical Specification
**الإصدار:** 1.0.0  
**التاريخ:** فبراير 2026  
**المنصة:** Flutter (Android Mobile)  
**الأرشيفية:** Clean Architecture + Feature-First  

---

## 1. 🏗️ الهيكل العام للمشروع (Project Architecture)

```
lib/
├── main.dart                    # نقطة الدخول فقط (50 سطر كحد أقصى)
├── app.dart                     # MaterialApp + Config
├── core/                        # الأساسيات المشتركة
│   ├── constants/               # ثوابت التطبيق (Colors, API URLs)
│   ├── theme/                   # الثيم والتصميم
│   ├── utils/                   # مساعدات (Helpers, Extensions)
│   └── services/                # خدمات أساسية (Logger, Local DB)
├── features/                    # الميزات (كل feature مجلد مستقل)
│   ├── generator/               # ميزة التوليد الرئيسية
│   │   ├── data/                # طبقة البيانات (API calls, Models)
│   │   ├── domain/              # طبقة المنطق (Entities, UseCases)
│   │   └── presentation/        # طبقة العرض (UI + State Management)
│   │       ├── pages/           # الصفحات الكاملة
│   │       ├── widgets/         # الويدجت المخصصة (كل زر هنا!)
│   │       └── bloc/            # حالة الصفحة (Cubit/Riverpod)
│   ├── preview/                 # ميزة معاينة الفيديو
│   └── settings/                # ميزة الإعدادات (API Keys)
├── l10n/                        # ملفات الترجمة (ARB files)
└── widgets/                     # ويدجت عالمية مشتركة (Global)
    ├── buttons/                 # كل زر هنا في ملف منفصل!
    ├── typography/              # نصوص مخصصة
    └── layouts/                 # هياكل تخطيطات
```

---

## 2. 📐 معايير الكتابة الصارمة (Code Standards)

### أ. حجم الملفات (File Size Policy)
```dart
// ❌ ممنوع: ملف فيه 500 سطر
// ✅ مسموح: ملف أقل من 300 سطر (أفضل 200 سطر)

// إذا وصلت 280 سطر، قسّم الملف إلى جزأين
// مثال: video_generator.dart → video_generator.dart + video_processor.dart
```

### ب. مبدأ "الزر = ملف" (One Widget Per File)
```dart
// lib/widgets/buttons/primary_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 56.h), // استخدم .h للارتفاع المتجاوب
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), // استخدم .r للزوايا
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              text,
              style: TextStyle(
                fontSize: 16.sp, // استخدم .sp للنصوص (Responsive)
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
```

### ج. نظام اللوجينج (AppLog) - استخدام Logger
```yaml
# pubspec.yaml
dependencies:
  logger: ^2.5.0
```

```dart
// lib/core/services/app_logger.dart
import 'package:logger/logger.dart';

class AppLog {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) => 
      _logger.e(message, error: error, stackTrace: stackTrace);
}

// طريقة الاستخدام في أي ملف:
// AppLog.info('جاري توليد الفكرة...');
// AppLog.error('فشل الاتصال', error, stackTrace);
```

---

## 3. 🎨 نظام التصميم (Design System)

### أ. النصوص المتجاوبة (Responsive Typography)
**ممنوع استخدام:** `fontSize: 20` (ثابت)  
**الإجباري:** `fontSize: 20.sp`

```dart
// lib/core/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle get headline => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );
  
  static TextStyle get body => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );
      
  static TextStyle get button => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );
}
```

### ب. الألوان (App Colors)
```dart
// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00BFA6);
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color error = Color(0xFFCF6679);
  static const Color onPrimary = Colors.white;
}
```

### ج. المسافات (Responsive Spacing)
```dart
// lib/core/theme/app_spacing.dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;
  static double get xxl => 48.w;
}
```

---

## 4. 🌐 نظام الترجمة (Localization)

```yaml
# pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  easy_localization: ^3.0.7  # أو flutter_gen
```

```arb
// lib/l10n/app_ar.arb
{
  "@@locale": "ar",
  "appTitle": "مصنع المعارك",
  "generateIdea": "ولّد فكرة مجنونة",
  "battleRoyal": "معركة ملكية",
  "settings": "الإعدادات"
}

// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "appTitle": "Battle Factory",
  "generateIdea": "Generate Crazy Idea",
  "battleRoyal": "Battle Royale",
  "settings": "Settings"
}
```

**استخدامها في الكود:**
```dart
Text(context.tr('generateIdea')) // مع easy_localization
```

---

## 5. 📱 توزيع الصفحات والأزرار (Navigation)

### الصفحات الرئيسية (4 صفحات فقط):
1. **SplashPage** (2 ثانية ثم انتقال)
2. **HomePage** (التوليد الرئيسي)
3. **PreviewPage** (معاينة الفيديو قبل الحفظ)
4. **SettingsPage** (API Keys + Language)

### هيكل ملفات الأزرار (Buttons):
```
lib/widgets/buttons/
├── primary_button.dart          # الزر الأساسي (البنفسجي)
├── secondary_button.dart        # الزر الثانوي (الأخضر)
├── icon_button.dart             # زر الأيقونة (للإعدادات)
├── generate_button.dart         # زر التوليد الكبير (مخصص)
├── platform_selector_button.dart # زر اختيار المنصة (TikTok/YouTube)
└── download_button.dart         # زر التحميل
```

### هيكل ملفات الصفحات:
```
lib/features/generator/presentation/pages/
├── home_page.dart               # أقل من 300 سطر
└── widgets/                     # ويدجت خاصة بهذه الصفحة فقط
    ├── battle_arena.dart        # منطقة عرض المعركة
    ├── idea_card.dart           # كارت الفكرة
    └── contestants_grid.dart    # شبكة المتنافسين (4 عناصر)
```

---

## 6. 📦 الباكيجات المطلوبة (2026 Latest)

```yaml
# pubspec.yaml
name: asmr_battle_factory
description: Personal ASMR Battle Royale Generator
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.6.0 <4.0.0'
  flutter: '>=3.27.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Core & UI (2026 Latest)
  flutter_screenutil: ^5.9.3      # للقياسات المتجاوبة (Responsive)
  google_fonts: ^6.2.1            # خطوط Google
  flutter_svg: ^2.0.17            # SVG Icons
  shimmer: ^3.0.0                 # تأثير التحميل (Skeleton)
  
  # State Management (اختر واحد فقط)
  flutter_bloc: ^9.0.0            # أو
  flutter_riverpod: ^2.6.1        # أو
  get: ^4.7.2                     # للتنقل والحالة
  
  # Localization
  easy_localization: ^3.0.7
  
  # Services & APIs
  dio: ^5.8.0                     # HTTP Client (أفضل من http)
  retrofit: ^4.4.0                # API Generator (اختياري)
  logger: ^2.5.0                  # Logging
  
  # Storage
  hive: ^2.2.3                    # Local DB سريع (أو SharedPreferences)
  hive_flutter: ^1.1.0
  path_provider: ^2.1.5
  
  # Video & Media (مهم جداً)
  flutter_ffmpeg: ^0.4.2          # مونتاج الفيديو على الجهاز
  video_player: ^2.9.3            # عرض الفيديو
  permission_handler: ^11.4.0     # صلاحيات التخزين
  
  # AI & Generation
  google_generative_ai: ^0.4.6    # Gemini API
  http: ^1.3.0                    # للصور من Pollinations
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0           # قواعد كتابة صارمة
  build_runner: ^2.4.15           # لتوليد الكود (Retrofit, Hive, etc)

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
    - assets/sounds/
    - lib/l10n/                    # ملفات الترجمة
```

---

## 7. 🔧 مثال على ملف كامل (Home Page)

```dart
// lib/features/generator/presentation/pages/home_page.dart
// الحجم: أقل من 300 سطر (Target: 250 line)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/app_logger.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/buttons/generate_button.dart';
import '../../../../widgets/buttons/platform_selector_button.dart';
import '../widgets/battle_arena.dart';
import '../widgets/idea_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? currentIdea;
  bool isGenerating = false;
  String selectedPlatform = 'TikTok';

  Future<void> _generateBattle() async {
    AppLog.info('بدء توليد معركة جديدة');
    setState(() => isGenerating = true);
    
    try {
      // منطق التوليد هنا (استدعاء Gemini)
      await Future.delayed(const Duration(seconds: 2)); // مؤقت
      
      setState(() {
        currentIdea = 'نمل vs نحل vs صرصور vs عنكبوت';
        isGenerating = false;
      });
      
      AppLog.info('تم توليد الفكرة: $currentIdea');
    } catch (e, stack) {
      AppLog.error('فشل التوليد', e, stack);
      setState(() => isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('مصنع المعارك', style: TextStyle(fontSize: 20.sp)),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            
            // اختيار المنصة
            PlatformSelectorButton(
              selected: selectedPlatform,
              onChanged: (p) => setState(() => selectedPlatform = p),
            ),
            
            SizedBox(height: 32.h),
            
            // عرض المعركة (4 عناصر)
            const Expanded(child: BattleArena()),
            
            SizedBox(height: 24.h),
            
            // عرض الفكرة إذا وجدت
            if (currentIdea != null) ...[
              IdeaCard(text: currentIdea!),
              SizedBox(height: 16.h),
            ],
            
            // زر التوليد الرئيسي
            GenerateButton(
              isLoading: isGenerating,
              onPressed: _generateBattle,
            ),
            
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
```

---

## 8. ✅ قائمة التحقق قبل البدء (Checklist)

- [ ] إنشاء المجلدات بالهيكل المذكور أعلاه
- [ ] إضافة الباكيجات في `pubspec.yaml` وتشغيل `flutter pub get`
- [ ] إعداد `AppLog` في ملف منفصل
- [ ] إعداد `AppColors` و `AppTextStyles`
- [ ] إعداد `easy_localization` مع ملفين AR و EN
- [ ] إعداد `flutter_screenutil` في `main.dart`:
```dart
ScreenUtilInit(
  designSize: const Size(375, 812), // iPhone X size (Base)
  minTextAdapt: true,
  splitScreenMode: true,
  child: MyApp(),
)
```
- [ ] إنشاء أول زر في `widgets/buttons/primary_button.dart`
- [ ] التأكد أن كل ملف جديد لا يتجاوز 300 سطر (تعليق في أول الملف: `// Lines: 45/300`)

---