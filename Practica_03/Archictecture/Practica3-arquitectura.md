# Analisis de arquitectura - Practica3

## Resultado

El proyecto `Practica_03` es una aplicacion Flutter de chat con respuestas Yes/No obtenidas de un servicio HTTP. Su arquitectura actual es **simple, organizada por responsabilidades en carpetas**. Las carpetas `config`, `data`, `domain` y `presentation` separan temas visuales, acceso HTTP, el objeto de mensaje y la interfaz. No hay evidencia de que implemente MVC, MVVM, Clean Architecture, Repository Pattern ni un gestor de estado como Provider, Riverpod o BLoC.

El estado de conversacion y la coordinacion entre pantalla, widgets y API se concentran en `ChatScreen`. Por ello, aunque el codigo tiene carpetas diferenciadas, no constituye una arquitectura por capas estricta: la pantalla llama directamente a `YesNoApi` y mantiene la lista de mensajes.

## Componentes y responsabilidades

- `lib/main.dart`: define `main()`, `MyApp` y el `MaterialApp`. Configura el titulo, aplica `AppTheme` y establece `ChatScreen` como `home`.
- `lib/config/theme/app_theme.dart`: define `AppTheme` y una paleta basada en `colorSchemeSeed`; configura Material 3.
- `lib/presentation/screens/chat/chat_screen.dart`: pantalla principal y estado del chat. Mantiene `_messages` como `List<ChatMessage>` local, incluye dos mensajes iniciales, recibe texto, agrega mensajes con `setState`, llama a `YesNoApi`, agrega la respuesta y desplaza la lista al final. Tambien libera el `ScrollController` y cierra el cliente HTTP en `dispose()`.
- `lib/presentation/widgets/shared/message_field_box.dart`: campo de texto. Recorta y valida que el texto no este vacio, invoca `onSubmitted`, limpia el campo y devuelve el foco.
- `lib/presentation/widgets/chat/my_message_bubble.dart` y `her_message_bubble.dart`: presentan los mensajes del usuario y las respuestas. La burbuja de respuesta puede mostrar la imagen remota con `Image.network`.
- `lib/domain/chat_message.dart`: modelo inmutable `ChatMessage` con `text`, `isUser`, `sentAt` y `imageUrl` opcional; calcula `formattedTime`.
- `lib/data/yes_no_api.dart`: `YesNoApi` usa `http.Client` y consulta `https://yesno.wtf/api`. Agrega un parametro `request` con una marca de tiempo, aplica un timeout de 10 segundos, valida el estado HTTP y los campos `answer` e `image`, decodifica JSON y devuelve `YesNoReply`. Intenta hasta 10 veces conseguir una URL de imagen que no se haya usado antes. `ChatScreen` convierte cualquier error en un mensaje de fallo para la conversacion.

`images/` contiene recursos visuales locales; `images/snoopy.jpg` se usa como avatar del AppBar. `assets/images/` tambien esta declarado como carpeta de assets en `pubspec.yaml`. Estos recursos no son almacenamiento de mensajes.

## Flujo de informacion

1. La persona escribe en `MessageFieldBox` y envia mediante el boton o la tecla de envio.
2. El widget pasa el texto recortado a `_sendMessage` de `ChatScreen`.
3. `ChatScreen` crea un `ChatMessage` del usuario y lo agrega a `_messages`; `setState` reconstruye `ListView.builder`.
4. La pantalla llama directamente a `YesNoApi.getReply()`.
5. `YesNoApi` hace un GET HTTPS a `yesno.wtf`, decodifica `answer` e `image` del JSON y crea un `YesNoReply`. Los valores de respuesta conocidos se traducen al espanol; se descartan imagenes repetidas durante la ejecucion actual.
6. `ChatScreen` agrega otro `ChatMessage`, ahora con la respuesta y su `imageUrl`. Si la peticion falla, agrega el texto de error y no adjunta imagen.
7. `HerMessageBubble` presenta texto y hora; si recibe `imageUrl`, carga esa imagen desde la red con `Image.network`.

La lista vive en memoria dentro del estado de `ChatScreen`. No hay codigo que la persista al cerrar la aplicacion. Tampoco hay un modelo JSON propio: el JSON se interpreta dentro de `YesNoApi` y se transforma en `YesNoReply`.

## Navegacion

`main()` inicia `MyApp`; `MaterialApp(home: const ChatScreen())` abre directamente la pantalla de chat. La inspeccion de `lib/` no encontro rutas nombradas, `Navigator`, `GoRouter` ni otras pantallas enlazadas. Por tanto, no hay navegacion entre pantallas implementada que representar.

## Datos, API y almacenamiento

La unica API detectada en codigo de aplicacion es `https://yesno.wtf/api`, usada desde `lib/data/yes_no_api.dart` con una peticion GET. La respuesta esperada contiene `answer` y `image`. `Image.network` descarga la imagen usando la URL que entrega la respuesta; el proyecto no fija en su codigo un host separado para esos GIF.

No se encontraron una base de datos, SQLite, SharedPreferences, Firebase, backend propio, autenticacion ni almacenamiento local de conversacion. La coleccion `_usedImageUrls` y `_messages` existen unicamente en memoria durante la ejecucion.

## Dependencias de pubspec.yaml

- `http: ^1.4.0`: dependencia de ejecucion que proporciona `http.Client` para la solicitud a YesNo API.
- `flutter` (SDK): interfaz Material, widgets, estado y `Image.network`.
- `cupertino_icons: ^1.0.8`: esta declarada, pero la inspeccion del codigo Dart no encontro uso arquitectonico de sus iconos.
- `flutter_test` y `flutter_lints`: herramientas de desarrollo. `test/widget_test.dart` incluye una prueba de `YesNoApi` con `MockClient` y otra que comprueba que la aplicacion construye la pantalla de chat.
- `flutter_launcher_icons`: herramienta de desarrollo/configuracion para generar iconos desde `images/snoopy.jpg`; no participa en el flujo de ejecucion del chat.

## Relacion de carpetas con la arquitectura

- `lib/config/theme/`: configuracion visual (`AppTheme`).
- `lib/data/`: comunicacion HTTP y conversion de la respuesta (`YesNoApi`, `YesNoReply`).
- `lib/domain/`: estructura del mensaje de chat (`ChatMessage`).
- `lib/presentation/screens/`: pantalla y coordinacion de interaccion (`ChatScreen`).
- `lib/presentation/widgets/`: campo y burbujas que construyen la interfaz.
- `assets/`, `images/`: imagenes declaradas o usadas como recursos locales.
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/`: proyectos anfitriones y configuracion por plataforma de Flutter. La logica de chat revisada esta en `lib/`; no se encontraron servicios nativos de datos adicionales.
- `test/`: pruebas de widget y de la capa HTTP con cliente simulado.


## Configuracion de red por plataforma

El codigo Dart define una llamada HTTPS, pero los permisos/configuraciones nativos tambien importan. Android declara `android.permission.INTERNET` en los manifiestos `src/debug` y `src/profile`, pero no en `src/main/AndroidManifest.xml`; por tanto, el permiso no queda acreditado para la variante release revisada. En macOS, `DebugProfile.entitlements` activa el sandbox y permiso de red como servidor, mientras `Release.entitlements` solo activa el sandbox y no declara `com.apple.security.network.client`. iOS no contiene una excepcion ATS personalizada y el endpoint del codigo usa HTTPS. Estos archivos describen configuraciones presentes; no se comprobo una compilacion o ejecucion por plataforma.
## Texto para documentacion de la practica

Practica3 implementa una aplicacion Flutter de chat con una organizacion simple por responsabilidades. La interfaz inicia en `ChatScreen`, que mantiene los mensajes en memoria y coordina el campo de entrada, las burbujas de conversacion y la consulta de `YesNoApi`. Cada mensaje se representa con `ChatMessage`. Al enviar texto, la pantalla agrega el mensaje del usuario y solicita una respuesta JSON a `https://yesno.wtf/api` mediante el paquete `http`. La respuesta contiene un texto y una URL de imagen; el texto se muestra en una burbuja y la imagen se carga con `Image.network`. La navegacion se limita a la pantalla principal, definida como `home` de `MaterialApp`. El proyecto no implementa base de datos, persistencia local, autenticacion ni un backend propio.

## Archivos generados

- `Practica3-architecture.html`: diagrama interactivo producido con Archify.
- `Practica3-architecture.json`: especificacion fuente del diagrama.
- `Practica3-architecture.visual-check.json` y capturas PNG: recibo y evidencia automatizada de visualizacion en Chrome.
Nota del visor: Archify no ofrece una interfaz fija en espanol; los controles del visor y el atributo lang quedan en ingles. Los nodos y tarjetas del diagrama estan en espanol.
