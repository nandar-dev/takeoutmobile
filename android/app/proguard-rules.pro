# --- Required to prevent R8 from stripping annotations used by Google Tink and others ---
-keep class com.google.errorprone.annotations.** { *; }
-keep class javax.annotation.** { *; }
-keep class javax.annotation.concurrent.** { *; }
-keep class org.checkerframework.** { *; }
-keepclassmembers class * {
    @com.google.errorprone.annotations.** <methods>;
    @javax.annotation.** <fields>;
}
-dontwarn com.google.errorprone.annotations.**
-dontwarn javax.annotation.**
-dontwarn javax.annotation.concurrent.**