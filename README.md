# CICS Liberty Web Application
[![Build](https://github.com/cicsdev/cics-java-liberty-hello/actions/workflows/java.yaml/badge.svg?branch=cicsts%2Fv5.5)](https://github.com/cicsdev/cics-java-liberty-hello/actions/workflows/java.yaml)

A simple enterprise Java web application that can run in a CICS Liberty JVM server.

This sample demonstrates a simple Java web application using JavaServer Pages to echo information about the CICS task the page is running on.

## Contents

- [cics-java-liberty-hello](./cics-java-liberty-hello) - Top-level project.
- [cics-java-liberty-hello-web](./cics-java-liberty-hello-web) - Web application project.
- [cics-java-liberty-hello-bundle](./cics-java-liberty-hello-bundle) - CICS bundle plug-in based project, contains Web application and WLPH transaction bundle-parts. Use with Gradle and Maven builds.
- [etc/eclipse_projects/com.ibm.cicsdev.wlp.hello.cicsbundle](./etc/eclipse_projects/com.ibm.cicsdev.wlp.hello.cicsbundle) - CICS Explorer based CICS bundle project, contains Web application bundle-part. Use with CICS Explorer 'Export to zFS' deployment capability.


## Prerequisites
- CICS TS V5.5 or later
- Java SE 1.8 or later on the workstation
- One of the following on your workstation:
    - Eclipse with the IBM CICS SDK for Java EE, Jakarta EE and Liberty
    - An IDE of your choice that supports Gradle or Maven (or can run the Wrappers)
    - A command line, to run the Wrappers or to invoke a locally installed version of Gradle or Maven

## Downloading

- Clone the repository using your IDEs support, such as the Eclipse Git plugin
- **or**, download the sample as a [ZIP](https://github.com/cicsdev/cics-java-liberty-hello/archive/main.zip) and unzip onto the workstation

> [!TIP]
> Eclipse Git provides an 'Import existing Projects' check-box when cloning a repository.

## Building 

You can build the sample in a variety of ways:
- Using the implicit compile/build of the Eclipse based CICS Explorer SDK
- Using the built-in Gradle or Maven support of your IDE (For example: *buildship* or *m2e* in Eclipse which integrate with the "Run As..." menu.)
- Using the supplied Gradle or Maven Wrapper scripts (no requirement for an IDE or Gradle/Maven install)
- or you can build it from the command line if you have Gradle or Maven installed on your workstation
  

> [!IMPORTANT]
> The sample comes pre-configured for use with a JDK 1.8 and CICS TS V5.5 Libraries for Java EE & Jakarta EE 8. When you initially import the project to your IDE, if your IDE is not configured for a JDK 1.8, or does not have CICS Explorer SDK installed, you might experience local project compile errors. To resolve issues you should configure the Project's build-path to add/remove your preferred combination of CICS TS, JDK, and Liberty's Enterprise Java libraries (Java EE or Jakarta EE). Resolving errors might also depend on how you wish to build and deploy the sample. If you are building and deploying through CICS Explorer SDK and 'Export to zFS' you should edit the link-app's Project properties. Select 'Java Build Path', on the Libraries tab select 'Classpath', click 'Add Library', select 'CICS with Enterprise Java and Liberty' Library, and choose the appropriate CICS and Enterprise Java versions.
If you are building and deploying with Gradle or Maven then you don't necessarily need to fix the local errors, but to do so, you can do as above, or you can run a tooling refresh on the hello-web project. For example, in Eclipse: right-click on "Project", select "Gradle -> Refresh Gradle Project", **or** right-click on "Project", select "Maven -> Update Project...".

> [!TIP]
> In Eclipse, Gradle (buildship) is able to fully refresh and resolve the local classpath even if the project was previously updated by Maven. However, Maven (m2e) does not currently reciprocate that capability. If you previously refreshed the project with Gradle, you'll need to manually remove the 'Project Dependencies' entry on the Java build-path of your Project Properties to avoid duplication errors when performing a Maven Project Update.


### Option 1: Building with Eclipse

If you are using the Egit client to clone the repo, remember to tick the button to import all projects. Otherwise, you should manually Import the projects into CICS Explorer using File &rarr; Import &rarr; General &rarr; Existing projects into workspace, then follow the error resolution advice above.

### Option 2: Building with Gradle

For a complete build you should run the settings.gradle file in the top-level 'cics-java-liberty-hello' directory which is designed to invoke the individual build.gradle files for each project. 

If successful, a WAR file is created inside the `cics-java-liberty-hello-web/build/libs` directory and a CICS bundle ZIP file inside the `cics-java-liberty-hello-bundle/build/distribution` directory. 

[!NOTE]
In Eclipse, the output 'build' directory is often hidden by default. From the Package Explorer pane, select the three dot menu, choose filters and un-check the Gradle build folder to view its contents.

The JVM server the CICS bundle is targeted at is controlled through the `cics.jvmserver` property, defined in the [`cics-java-liberty-hello-bundle/build.gradle`](cics-java-liberty-hello-bundle/build.gradle) file, or alternatively can be set on the command line:

**Gradle Wrapper (Linux/Mac):**
```shell
./gradlew clean build
```
**Gradle Wrapper (Windows):**
```shell
gradle.bat clean build
```
**Gradle (command-line):**
```shell
gradle clean build
```
**Gradle (command-line & setting jvmserver):**
```shell
gradle clean build -Pcics.jvmserver=MYJVM
```

### Option 3: Building with Apache Maven

For a complete build you should run the pom.xml file in the top-level 'cics-java-liberty-hello' directory. A WAR file is created inside the `cics-java-liberty-hello-web/target` directory and a CICS bundle ZIP file inside the `cics-java-liberty-hello-bundle/target` directory.

If building a CICS bundle ZIP the CICS JVM server name for the WAR bundle part should be modified in the 
 `cics.jvmserver` property, defined in [`cics-java-liberty-hello-bundle/pom.xml`](cics-java-liberty-hello-bundle/pom.xml) file under the `defaultjvmserver` configuration property, or alternatively can be set on the command line.

**Maven Wrapper (Linux/Mac):**
```shell
./mvnw clean verify
```
**Maven Wrapper (Windows):**
```shell
mvnw.cmd clean verify
```
**Maven (command-line):**
```shell
mvn clean verify
```
**Maven (command-line & setting jvmserver):**
```shell
mvn clean verify -Dcics.jvmserver=MYJVM
```



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

### Deploying CICS Bundles with CICS Explorer
1. Optionally, change the name of the JVMSERVER in the .warbundle file of the CICS bundle project from DFHWLP to the name of your JVMSERVER resource defined in CICS. 
2. Export the bundle project to zFS by selecting 'Export Bundle project to z/OS Unix File System' from the context menu.
3. In CICS, create a bundle definition, setting the bundle directory attribute to the zFS location you just exported to, and install it. 

### Deploying CICS Bundles from Gradle or Maven
1. Manually upload the ZIP file from the _cics-java-liberty-hello-bundle/target_ or _cics-java-liberty-hello-bundle/build/distributions_ directory to zFS.
2. Unzip this ZIP file on zFS (e.g. `${JAVA_HOME}/bin/jar xf /path/to/bundle.zip`).
3. Create a CICS BUNDLE resource definition, setting the bundle directory attribute to the zFS location you just extracted to, and install it into the CICS region. 

### Deploying directly with Liberty's application configuration
1. Manually upload the WAR file from the _cics-java-liberty-hello-web/target_ or _cics-java-liberty-hello-web/build/libs_ directory to zFS.
2. Add an `<application>` element to the Liberty server.xml to define the web application.


## Running
1. Ensure the web application started successfully in Liberty by checking for the CWWKT0016I message in the Liberty messages.log:
   > A CWWKT0016I: Web application available (default_host): http://zos.example.com:9080/cics-java-liberty-hello-web-1.0.0
2. Access the URL printed in the CWWKT0016I message (`http://zos.example.com:9080/cics-java-liberty-hello-web-1.0.0/`) to access the JSP.
3. When deploying with CICS Explorer, the URL may be (`http://zos.example.com:9080/cics-java-liberty-hello-web/`) 

## License
This project is licensed under [Eclipse Public License - v 2.0](LICENSE).
