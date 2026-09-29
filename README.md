
#  Práctica 03 - Aplicación de Chat en Flutter

##  Objetivo

Desarrollar y personalizar una aplicación de chat utilizando **Flutter y Dart**, implementando una interfaz de conversación similar a WhatsApp.

La aplicación permite enviar mensajes y recibir respuestas automáticas con una distribución de:

-  **40% Sí**
-  **40% No**
-  **20% Tal vez**

Además, cada mensaje muestra la **hora en la que fue enviado** dentro de la burbuja de conversación y se agregó un **ícono personalizado para la aplicación**.

---

##  Tecnologías utilizadas

- Flutter
- Dart
- Material Design
- Visual Studio Code
- Chrome
- Git
- GitHub

---

## 📂 Estructura del proyecto

El proyecto está organizado mediante diferentes componentes para separar la pantalla principal del chat y los elementos que forman parte de la conversación.

```text
lib/
├── presentation/
│   ├── screens/
│   │   └── chat/
│   │       └── chat_screen.dart
│   │
│   └── widgets/
│       ├── chat/
│       │   ├── her_message_bubble.dart
│       │   └── my_message_bubble.dart
│       │
│       └── shared/
│           └── message_field_box.dart
```

El archivo `chat_screen.dart` contiene la pantalla principal de la aplicación.

Los archivos `her_message_bubble.dart` y `my_message_bubble.dart` se utilizan para representar los mensajes recibidos y enviados.

El archivo `message_field_box.dart` contiene el campo utilizado para escribir y enviar mensajes.

---

##  Interfaz de chat

La aplicación cuenta con una interfaz de conversación en la que los mensajes enviados y recibidos aparecen mediante burbujas.

El diseño está inspirado en aplicaciones de mensajería como WhatsApp, utilizando diferentes estilos para distinguir los mensajes del usuario y las respuestas.

---

##  Sistema de respuestas automáticas

Se implementó una lógica para generar respuestas automáticas de forma aleatoria.

La aplicación genera un número aleatorio entre **0 y 99** y utiliza diferentes rangos para determinar la respuesta:

| Rango | Respuesta | Probabilidad |
|---|---|---:|
| 0 - 39 |  Sí | 40% |
| 40 - 79 |  No | 40% |
| 80 - 99 |  Tal vez | 20% |

La distribución implementada es:

- **40%** de probabilidad para responder **Sí**.
- **40%** de probabilidad para responder **No**.
- **20%** de probabilidad para responder **Tal vez**.

Esto permite que las respuestas sean diferentes cada vez que el usuario envía un mensaje.

---

##  Hora de envío de los mensajes

Cada mensaje muestra la **hora en la que fue enviado**.

La hora se coloca dentro de la misma burbuja del mensaje y utiliza un tamaño de texto menor para mantener una apariencia similar a una aplicación de mensajería.

Por ejemplo:

```text
Hola ❤️                                      19:42
```

La hora se obtiene a partir de la fecha y hora actual en el momento en que se envía el mensaje.

![Mensajes con hora](images/mensajes_hora.png)

---

##  Ícono personalizado

Se creó un **ícono personalizado para la aplicación**, reemplazando el ícono predeterminado de Flutter.

Esto permite darle una identidad visual propia al proyecto y mejorar su presentación.

---

##  Evidencias de la práctica

### Pantalla principal

La siguiente captura muestra la interfaz principal de la aplicación y la conversación entre el usuario y las respuestas automáticas.

![Pantalla principal](images/chat_principal.png)

### Respuestas automáticas

La aplicación genera respuestas utilizando la distribución solicitada de **40% Sí, 40% No y 20% Tal vez**.

![Respuestas automáticas](images/respuestas.png)

### Hora de envío

Cada mensaje muestra la hora correspondiente dentro de su burbuja.

![Mensajes con hora](images/mensajes_hora.png)

### Ícono personalizado

Se muestra el ícono personalizado utilizado para identificar la aplicación.

![Ícono personalizado](images/icono_app.png)

---

## ✅ Requisitos implementados

| Requisito | Estado |
|---|:---:|
| Crear un ícono personalizado para la app | ✅ |
| Implementar respuestas aleatorias | ✅ |
| Implementar 40% de respuestas "Sí" | ✅ |
| Implementar 40% de respuestas "No" | ✅ |
| Implementar 20% de respuestas "Tal vez" | ✅ |
| Mostrar la hora de envío de cada mensaje | ✅ |
| Mostrar la hora dentro de la burbuja | ✅ |
| Utilizar estilo de burbujas tipo WhatsApp | ✅ |
| Mostrar mensajes enviados y recibidos | ✅ |
| Mantener una interfaz de chat funcional | ✅ |

---

##  Resultado final

Como resultado se obtuvo una aplicación de chat desarrollada en **Flutter**, capaz de recibir mensajes del usuario y generar respuestas automáticas.

La aplicación integra las siguientes características:

- Interfaz de chat.
- Mensajes enviados y recibidos.
- Respuestas automáticas.
- Distribución de 40% Sí, 40% No y 20% Tal vez.
- Hora de envío en cada mensaje.
- Burbujas de conversación estilo WhatsApp.
- Ícono personalizado.

---

##  Conclusión

En esta práctica se reforzaron los conocimientos relacionados con el desarrollo de interfaces utilizando **Flutter y Dart**.

Se trabajó con widgets, componentes reutilizables, generación de valores aleatorios, manejo de fecha y hora, diseño de burbujas de mensajes y personalización de aplicaciones Flutter.

La implementación de las respuestas automáticas permitió aplicar lógica aleatoria dentro de la aplicación, mientras que la incorporación de la hora en cada mensaje permitió crear una experiencia de conversación más completa.

Finalmente, la creación de un ícono personalizado permitió mejorar la identidad visual de la aplicación y complementar la presentación final del proyecto.
````
