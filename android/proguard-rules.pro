-keep class com.sun.jna.** { *; }
-keep class * implements com.sun.jna.** { *; }
-dontwarn java.awt.*
-keepclassmembers class * extends com.sun.jna.* { public *; }
-keepclassmembers class * extends com.sun.jna.** {
    <fields>;
    <methods>;
}