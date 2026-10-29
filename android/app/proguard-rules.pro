# Flutter SharedPreferences keep rules for R8 / Proguard
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class kotlin.coroutines.** { *; }
-dontwarn io.flutter.plugins.sharedpreferences.**
