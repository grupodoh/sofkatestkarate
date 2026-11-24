# Automatización de Pruebas con Karate Framework

Este proyecto contiene pruebas automatizadas de API utilizando **Karate Framework** y **JUnit 5**. Esta guía documenta cómo ejecutar de forma específica 2 o más clases *Runner* desde la línea de comandos sin necesidad de lanzar toda la suite de pruebas.

## 📋 Prerrequisitos

Antes de ejecutar las pruebas, asegúrate de contar con:

* **Java JDK** (versión 11 o superior) configurado en las variables de entorno (`JAVA_HOME`).

* **Apache Maven** (versión 3.6 o superior) instalado y accesible desde la terminal.

* Dependencias de Karate (`karate-junit5`) y el plugin `maven-surefire-plugin` configurados en el archivo `pom.xml`.

## 📁 Estructura del Proyecto

Para que Maven reconozca y ejecute correctamente los *Runners* desde la consola, asegúrate de que estén ubicados bajo `src/test/java` con la siguiente estructura de paquetes:

```
src/
└── test/
    └── java/
        └── example/
            ├── users/
            │   ├── user.feature
            │   └── UserRunner.java
            └── search/
                ├── search.feature
                └── SearchRunner.java

```

### Ejemplo de implementación de un Runner (`UserRunner.java`)

Al estar el archivo `.feature` y el *Runner* dentro del mismo paquete (`example.users`), puedes referenciarlo directamente por su nombre relativo:

```
package example.users;

import com.intuit.karate.junit5.Karate;

public class UserRunner {

    @Karate.Test
    public Karate testUsers() {
        return Karate.run("user").relativeTo(getClass());
    }
}

```

## 🚀 Ejecución de Runners Específicos (Ejercicio 2)

Para ejecutar exclusivamente **dos o más clases Runner** específicas (por ejemplo, `UserRunner` y `SearchRunner`), utiliza el parámetro `-Dtest` de Maven separando los nombres de las clases por comas.

### 1. En Windows (PowerShell)

En PowerShell, la coma (`,`) es un carácter reservado para arreglos. Por lo tanto, es **obligatorio** encerrar el argumento entre comillas dobles o simples:

```
mvn test "-Dtest=UserRunner,SearchRunner"

```

*Alternativa:*

```
mvn test -Dtest="UserRunner,SearchRunner"

```

### 2. En Linux / macOS / Git Bash / CMD

En terminales basadas en Unix o el Símbolo del Sistema tradicional (CMD), puedes ejecutarlo directamente o con comillas:

```
mvn test -Dtest=UserRunner,SearchRunner

```

### 3. Ejecución con Gradle (Alternativa)

Si el proyecto utiliza Gradle en lugar de Maven, puedes encadenar el parámetro `--tests` indicando el paquete completo:

```
./gradlew test --tests "example.users.UserRunner" --tests "example.search.SearchRunner"

```

## 📊 Reportes de Ejecución

Una vez finalizada la ejecución en consola, Karate generará automáticamente los reportes detallados en formato HTML. Puedes abrirlos en tu navegador desde la siguiente ruta:

```
target/karate-reports/karate-summary.html

```

## 🛠️ Solución de Problemas Comunes (Troubleshooting)

* **Error `MissingArgument` en PowerShell:** Ocurre si olvidas colocar comillas alrededor de `-Dtest=Runner1,Runner2`. Asegúrate de usar `"-Dtest=UserRunner,SearchRunner"`.

* **Mensaje `No tests were run`:**

  1. Verifica que las clases Runner y los métodos anotados con `@Karate.Test` tengan el modificador de acceso `public`.

  2. Revisa en el archivo `pom.xml` que el plugin `maven-surefire-plugin` incluya el patrón `*Runner.java` dentro de su configuración `<includes>`.
