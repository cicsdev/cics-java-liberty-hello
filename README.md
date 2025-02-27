# CICS Liberty Web Application
[![Build](https://github.com/cicsdev/cics-java-liberty-hello/actions/workflows/java.yaml/badge.svg?branch=cicsts%2Fv5.5)](https://github.com/cicsdev/cics-java-liberty-hello/actions/workflows/java.yaml)

A simple enterprise Java web application that can run in a CICS Liberty JVM server.

This sample demonstrates a simple Java web application using JavaServer Pages to echo information about the CICS task the page is running on.

## Requirements
* CICS TS for z/OS V5.5 or later
* Java SE 1.8 or later on the local workstation
* Eclipse with the IBM CICS SDK for Java EE, Jakarta EE and Liberty, or any IDE
  that supports usage of the Maven Central artifact
  [com.ibm.cics:com.ibm.cics.server](https://search.maven.org/artifact/com.ibm.cics/com.ibm.cics.server).
* _Optional_ A build tool such as Apache Maven or Gradle.

## Downloading
- Clone the repository using your IDEs support, such as the Eclipse Git plugin
- **or**, download the sample as a [compressed file](https://github.com/cicsdev/cics-java-template/archive/main.zip) and unzip onto the workstation.

_**Tip:** Eclipse Git provides an 'Import existing Projects' check-box when cloning a repository._

## Building
The sample can be built with CICS Explorer, Gradle or Apache Maven. Using the supplied Gradle or Maven wrappers will give a consistent and updated version of build tooling.

Once run, Gradle will generate a WAR file in the `/cics-java-liberty-hello-web/build/libs` directory, while Maven will generate it in the `/cics-java-liberty-hello-web/target` directory.

The bundle ZIP file for Gradle will be generated in the `/cics-java-liberty-hello-bundle/build/distributions` directory, while Maven will generate it in the `/cics-java-liberty-hello-bundle/target` directory.

### Building with CICS Explorer
The sample should automatically be built in CICS Explorer. If not, select **Project** &rarr; **Build Project**.

### Building with Gradle
From the root directory, run the appropriate Gradle command.

If using the CICS bundle ZIP, the CICS JVM server name should be modified in the jvmserver property in the gradle build properties file to match the required CICS JVMSERVER resource name, or alternatively can be set on the command line.


| Tool | Command |
| ----------- | ----------- |
| Gradle Wrapper (Linux/Mac) | ```./gradlew clean build``` |
| Gradle Wrapper (Windows) | ```gradle.bat clean build``` |
| Gradle (command-line) | ```gradle clean build``` |
| Gradle (command-line & setting jvmserver) | ```gradle clean build -Pcics.jvmserver=MYJVM``` |

### Building with Apache Maven
From the root directory, run the appropriate Maven command.

If building a CICS bundle ZIP the CICS bundle plugin bundle-war goal is driven using the maven verify phase. The CICS JVM server name should be modified in the property in the pom.xml to match the required CICS JVMSERVER resource name, or alternatively can be set on the command line.

| Tool | Command |
| ----------- | ----------- |
| Maven Wrapper (Linux/Mac) | ```./mvnw clean verify``` |
| Maven Wrapper (Windows) | ```mvnw.cmd clean verify``` |
| Maven (command-line) | ```mvn clean verify``` |
| Maven (command-line & setting jvmserver) | ```mvn clean verify -Dcics.jvmserver=MYJVM``` |


<table>
  <tr>
    <th>Tool</th>
    <th>Command</th>
  </tr>
  <tr>
    <td>Maven Wrapper (Linux/Mac)</td>
    <td><pre lang="shell">./mvnw clean verify</pre></td>
  </tr>
  <tr>
    <td>Maven Wrapper (Windows)</td>
    <td><pre lang="shell">mvnw.cmd clean verify</pre></td>
  </tr>
  <tr>
    <td>Maven (command-line)</td>
    <td><pre lang="shell">mvn clean verify</pre></td>
  </tr>
  <tr>
    <td>Maven (command-line & setting jvmserver)</td>
    <td><pre lang="shell">mvn clean verify -Dcics.jvmserver=MYJVM</pre></td>
  </tr>
</table>


## Deploying

### Configuring the Liberty JVM server
1. Create a Liberty JVM server.
2. Install the JVM server.

> [!NOTE]
> The server.xml feature list should be updated to correspond to the JavaEE/JakartaEE your Liberty server is configured to. See the table below.

| EE Version | Feature |
| ----------- | ----------- |
| JEE6 | ```<feature>jsp-2.2</feature>``` |
| JEE7/8 | ```<feature>jsp-2.3</feature>``` |
| JEE9 | ```<feature>pages-3.0</feature>``` |
| JEE10 | ```<feature>pages-3.1</feature>``` |

### Deploying the application to z/FS
The application can be deployed to z/FS as either a CICS bundle file, or as an application.

#### Deploying a CICS bundle using CICS Explorer
1. Create a new CICS bundle project.
2. Add the `cics-java-liberty-hello-web` project as a Dynamic Web Project include.
3. Deploy the bundle by clicking **Export Bundle Project to z/OS UNIX File System**.

#### Deploying a CICS bundle using command line tools
1. Copy the compressed CICS bundle file to z/FS.
   * Gradle: `projects/cics-java-liberty-hello-bundle/build/distributions/cics-java-liberty-hello-bundle-1.0.0.zip`
   * Maven: `projects/cics-java-liberty-hello-bundle/target/cics-java-liberty-hello-bundle-1.0.0.zip` 
2. Extract the compressed file on z/FS.
   ```sh
   jar xf cics-java-liberty-hello-bundle-1.0.0.zip
   ```

#### Deploying an application using command line tools
1. Copy the application file to z/FS
   * Gradle: `projects/cics-java-liberty-hello-web/build/libs/cics-java-liberty-hello-web-1.0.0.war`
   * Maven: `projects/cics-java-liberty-hello-web/target/cics-java-liberty-hello-web-1.0.0.war`
3. Configure the Liberty server to include the application using the following `server.xml` configuration.
   ```xml
   <application id="cics-java-liberty-hello" location="/path/to/cics-java-liberty-hello-web-1.0.0.war" />
   ```

### Configuring the CICS bundle
If the application is deployed as a CICS bundle, use the following steps to define and install the CICS bundle.

1. Create a bundle definition, setting the BUNDLEDIR to the path to the deployed CICS bundle on z/FS.
2. Install the bundle definition.

## Running
1. Ensure the web application started successfully in Liberty by checking for the CWWKT0016I message in the Liberty messages.log:
   > A CWWKT0016I: Web application available (default_host): http://zos.example.com:9080/cics-java-liberty-hello-1.0.0
2. Access the URL printed in the CWWKT0016I message (`http://zos.example.com:9080/cics-java-liberty-hello-1.0.0/`) to access the JSP.
3. When deploying with CICS Explorer, the URL may be (`http://zos.example.com:9080/cics-java-liberty-hello/`) 

## License
This project is licensed under [Eclipse Public License - v 2.0](LICENSE).

