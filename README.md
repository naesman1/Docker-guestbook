🚀 Guestbook App con Observabilidad (Node.js, MySQL, Prometheus, Loki, Grafana)

¡Bienvenido al proyecto Guestbook! Este proyecto es un contador que registra las visitas a una página web en este caso montada en localhost y tambien tiene la posibilidad de guardar tu correo para firmar el libro de vistas con la fecha y hora de tu ultima visita!!!

Esta guía te ayudará a levantar una aplicación de ejemplo con Node.js y MySQL, y lo más importante, ¡un stack de observabilidad completo! Esto te permitirá monitorear métricas y logs en tiempo real usando Prometheus, Loki y Grafana.

📋 Prerrequisitos
Antes de empezar, asegúrate de tener lo siguiente instalado en tu sistema:

Docker Desktop: Incluye Docker Engine y Docker Compose. Puedes descargarlo desde docker.com.

Git: Para clonar este repositorio. Descárgalo desde git-scm.com.

Un editor de código: Como Visual Studio Code.

🛠️ Estructura del Proyecto

Este proyecto está organizado de la siguiente manera:

```
guestbook/
├── app/
│   ├── index.js             # ¡Aquí debe estar SIEMPRE!
│   ├── package.json
│   └── Dockerfile
├── mysql-init/
│   └── schema.sql
├── prometheus/
│   └── prometheus.yml
├── loki/
│   └── local-config.yaml
├── promtail/
│   └── config.yml
├── .env                     # Tu archivo .env (privado)
└── docker-compose.yml       # El archivo principal
```

🚀 Levantando el Proyecto Parte 1

Sigue estos pasos cuidadosamente para poner todo en marcha.

1. Clonar el Repositorio (si aún no lo has hecho)

Si todavía no tienes el código, clónalo desde GitHub:

```
  git clone https://github.com/KeepCodingCloudDevops12/guestbook
  
  cd guestbook
```
🔒 Variables de Entorno (.env)

Por razones de seguridad, el archivo .env que contiene credenciales sensibles no se comparte en este repositorio. Lo recibirás por separado y de forma privada (por ejemplo, a través de un gestor de contraseñas seguro o un canal cifrado).

Crear y cargar el archivo .env

1. Una vez que recibas el archivo .env de forma segura, guárdalo en la carpeta raíz de este proyecto (al mismo nivel que docker-compose.yml).

2. Abre una terminal de PowerShell (si estás en Windows) o tu terminal favorita (Linux/macOS).

3. Navega hasta la carpeta raíz del proyecto guestbook:

```
  cd guestbook/ # Ajusta esta ruta a la de tu proyecto. La ruta escrita es un ejemplo
```

2. Limpiar la Caché de Docker (¡Muy Importante!)
Para evitar problemas de construcción de imágenes, es una buena práctica limpiar la caché de Docker.

```
docker builder prune -f
```
Si el problema persiste, puedes usar un comando más agresivo (borra todo lo no usado):
```
docker system prune --all --volumes -f
```

3.  Construir y Levantar Todos los Servicios

Este comando construirá las imágenes necesarias (incluida tu aplicación Node.js) y levantará todos los servicios definidos en docker-compose.yml en segundo plano.

Asegúrate de haber cargado tus variables de entorno en la terminal antes de ejecutar esto.

```
  docker compose down -v # Opcional, para limpiar cualquier ejecución previa
  
  docker compose up --build -d
```
  #docker compose down -v: Detiene y elimina todos los contenedores, redes y volúmenes (-v) asociados al proyecto. Es útil para empezar desde un estado limpio.

  #docker compose up --build -d:

  #--build: Fuerza la reconstrucción de las imágenes (esencial si has hecho cambios en tu Dockerfile o package.json).

  #-d: Ejecuta los contenedores en modo "detached" (segundo plano), liberando tu terminal.

✅ Verificando que Todo Funciona
Una vez que el comando anterior haya finalizado, puedes empezar a probar tu setup.

1. Verificar el Estado de los Contenedores
Asegúrate de que todos los servicios estén corriendo y en buen estado:
```
docker compose ps
```
Deberías ver todos los servicios (app, db, prometheus, loki, promtail, grafana) con un estado running y eventualmente (healthy).

2. Probar la Aplicación Web (Guestbook)
```
Abre tu navegador y visita: http://localhost:3000
```
Interactúa con la aplicación (por ejemplo, añade algunas entradas) para asegurarte de que la base de datos funciona.

3. Acceder a Grafana para Observabilidad (¡Lo Bueno!)
Grafana es tu panel de control central para métricas y logs.

  Abre tu navegador y ve a:
```
  http://localhost:3001
```
  Inicia sesión:
```
  Usuario: admin
```
```
  Contraseña: password 
```
Añadir Fuentes de Datos (Si no lo hiciste antes):

  En el menú lateral de Grafana, ve a Connections (o el icono de la rueda dentada en versiones antiguas) -> Data sources.

   Haz clic en Add data source.

  Para Prometheus:

   Selecciona Prometheus.

   En URL, introduce:
   ``` 
   http://prometheus:9090
 ```

   Haz clic en Save & test. Deberías ver un mensaje de éxito.

  Para Loki:

   Selecciona Loki.

   En URL, introduce:
   
   ```
   http://loki:3100
```

   Haz clic en Save & test. Deberías ver un mensaje de éxito.

  Explorar Métricas y Logs:

   En el menú lateral de Grafana, haz clic en el icono Explore (la brújula).

   Para ver Métricas (de tu app):

   En el selector de fuente de datos en la parte superior, elige Prometheus.

   En el campo de consulta (Query), puedes empezar a escribir métricas, por ejemplo: http_requests_total para ver el total de solicitudes HTTP de tu aplicación.

  Para ver Logs (de tu app y DB):

   En el selector de fuente de datos, elige Loki.

   En el campo de "Log labels" (o "Log browser"), puedes escribir una consulta LogQL simple, como: {container_name="guestbook-app-1"} para ver los logs de tu aplicación Node.js, o {container_name="guestbook-db-1"} para los logs de MySQL.

   Haz clic en Run query (o presiona Shift+Enter).

¡Si puedes ver métricas y logs en Grafana, significa que tu stack de observabilidad está funcionando a la perfección!

🛑 Detener y Limpiar el Proyecto
Cuando hayas terminado de trabajar, puedes detener y eliminar todos los contenedores, redes y volúmenes asociados a este proyecto para liberar recursos:
```
  docker compose down #Detiene y elimina los contenedores sin eliminar los volumenes manteniendo la informacion salvada previamente en la base de datos y los logs 
```
```  
  docker compose down -v #Detiene y elimina contenedores y los volumenes borrando toda la informacion de la base de datos y de los logs
```
¡Eso es todo! Ahora tienes una aplicación funcional con capacidades de monitoreo de clase mundial. KeepCoding Rules!
