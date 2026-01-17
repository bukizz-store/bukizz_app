# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# General Android
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Keep your custom models
-keep class com.bukizz.** { *; }

# Play Core
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**
-keep class * extends com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.splitcompat.* { *; }
-keep class com.google.android.play.core.splitinstall.* { *; }
-keep class com.google.android.play.core.tasks.* { *; }