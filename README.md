# CICS Liberty Web Application
A simple enterprise Java web application that can run in a CICS Liberty JVM server.

This sample demonstrates a simple Java web application using JavaServer Pages to echo information about the CICS task the page is running on.

## Building
The sample can be built using Gradle or Maven.

TODO

## Deploying

1. Deploy the project to zFS.
2. Create a Liberty JVM server. Use the template configuration in config/server.xml to configure Liberty server.
3. Create a CICS bundle definition on the target CICS region.
4. Install the CICS bundle.
