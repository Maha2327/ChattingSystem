<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Chatting System - Login</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 380px;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .login-box h1 {
            margin-bottom: 10px;
            color: #333;
        }

        .login-box p {
            color: #777;
            margin-bottom: 30px;
        }

        .login-box input {
            width: 100%;
            padding: 13px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        .login-box button {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #667eea;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .login-box button:hover {
            background: #5568d9;
        }

    </style>

</head>

<body>

    <div class="login-box">

        <h1>Chatting System</h1>

        <p>Enter your username to continue</p>

        <form action="LoginServlet" method="post">

            <input
                type="text"
                name="username"
                placeholder="Enter Username"
                required
            >

            <button type="submit">
                Login
            </button>

        </form>

    </div>

</body>
</html>