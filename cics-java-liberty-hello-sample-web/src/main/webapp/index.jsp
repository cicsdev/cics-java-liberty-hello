<%@ page import="com.ibm.cics.server.Task" %>
    <!doctype html>
    <html>

    <head>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="styles/cics.css" />

        <title>Hello World Example - CICS Liberty JVM server</title>
    </head>

    <body>
        <header>
            <a href="https://developer.ibm.com/cics/">
                <img src="images/banner.jpg" alt="CICSDev Logo" />
            </a>

            <h1>CICS Liberty JVM server &ndash; Hello World Example</h1>
        </header>
        <main>
            <section id="description">
                <p>This samples demonstrates a basic enterprise Java web application using
                    <abbr title="JavaServer Pages/Jakarta Server Pages">JSP</abbr> to echo some information from the
                    <code>com.ibm.cics.server.Task</code> class.
                </p>
            </section>

            <section id="information">
                <table>
                    <thead>
                        <tr>
                            <th>CICS Region</th>
                            <th>Transaction</th>
                            <th>Program</th>
                            <th>Task number</th>
                            <th>Current user</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <%=System.getenv("com.ibm.cics.jvmserver.applid")%>
                            </td>
                            <td>
                                <%=Task.getTask().getTransactionName()%>
                            </td>
                            <td>
                                <%=Task.getTask().getProgramName()%>
                            </td>
                            <td>
                                <%=Task.getTask().getTaskNumber()%>
                            </td>
                            <td>
                                <%=Task.getTask().getUSERID()%>
                            </td>
                        </tr>
                    </tbody>
                    <caption>Information about the current CICS task</caption>
                </table>
            </section>
        </main>
    </body>

    </html>