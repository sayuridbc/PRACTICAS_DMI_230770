# yes_no_app

Aplicación de chat desarrollada con Flutter y Dart. La bandeja **Yess Connect** abre la conversación existente. Las respuestas se sortean localmente; `yesno.wtf` aporta los GIFs.

## Estructura principal

```text
lib/
├── main.dart
├── data/yes_no_api.dart
├── domain/chat_message.dart
├── config/theme/app_theme.dart
└── presentation/
	├── screens/
	│   ├── messages/messages_screen.dart
	│   └── chat/chat_screen.dart
	└── widgets/
		├── chat/
		└── shared/
			├── message_field_box.dart
			└── yess_connect_mark.dart
```

`MessagesScreen` es la bandeja inicial. Su conversación abre la `ChatScreen` existente, sin duplicar la lógica de mensajes ni la integración con la API. `YessConnectMark` dibuja el identificador escalable con Flutter: burbuja, dos nodos conectados y un destello cálido. El acceso tiene tooltip, etiqueta accesible, animación al presionar y respuesta al hover.

La aplicación no almacena un estado de mensajes no leídos; por eso no muestra un contador ficticio.

## Distribución de respuestas

Se genera un entero aleatorio entre 0 y 99 para cada respuesta:

| Rango | Respuesta | Probabilidad |
|---|---|---:|
| 0–39 | Sí | 40% |
| 40–79 | No | 40% |
| 80–99 | Tal vez | 20% |

## Ejecutar y probar

Desde la carpeta `Practica_03`:

```powershell
flutter pub get
flutter run -d chrome
```

Para validar pruebas y análisis estático:

```powershell
flutter test
flutter analyze
```

No se agregaron dependencias.
