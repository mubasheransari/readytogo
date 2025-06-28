// ✅ Top-level plugins block
plugins {
    id("com.android.application") version "8.7.0" apply false // ✅ Match your Gradle environment
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false // ✅ Match your installed Kotlin version
    id("com.google.gms.google-services") version "4.4.0" apply false // ✅ Firebase plugin
}

// ✅ Required repositories
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Relocate build directory (used in your original setup)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// ✅ Relocate subproject build directories
subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// ✅ Ensure app module is evaluated before others
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
