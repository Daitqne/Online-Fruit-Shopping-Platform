package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;

@WebServlet(name = "SearchSuggestionServlet", urlPatterns = {"/api/search-suggestions"})
public class SearchSuggestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String query = request.getParameter("q");
        ProductDAO productDAO = new ProductDAO();
        List<Product> list = productDAO.getSearchSuggestions(query);

        // Build a JSON string manually to avoid external libraries dependencies
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            Product p = list.get(i);
            json.append("{");
            json.append("\"id\":").append(p.getId()).append(",");
            json.append("\"name\":\"").append(escapeJson(p.getName())).append("\",");
            json.append("\"price\":").append(p.getPrice()).append(",");
            json.append("\"discountPrice\":").append(p.getDiscountPrice()).append(",");
            json.append("\"image\":\"").append(escapeJson(p.getImage())).append("\",");
            json.append("\"unit\":\"").append(escapeJson(p.getUnit())).append("\"");
            json.append("}");
            if (i < list.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json.toString());
    }

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
