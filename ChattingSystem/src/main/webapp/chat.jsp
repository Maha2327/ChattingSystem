<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Chatting System</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f8;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .chat-container {
            width: 700px;
            height: 600px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            background: #667eea;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chat-header h2 {
            margin: 0;
        }

        .chat-header span {
            font-size: 14px;
        }

        .chat-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: #f8f9fc;
        }

        .message {
            padding: 10px 15px;
            margin-bottom: 12px;
            border-radius: 10px;
            max-width: 70%;
        }

        .sent {
            background: #667eea;
            color: white;
            margin-left: auto;
        }

        .received {
            background: #e5e7eb;
            color: #333;
            margin-right: auto;
        }

        .chat-input {
            display: flex;
            padding: 15px;
            border-top: 1px solid #ddd;
            gap: 10px;
        }

        .chat-input input {
            flex: 1;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .chat-input button {
            padding: 12px 22px;
            border: none;
            border-radius: 8px;
            background: #667eea;
            color: white;
            cursor: pointer;
            font-size: 15px;
        }

        .chat-input button:hover {
            background: #5568d9;
        }

    </style>

</head>

<body>

    <div class="chat-container">

        <div class="chat-header">

            <h2>Chatting System</h2>

            <span>Online</span>

        </div>

        <div class="chat-messages" id="messages">

            <div class="message received">
                Welcome to the Chatting System!
            </div>

        </div>

        <div class="chat-input">

    <input
        type="text"
        id="receiverInput"
        placeholder="Receiver username"
    >

    <input
        type="text"
        id="messageInput"
        placeholder="Type your message..."
    >

    <button onclick="sendMessage()">
        Send
    </button>

</div>

    </div>

<script>

    function sendMessage() {

        let receiver = document.getElementById("receiverInput").value.trim();
        let message = document.getElementById("messageInput").value.trim();

        if (receiver === "" || message === "") {
            alert("Please enter receiver and message.");
            return;
        }

        let formData = new URLSearchParams();

        formData.append("receiver", receiver);
        formData.append("message", message);

        fetch("SendMessageServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: formData.toString()
        })
        .then(response => {

            if (response.ok) {

                document.getElementById("messageInput").value = "";

                loadMessages();

            } else {

                alert("Message could not be sent.");

            }

        })
        .catch(error => {

            console.error("Error:", error);

            alert("Server error occurred.");
        });
    }


    function loadMessages() {

        let receiver = document.getElementById("receiverInput").value.trim();

        if (receiver === "") {
            return;
        }

        fetch("GetMessagesServlet?otherUser=" + encodeURIComponent(receiver))
        .then(response => response.json())
        .then(data => {

            let messages = document.getElementById("messages");

            messages.innerHTML = "";

            data.forEach(item => {

                let messageDiv = document.createElement("div");

                if (item.sender === "<%= session.getAttribute("username") %>") {
                    messageDiv.className = "message sent";
                } else {
                    messageDiv.className = "message received";
                }

                messageDiv.textContent =
                    item.sender + ": " + item.message;

                messages.appendChild(messageDiv);

            });

            messages.scrollTop = messages.scrollHeight;

        })
        .catch(error => {

            console.error("Error loading messages:", error);

        });
    }


    document.getElementById("receiverInput")
        .addEventListener("change", loadMessages);


    setInterval(function() {

        loadMessages();

    }, 3000);

</script>

</body>

</html>