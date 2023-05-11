# dzero

A new Flutter project.

## Getting Started

# Desarrollo
1. Copiar el .env.template y renombrarlo a .env
2. Cambiar las variables de entorno

# Producción
Para cambiar el nombre de la aplicación:
```
flutter pub run change_app_package_name:main com.rodriguezmallqui.dzero
```

Para cambiar el icono de la aplicación
```
flutter pub run flutter_launcher_icons
```

Android AAB
```
flutter build apk
flutter build appbundle
path: build\app\outputs\bundle\release\app-release.aab
```