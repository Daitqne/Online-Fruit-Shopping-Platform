package controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import utils.GeminiService;
import utils.GeminiService.ChatMessage;

@WebServlet(name = "AIChatServlet", urlPatterns = {"/api/ai-chat"})
public class AIChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userMessage = request.getParameter("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.getWriter().write("{\"response\":\"Vui lòng nhập tin nhắn.\"}");
            return;
        }

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<ChatMessage> history = (List<ChatMessage>) session.getAttribute("ai_chat_history");
        if (history == null) {
            history = new ArrayList<>();
        }

        // Add user message to history
        history.add(new ChatMessage("user", userMessage));

        // Limit conversation history to avoid large payloads (keep up to last 16 messages)
        while (history.size() > 16) {
            history.remove(0);
        }

        // Check if API key is configured
        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            apiKey = System.getProperty("GEMINI_API_KEY");
        }
        if (apiKey == null || apiKey.trim().isEmpty()) {
            apiKey = "AIzaSyA_k_Co_3cmgPeeggNIgILsqYgZ99-B6js";
        }


        String botResponse;
        if (apiKey == null || apiKey.trim().isEmpty()) {
            // API key is not configured - fallback to keyword assistant
            botResponse = getFallbackResponse(userMessage);
        } else {
            // API key is configured - call Gemini API
            String systemInstruction = "Bạn là trợ lý ảo hỗ trợ khách hàng của GreenStock - Cửa hàng Trái cây Tươi Hữu cơ hàng đầu Việt Nam.\n"
                + "Thông tin về GreenStock:\n"
                + "- Sứ mệnh: Tiên phong cung cấp trái cây tươi hữu cơ, an toàn, dinh dưỡng cho gia đình Việt.\n"
                + "- Địa chỉ: Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội, Việt Nam.\n"
                + "- Hotline: 1900 8198\n"
                + "- Email: support@greenstock.vn\n"
                + "Hướng dẫn ứng xử:\n"
                + "1. Luôn chào hỏi thân thiện, xưng hô lịch sự, lễ phép (ví dụ: 'GreenStock xin chào bạn!', 'dạ', 'ạ').\n"
                + "2. Trả lời ngắn gọn, cô đọng, dễ đọc (tránh dài dòng, tối đa 2-3 đoạn ngắn, sử dụng gạch đầu dòng nếu cần thiết).\n"
                + "3. Tập trung tư vấn về trái cây hữu cơ, lợi ích sức khỏe, các chính sách của GreenStock.\n"
                + "4. Nếu khách hàng hỏi về các chính sách:\n"
                + "   - Giao nhận: Giao siêu tốc 2h trong nội thành Hà Nội. Miễn phí ship cho hóa đơn trên 500k.\n"
                + "   - Đổi trả: Hỗ trợ đổi trả trong vòng 24h nếu sản phẩm không đúng chất lượng cam kết hoặc bị dập nát.\n"
                + "5. Trả lời bằng Tiếng Việt.";

            try {
                botResponse = GeminiService.getGeminiResponse(history, systemInstruction);
            } catch (Exception e) {
                System.err.println("[AIChatServlet Error] Gemini API failed: " + e.getMessage());
                botResponse = "Dạ, hệ thống kết nối trí tuệ nhân tạo đang gặp sự cố nhỏ. Tôi xin phép trả lời nhanh:\n\n" + getFallbackResponse(userMessage);
            }
        }

        // Add model response to history
        history.add(new ChatMessage("model", botResponse));
        session.setAttribute("ai_chat_history", history);

        // Return JSON response
        String escapedResponse = escapeJson(botResponse);
        response.getWriter().write("{\"response\":\"" + escapedResponse + "\"}");
    }

    /**
     * Context-aware fallback response generator when Gemini API is unavailable or unconfigured.
     */
    private String getFallbackResponse(String userMessage) {
        String msg = userMessage.toLowerCase();
        if (msg.contains("chào") || msg.contains("hello") || msg.contains("hi") || msg.contains("bắt đầu")) {
            return "Xin chào! Tôi là trợ lý ảo **GreenStock AI**.\n\n"
                 + "Tôi có thể giúp bạn giải đáp các thông tin về sản phẩm trái cây hữu cơ, chính sách giao hàng, đổi trả và cách liên hệ cửa hàng.\n\n"
                 + "*(Lưu ý của hệ thống: Để mở khóa chatbot AI thông minh thực thụ, lập trình viên vui lòng cấu hình biến môi trường `GEMINI_API_KEY` trên hệ thống nhé!)*";
        } else if (msg.contains("giao") || msg.contains("ship") || msg.contains("vận chuyển") || msg.contains("nhận")) {
            return "🚚 **Chính sách Giao nhận của GreenStock:**\n\n"
                 + "- Giao hàng siêu tốc trong vòng **2 giờ** đối với khu vực nội thành Hà Nội.\n"
                 + "- **Miễn phí vận chuyển** cho mọi đơn hàng có giá trị từ **500.000đ** trở lên.\n"
                 + "- Đơn hàng dưới 500.000đ áp dụng phí giao hàng đồng giá 30.000đ.";
        } else if (msg.contains("trái cây") || msg.contains("bán") || msg.contains("quả") || msg.contains("sản phẩm") || msg.contains("món")) {
            return "🍎 **Sản phẩm tại GreenStock:**\n\n"
                 + "Chúng tôi cung cấp các loại trái cây hữu cơ VietGAP/GlobalGAP cao cấp:\n"
                 + "- **Trái cây nhập khẩu:** Táo Envy Mỹ, Nho mẫu đơn Hàn Quốc, Cherry Úc, Lê Nam Phi.\n"
                 + "- **Trái cây Việt Nam:** Cam sành Vĩnh Long, Bơ sáp Đắk Lắk, Bưởi da xanh Bến Tre, Xoài cát Hòa Lộc.\n\n"
                 + "Bạn có thể vào mục **Sản phẩm** trên menu chính để chọn mua hoa quả tươi ngon nhất!";
        } else if (msg.contains("đổi trả") || msg.contains("hoàn tiền") || msg.contains("hỏng") || msg.contains("dập")) {
            return "🔄 **Chính sách Đổi trả hàng:**\n\n"
                 + "- Cam kết hoàn tiền hoặc đổi sản phẩm mới trong vòng **24 giờ** nếu trái cây bị dập nát, hư hỏng hoặc không đúng chất lượng cam kết.\n"
                 + "- Quý khách vui lòng lưu lại hóa đơn và chụp ảnh/quay video sản phẩm gửi cho shop qua hotline để được hỗ trợ xử lý tức thì.";
        } else if (msg.contains("liên hệ") || msg.contains("hotline") || msg.contains("điện thoại") || msg.contains("sđt") || msg.contains("email") || msg.contains("địa chỉ")) {
            return "📞 **Thông tin liên hệ của GreenStock:**\n\n"
                 + "- **Hotline:** 1900 8198 (Hỗ trợ từ 8:00 - 21:00 hàng ngày)\n"
                 + "- **Email:** support@greenstock.vn\n"
                 + "- **Địa chỉ cửa hàng:** Khu Công nghệ cao Hòa Lạc, Thạch Thất, Hà Nội.";
        } else {
            return "Dạ, tôi ghi nhận ý kiến của bạn. Trái cây hữu cơ GreenStock luôn cam kết mang lại sản phẩm tươi sạch và an toàn nhất cho sức khỏe gia đình bạn.\n\n"
                 + "Bạn có thể hỏi tôi về các thông tin như giao hàng, sản phẩm, chính sách đổi trả, hoặc liên hệ trực tiếp với đội ngũ hỗ trợ của chúng tôi nhé!";
        }
    }

    /**
     * Helper to escape special JSON characters for response streaming.
     */
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
