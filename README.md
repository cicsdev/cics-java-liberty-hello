# CICS Liberty Web Application
A simple enterprise Java web application that can run in a CICS Liberty JVM server.

This sample demonstrates a simple Java web application using JavaServer Pages to echo information about the CICS task the page is running on.

## Requirements
* CICS TS for z/OS V5.4 or later
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
The sample can be built with CICS Explorer, Gradle or Apache Maven.

### Building with CICS Explorer
TODO

### Building with Gradle
From the `projects/` directory, run the Gradle command.

```sh
gradle clean assemble
```

### Building with Apache Maven
From the `projects/` directory, run the Maven command.

```sh
mvn clean package
```

## Deploying

### Configuring the Liberty JVM server
1. Create a JVM server with a JVM profile based on the template [JVM profile](etc/jvmprofiles/DFHWLP.jvmprofile).
2. Install the JVM server.
3. Configure the Liberty server based on the template [`server.xml`](etc/liberty/server.xml).

### Deploying the application to z/FS
The application can be deployed to z/FS as either a CICS bundle file, or as an application.

#### Deploying a CICS bundle using CICS Explorer
1. Create a new CICS bundle project.
2. Add the `cics-java-liberty-hello-sample-web` project as a Dynamic Web Project include.
3. Deploy the bundle by clicking **Export Bundle Project to z/OS UNIX File System**.

#### Deploying a CICS bundle using command line tools
1. Copy the compressed CICS bundle file to z/FS.
   * Gradle: `projects/cics-java-liberty-hello-sample-bundle/build/distributions/cics-java-liberty-hello-sample-bundle-1.0.0.zip`
   * Maven: `projects/cics-java-liberty-hello-sample-bundle/target/cics-java-liberty-hello-sample-bundle-1.0.0.zip` 
2. Extract the compressed file on z/FS.
   ```sh
   jar xf cics-java-liberty-hello-sample-bundle-1.0.0.zip
   ```

#### Deploying an application using command line tools
1. Copy the application file to z/FS
   * Gradle: `projects/cics-java-liberty-hello-sample-web/build/libs/cics-java-liberty-hello-sample-web-1.0.0.war`
   * Maven: `projects/cics-java-liberty-hello-sample-web/target/cics-java-liberty-hello-sample-web-1.0.0.war`
3. Configure the Liberty server to include the application using the following `server.xml` configuration.
   ```xml
   <application id="cics-java-liberty-app" location="/path/to/cics-java-liberty-hello-sample-web-1.0.0.war" />
   ```

### Configuring the CICS bundle
If the application is deployed as a CICS bundle, use the following steps to define and install the CICS bundle.

1. Create a bundle definition, setting the BUNDLEDIR to the path to the deployed CICS bundle on z/FS.
2. Install the bundle definition.

## Running
1. Ensure the web application started successfully in Liberty by checking for the CWWKT0016I message in the Liberty messages.log:
   > A CWWKT0016I: Web application available (default_host): http://zos.example.com:9080/cics-java-liberty-app-1.0.0
2. Access the URL printed in the CWWKT0016I message (`http://zos.example.com:9080/cics-java-liberty-app-1.0.0/`) to access the JSP.

## License
This project is licensed under [Apache License Version 2.0](LICENSE).
