<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>🚀 Deployment Success - Sample App</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            margin: 0;
            padding: 0;
            color: #333;
            text-align: center;
        }
        header {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2e86de;
            margin-bottom: 10px;
        }
        h2 {
            margin-top: 40px;
            color: #222;
        }
        .content {
            padding: 30px;
            max-width: 800px;
            margin: auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            margin-top: 40px;
        }
        p {
            font-size: 16px;
            line-height: 1.6;
        }
        strong {
            color: #e74c3c;
        }
        a {
            color: #2980b9;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .commands {
            background: #f4f4f4;
            border-radius: 8px;
            padding: 15px;
            margin: 20px auto;
            display: inline-block;
            font-family: monospace;
        }
        footer {
            margin-top: 50px;
            padding: 20px;
            background: #2e86de;
            color: white;
        }
    </style>
</head>
<body>
<header>
    <h1>🎉 Congratulations!</h1>
    <img src="boxfuse.png" alt="Boxfuse Logo" width="120">
    <h2>You have successfully launched your Instance! 🚀</h2>
</header>

<div class="content">
    <p>This Instance is running on <strong><%= System.getenv("BOXFUSE_PLATFORM_NAME") %></strong>  
    and has the id <strong><%= System.getenv("BOXFUSE_INSTANCE_ID") %></strong>.</p>

    <p>It is based on the Image <strong><%= System.getenv("BOXFUSE_IMAGE_COORDINATES")%></strong>,  
    generated from <strong><%= System.getenv("BOXFUSE_PAYLOAD_NAME")%></strong>.</p>

    <% if("virtualbox".equals(System.getenv("BOXFUSE_PLATFORM_ID"))) { %>
        <h2>🛠 Next Steps</h2>

        <p>Display the Instance console:</p>
        <div class="commands">boxfuse logs <%= System.getenv("BOXFUSE_INSTANCE_ID") %></div>

        <p>List all running Instances:</p>
        <div class="commands">boxfuse ps</div>

        <p>List all Bootable Apps:</p>
        <div class="commands">boxfuse ls</div>

        <p>Gracefully kill the Instance:</p>
        <div class="commands">boxfuse kill <%= System.getenv("BOXFUSE_INSTANCE_ID") %></div>

        <p>Deploy this Image unchanged on AWS:</p>
        <div class="commands">boxfuse run -env=prod <%= System.getenv("BOXFUSE_APP")%>:<%= System.getenv("BOXFUSE_IMAGE_VERSION")%></div>

    <% } else { %>
        <h2>✨ Now it's your turn!</h2>
        <p>Check out <a href="https://github.com/boxfuse/boxfuse-sample-java-war-hello">this app</a> from GitHub, modify it, and give it version 2.  
        You are now ready to fuse and <strong>deploy it with zero downtime</strong> 🚀.</p>

        <p>Alternatively, go back to the <a href="https://console.boxfuse.com">Boxfuse Console</a> and create your own app.</p>

        <p>If you need help, check out the <a href="http://boxfuse.com/docs">documentation</a> 📖,  
        or email us at <a href="mailto:support@boxfuse.com">support@boxfuse.com</a>.</p>

        <p>Say goodbye to snowflake servers ❄️ and hello to smooth deployments!</p>
        <h3><strong>Enjoy Boxfuse 💙</strong></h3>
    <% } %>
</div>

<footer>
    &copy; <%= java.time.Year.now() %> Boxfuse Inc. | Deployment made simple
</footer>
</body>
</html>
