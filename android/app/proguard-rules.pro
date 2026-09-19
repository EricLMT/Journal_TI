# Conserve les noms des classes et méthodes Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Conserve les classes utilisées en réflexion (ex: Firebase, JSON)
-keepattributes *Annotation*
-keep class com.google.firebase.** { *; }
-keep class com.google.gson.** { *; }
-keep class kotlin.** { *; }

# Ne pas obfusquer les modèles utilisés
#-keepclassmembers class * {
#    @com.google.gson.annotations.SerializedName <fields>;
#}
# Ignore missing Play Core classes (not using deferred components)
-dontwarn com.google.android.play.core.**