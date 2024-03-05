<%@page contentType="text/html" pageEncoding="UTF-8" import="com.ibm.cics.server.Task"%>
<!doctype html>
<html>

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="icon" href="favicon-32x32.png" type="image/png">
    <link rel="stylesheet" href="styles/cics.css" />

    <title>CICS on GitHub - cics-java-liberty-hello</title>
</head>

<body>
    <header>
        <a href="https://cicsdev.github.io">
            <div><b>CICS</b>&nbsp;on GitHub</div>
        </a>
    </header>
    <main>
        <section id="banner"><!-- Decorative --></section>
        <section id="details">
            <div id="repository">
                <a href="https://github.com/cicsdev/cics-java-liberty-hello">
                    <h1>cics-java-liberty-hello</h1>
                </a>
            </div>
            <div>
                <p>This samples demonstrates a basic enterprise Java web application using
                    JavaServer Pages to display some information from
                    the <a href="https://www.ibm.com/docs/api/v1/content/SSGMCP_5.5.0/reference/jcics-javadoc/com/ibm/cics/server/Task.html"><code>com.ibm.cics.server.Task</code></a>
                    class.
                </p>
            </div>
        </section>

        <section id="information">
            <div>
                <h2>CICS region</h2>
                <p>
                    <%=System.getenv("com.ibm.cics.jvmserver.applid") %>
                </p>
            </div>
            <div>
                <h2>JVM server</h2>
                <p>
                    <%=System.getenv("com.ibm.cics.jvmserver.name") %>
                </p>
            </div>
            <div>
                <h2>Transaction</h2>
                <p>
                    <%=Task.getTask().getTransactionName() %>
                </p>
            </div>
            <div>
                <h2>Program</h2>
                <p>
                    <%=Task.getTask().getProgramName() %>
                </p>
            </div>
            <div>
                <h2>Task number</h2>
                <p>
                    <%=Task.getTask().getTaskNumber() %>
                </p>
            </div>
            <div>
                <h2>Current user</h2>
                <p>
                    <%=Task.getTask().getUSERID() %>
                </p>
            </div>
        </section>
    </main>
</body>

</html>