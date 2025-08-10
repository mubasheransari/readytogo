plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // ✅ Required for Google Sign-In and Firebase Messaging
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "app.rrtg.com"
    compileSdk = flutter.compileSdkVersion

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "app.rrtg.com"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            // Consider setting minifyEnabled, shrinkResources, proguard config for production
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.firebase:firebase-messaging:24.0.0") // ✅ Firebase messaging
    implementation("com.google.android.gms:play-services-auth:21.0.0") // ✅ Google Sign-In
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4") // ✅ For Java 11 support
}
