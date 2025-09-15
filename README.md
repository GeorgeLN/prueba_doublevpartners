# prueba_dvp

Prueba DVP
Hola a todos, mucho gusto mi nombre es Jorge Enrique López Naranjo.

Hago presentación de mi aplicación para la prueba técnica.

Cositas a tener en cuenta sobre la funcionalidad de la App.
- En la lista de usuarios, se puede hace Scroll hacia un lado a cada uno de los usuarios en caso de que se quiera editar o eliminar dicho usuario (aplica para todos).
- Agregué una opción para agregar más de una dirección para el usuario, dicha opción se encuentra en el AppBar de la interfaz donde se visualiza la información del usuario.
- El botón que me permite agregar un nuevo usuario está presente en todas las interfaces para poder cumplir con la tarea de pintar los datos de usuario independientemente de la interfaz en la que se esté.
- En el caso del testing, al ejecutar el comando "flutter test" me arroja una advertencia "Counter increments smoke test", esto sucede porque estoy utilizando el gestor de estado PROVIDER (sólo ocurre con dicho gestor de estado). Dicha advertencia no genera bugs a largo/corto plazo, la funcionalidad de la app es correcta independientemente de dicha advertencia presentada.

Para el manejo de datos, utilicé un servicio de Firebase llamado "Cloud Firestore" que me permite crear colecciones de datos.
Actualmente el servicio cuenta con una única colección que es para los usuarios.
A continuación presento un "esquema" de como es la estructura de dicha colección de datos para los usuarios:

- users
|_ name (String)
|_ lastname (String)
|_ birthdate (timestamp)
|_ addresses (map)
    |_ address1 (map)
        |_ city (String)
        |_ state (String)
        |_ country (String)

