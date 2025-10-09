# Colist

Colist es una aplicación Flutter para crear y compartir listas de manera sencilla. Permite a los usuarios autenticarse con Google o Facebook y empezar a gestionar sus propias listas colaborativas.

## Características

- Autenticación con Google y Facebook
- Creación y gestión de listas personalizadas
- Interfaz moderna y amigable
- Compartir listas con otros usuarios

## Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/xexi81/colist.git
   cd colist
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecuta la app:
   ```bash
   flutter run
   ```

## Configuración

- Asegúrate de tener configurados los archivos de Firebase (`google-services.json` para Android y `GoogleService-Info.plist` para iOS).
- Las imágenes y recursos se encuentran en la carpeta `assets/images/`.

## Estructura del proyecto

- `lib/` - Código fuente principal de la app
  - `screens/` - Pantallas principales (ej: `welcome_screen.dart`)
  - `widgets/` - Widgets reutilizables
  - `constants/` - Colores y fuentes
  - `login/` - Servicios de autenticación

## Contribuir

¡Las contribuciones son bienvenidas! Abre un issue o un pull request para sugerir mejoras o reportar errores.

## Licencia

Este proyecto está bajo la licencia MIT.
