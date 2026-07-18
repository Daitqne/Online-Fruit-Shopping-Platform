package utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class GeminiService {

    private static final String MODEL_NAME = "gemini-2.5-flash";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/" + MODEL_NAME + ":generateContent?key=";


    // ChatMessage model nested for convenience
    public static class ChatMessage {
        private String role; // "user" or "model"
        private String text;

        public ChatMessage(String role, String text) {
            this.role = role;
            this.text = text;
        }

        public String getRole() {
            return role;
        }

        public String getText() {
            return text;
        }
    }

    /**
     * Gets API response from Gemini using connection history and instructions.
     */
    public static String getGeminiResponse(List<ChatMessage> history, String systemInstruction) throws IOException {
        String apiKey = System.getenv("GEMINI_API_KEY");
        if (apiKey == null || apiKey.trim().isEmpty()) {
            apiKey = System.getProperty("GEMINI_API_KEY");
        }
        if (apiKey == null || apiKey.trim().isEmpty()) {
            apiKey = "AIzaSyA_k_Co_3cmgPeeggNIgILsqYgZ99-B6js";
        }


        String requestJson = buildRequestJson(history, systemInstruction);
        URL url = new URL(API_URL + apiKey);
        
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setRequestProperty("Accept", "application/json");
        conn.setDoOutput(true);
        conn.setConnectTimeout(10000); // 10s
        conn.setReadTimeout(20000);    // 20s

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestJson.getBytes("UTF-8");
            os.write(input, 0, input.length);
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
                return parseTextFromJson(response.toString());
            }
        } else {
            // Read error stream for debugging if needed
            StringBuilder errorResponse = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    errorResponse.append(line);
                }
            }
            throw new IOException("Gemini API call failed with response code: " + responseCode + ", error: " + errorResponse.toString());
        }
    }

    /**
     * Builds request JSON string manually to avoid external libraries dependencies.
     */
    private static String buildRequestJson(List<ChatMessage> history, String systemInstruction) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        
        // 1. Contents (history)
        json.append("\"contents\":[");
        for (int i = 0; i < history.size(); i++) {
            ChatMessage msg = history.get(i);
            json.append("{");
            json.append("\"role\":\"").append(msg.getRole()).append("\",");
            json.append("\"parts\":[{\"text\":\"").append(escapeJson(msg.getText())).append("\"}]");
            json.append("}");
            if (i < history.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        // 2. System Instruction
        if (systemInstruction != null && !systemInstruction.trim().isEmpty()) {
            json.append(",\"systemInstruction\":{");
            json.append("\"parts\":[{\"text\":\"").append(escapeJson(systemInstruction)).append("\"}]");
            json.append("}");
        }

        // 3. Generation Config
        json.append(",\"generationConfig\":{");
        json.append("\"temperature\":0.7,");
        json.append("\"maxOutputTokens\":800");
        json.append("}");

        json.append("}");
        return json.toString();
    }

    /**
     * Helper to escape special JSON characters.
     */
    private static String escapeJson(String value) {
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

    /**
     * A robust manual parser to extract the "text" field content from Gemini's JSON response.
     */
    private static String parseTextFromJson(String json) {
        String searchKey = "\"text\": \"";
        int startIndex = json.indexOf(searchKey);
        if (startIndex == -1) {
            searchKey = "\"text\":\"";
            startIndex = json.indexOf(searchKey);
        }
        if (startIndex == -1) {
            return null;
        }
        startIndex += searchKey.length();

        StringBuilder sb = new StringBuilder();
        boolean escaped = false;
        for (int i = startIndex; i < json.length(); i++) {
            char c = json.charAt(i);
            if (escaped) {
                switch (c) {
                    case 'n': sb.append('\n'); break;
                    case 't': sb.append('\t'); break;
                    case 'r': sb.append('\r'); break;
                    case 'b': sb.append('\b'); break;
                    case 'f': sb.append('\f'); break;
                    case '"': sb.append('"'); break;
                    case '\\': sb.append('\\'); break;
                    default: sb.append('\\').append(c); break;
                }
                escaped = false;
            } else if (c == '\\') {
                escaped = true;
            } else if (c == '"') {
                // End of text value
                break;
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
