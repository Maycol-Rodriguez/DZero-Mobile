# DZero - Aplicación para la Gestión de Residuos de Construcción y Demolición

## Descripción

DZero es una aplicación móvil desarrollada en Flutter que tiene como objetivo proporcionar herramientas a la población para facilitar el adecuado tratamiento de los Residuos de Construcción y Demolición (RCD) en Lima Metropolitana. La aplicación utiliza algoritmos de inteligencia artificial para calcular un índice de calidad de los RCD a partir de fotos o en tiempo real utilizando la cámara del smartphone, ofrece mapas de calor de contaminación, centraliza denuncias de vecinos que abandonan los RCD, y conecta a los usuarios con empresas y centros de investigación que procesan estos residuos de construcción.

## Características

- Cálculo de índice de calidad de RCD mediante inteligencia artificial.
- Mapas de calor de contaminación por RCD.
- Centralizador de denuncias de vecinos.

## Instalación

1. Clona el repositorio desde GitHub:
git clone https://github.com/Maycol-Rodriguez/DZero-Mobile.git

2. Abre el proyecto en tu IDE de desarrollo Flutter.

3. Ejecuta el proyecto en tu dispositivo o emulador Android/iOS.

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas contribuir al proyecto, por favor sigue estos pasos:

1. Crea un fork del proyecto.

2. Crea una rama con el nombre de tu nueva función: `git checkout -b nueva-funcion`.

3. Realiza tus cambios y commitea: `git commit -m "Agrega nueva función"`.

4. Haz push a la rama: `git push origin nueva-funcion`.

5. Envía un pull request.

## Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

------------------------------------------------------------------------------------------------------------

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
