# Práctica 03 - Aplicación Yes_no_app

## Introducción

En esta práctica se desarrolló una aplicación de chat utilizando **Flutter y Dart**, llamada **Yes_no_app**. La aplicación permite al usuario interactuar mediante mensajes y recibir diferentes tipos de respuestas: **Sí, No y Tal vez**.

La aplicación cuenta con una pantalla principal desde la cual se puede acceder a la conversación. Dentro del chat se muestran los mensajes enviados por el usuario y las respuestas generadas por la aplicación.

Además, la aplicación utiliza diferentes recursos visuales para representar las respuestas y cuenta con una interfaz diseñada para facilitar la interacción con el usuario.

---

## Estructura del proyecto

El proyecto está organizado siguiendo una estructura por capas, separando la lógica de datos, el dominio de la aplicación, la configuración visual y las diferentes pantallas y componentes.

```text
Practica_03/
│
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── assets/
│   └── images/
│       └── chat_app_icon.svg
│
├── images/
│   ├── gif2.jpg
│   ├── hora.png
│   ├── no.png
│   ├── principal.png
│   ├── si.png
│   ├── snoopy.jpg
│   └── talvez.png
│
├── lib/
│   │
│   ├── config/
│   │   └── theme/
│   │       └── app_theme.dart
│   │
│   ├── data/
│   │   └── yes_no_api.dart
│   │
│   ├── domain/
│   │   └── chat_message.dart
│   │
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── chat/
│   │   │   │   └── chat_screen.dart
│   │   │   │
│   │   │   └── messages/
│   │   │       └── messages_screen.dart
│   │   │
│   │   └── widgets/
│   │       ├── chat/
│   │       │   ├── her_message_bubble.dart
│   │       │   └── my_message_bubble.dart
│   │       │
│   │       └── shared/
│   │           ├── message_field_box.dart
│   │           └── yess_connect_mark.dart
│   │
│   └── main.dart
│
├── Archictecture/
│   ├── Practica3-architecture.html
│   ├── Practica3-architecture.json
│   ├── Practica3-arquitectura.md
│   └── ...
│
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

### Descripción de las carpetas principales

* **`lib/`**: contiene el código principal de la aplicación.
* **`config/`**: contiene la configuración visual y el tema de la aplicación.
* **`data/`**: contiene la lógica relacionada con la obtención de las respuestas.
* **`domain/`**: contiene las clases que representan los datos utilizados por la aplicación.
* **`presentation/`**: contiene las pantallas y componentes visuales.
* **`screens/`**: contiene las pantallas principales de la aplicación.
* **`widgets/`**: contiene componentes reutilizables de la interfaz.
* **`images/`**: contiene las imágenes utilizadas dentro de la aplicación.
* **`Archictecture/`**: contiene los archivos relacionados con el diagrama de arquitectura de la práctica.

---

# Pantalla principal

La pantalla principal de la aplicación funciona como la bandeja de conversaciones. En ella se muestra la interfaz de **Yess Connect** y se puede acceder a la conversación existente.

### Captura de pantalla

![Pantalla principal](/Practica_03/images/principal.png)


---

# Respuestas de la aplicación

La aplicación genera diferentes tipos de respuestas para la conversación. Las respuestas utilizadas son:

* **Sí**
* **No**
* **Tal vez**

A continuación se muestran las capturas correspondientes a cada respuesta.

## Respuesta "Sí"

La aplicación muestra una respuesta afirmativa dentro de la conversación.

### Captura
![Si](/Practica_03/images/si.png)

---

## Respuesta "No"

La aplicación también puede generar una respuesta negativa dentro de la conversación.

![No](/Practica_03/images/no.png)

---

## Respuesta "Tal vez"

La aplicación puede generar una respuesta de tipo "Tal vez" como una tercera posibilidad dentro de la conversación.

![Tal vez](/Practica_03/images/talvez.png)

---

# Hora de los mensajes

La aplicación muestra la hora correspondiente a los mensajes dentro de la conversación, permitiendo identificar el momento en el que se realizó la interacción.

![Hora](/Practica_03/images/hora.png)

---

# Pantalla de conversación

La pantalla de conversación permite al usuario enviar mensajes y visualizar las respuestas generadas por la aplicación.

La interfaz utiliza diferentes componentes para representar los mensajes enviados por el usuario y las respuestas recibidas.

---

# Funcionamiento

El flujo principal de la aplicación es el siguiente:

1. El usuario inicia la aplicación.
2. Se muestra la pantalla principal de **Yes_no_app**.
3. El usuario accede a la conversación.
4. El usuario puede enviar un mensaje.
5. La aplicación genera una respuesta.
6. La respuesta puede ser **Sí, No o Tal vez**.
7. Los mensajes se muestran dentro de la conversación junto con su hora correspondiente.

---

# Diagrama de Arquitectura con Archify

![Diagrama](/Practica_03/images/diagrama.png)
https://sayuridbc.github.io/PRACTICAS_DMI_230770/Practica_03/Archictecture/Practica3-architecture.html


# Conclusión

La práctica permitió desarrollar una aplicación de chat utilizando **Flutter y Dart**, organizando el proyecto mediante diferentes capas y componentes.

Se implementó una pantalla principal, una pantalla de conversación, componentes para representar los mensajes y diferentes tipos de respuestas. También se incorporaron recursos visuales para mejorar la presentación de la aplicación.

Con esta práctica se reforzó el uso de **Flutter, widgets, organización de proyectos, manejo de mensajes e interfaces de usuario**.
