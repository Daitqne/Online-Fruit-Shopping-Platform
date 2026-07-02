/* AI Chatbot Frontend Interactivity */

document.addEventListener("DOMContentLoaded", function () {
    const chatWidget = document.getElementById("ai-chat-widget");
    if (!chatWidget) return;

    // Get context path from data attribute set in footer.jsp
    const contextPath = chatWidget.getAttribute("data-context-path") || "";
    const apiEndpoint = `${contextPath}/api/ai-chat`;

    const chatToggle = document.getElementById("ai-chat-toggle");
    const chatWindow = document.getElementById("ai-chat-window");
    const chatClose = document.getElementById("ai-chat-close");
    const chatMessages = document.getElementById("chat-messages-list");
    const chatForm = document.getElementById("chat-input-form");
    const chatInput = document.getElementById("chat-message-input");
    const chatBadge = chatToggle.querySelector(".chat-badge");
    const quickReplies = document.querySelectorAll(".quick-reply-btn");

    let isChatOpen = false;
    let typingIndicatorElement = null;

    // Toggle Chat Window
    function toggleChat() {
        isChatOpen = !isChatOpen;
        if (isChatOpen) {
            chatWindow.classList.remove("hidden");
            chatInput.focus();
            scrollToBottom();
            // Hide badge when first opened
            if (chatBadge) {
                chatBadge.style.display = "none";
            }
        } else {
            chatWindow.classList.add("hidden");
        }
    }

    chatToggle.addEventListener("click", toggleChat);
    chatClose.addEventListener("click", toggleChat);

    // Auto scroll to bottom
    function scrollToBottom() {
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    // Format current time
    function getFormattedTime() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        return `${hours}:${minutes}`;
    }

    // Escape HTML and parse basic Markdown (**bold**, * bullet, \n newline)
    function parseMessageText(text) {
        if (!text) return "";
        
        // 1. Escape HTML to prevent XSS
        let formatted = text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
        
        // 2. Convert markdown bold (**text**) to HTML <strong>
        formatted = formatted.replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>");
        
        // 3. Convert markdown bullet points (* item or - item)
        formatted = formatted.replace(/^\s*[\*\-]\s+(.*?)$/gm, "• $1");
        
        // 4. Convert newlines to HTML break lines
        formatted = formatted.replace(/\n/g, "<br>");
        
        return formatted;
    }

    // Append Message to UI
    function appendMessage(sender, text) {
        const messageDiv = document.createElement("div");
        messageDiv.className = `chat-msg ${sender}`;
        
        const bubble = document.createElement("div");
        bubble.className = "chat-msg-bubble";
        bubble.innerHTML = parseMessageText(text);
        
        const time = document.createElement("span");
        time.className = "chat-msg-time";
        time.innerText = getFormattedTime();
        
        messageDiv.appendChild(bubble);
        messageDiv.appendChild(time);
        chatMessages.appendChild(messageDiv);
        
        scrollToBottom();
    }

    // Show Typing Indicator
    function showTypingIndicator() {
        if (typingIndicatorElement) return;

        const indicatorDiv = document.createElement("div");
        indicatorDiv.className = "chat-msg bot typing-indicator-container";

        const bubble = document.createElement("div");
        bubble.className = "chat-msg-bubble typing-indicator";
        bubble.innerHTML = `
            <span class="typing-dot"></span>
            <span class="typing-dot"></span>
            <span class="typing-dot"></span>
        `;

        indicatorDiv.appendChild(bubble);
        chatMessages.appendChild(indicatorDiv);
        typingIndicatorElement = indicatorDiv;
        scrollToBottom();
    }

    // Hide Typing Indicator
    function hideTypingIndicator() {
        if (typingIndicatorElement && typingIndicatorElement.parentNode) {
            typingIndicatorElement.parentNode.removeChild(typingIndicatorElement);
            typingIndicatorElement = null;
        }
    }

    // Submit user message to Servlet
    async function handleUserSubmit(text) {
        const trimmedText = text.trim();
        if (!trimmedText) return;

        // 1. Show message on screen
        appendMessage("user", trimmedText);
        chatInput.value = "";

        // 2. Show typing indicator
        showTypingIndicator();

        // 3. Send AJAX request to Servlet
        try {
            const response = await fetch(apiEndpoint, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                },
                body: new URLSearchParams({
                    "message": trimmedText
                })
            });

            if (!response.ok) {
                throw new Error("HTTP error " + response.status);
            }

            const data = await response.json();
            
            // Hide loader and append bot response
            hideTypingIndicator();
            if (data && data.response) {
                appendMessage("bot", data.response);
            } else {
                appendMessage("bot", "Rất tiếc, tôi không nhận được câu trả lời hợp lệ.");
            }
        } catch (error) {
            console.error("Chat API error:", error);
            hideTypingIndicator();
            appendMessage("bot", "Hệ thống đang bận hoặc có lỗi kết nối. Vui lòng thử lại sau giây lát.");
        }
    }

    // Bind form submit
    chatForm.addEventListener("submit", function (e) {
        e.preventDefault();
        const text = chatInput.value;
        handleUserSubmit(text);
    });

    // Bind quick replies
    quickReplies.forEach(button => {
        button.addEventListener("click", function () {
            const query = this.getAttribute("data-query");
            if (query) {
                handleUserSubmit(query);
            }
        });
    });
});
