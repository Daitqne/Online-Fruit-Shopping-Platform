package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;
import dal.DeliveryDAO;
import dal.NotificationDAO;
import model.Authen;
import model.Delivery;
import model.Notification;

@WebServlet(name="DeliveryController", urlPatterns={"/delivery"})
public class DeliveryController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeliveryController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeliveryController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"Delivery".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ban khong co quyen truy cap.");
            return;
        }
        
        DeliveryDAO dld = new DeliveryDAO();
        NotificationDAO ntd = new NotificationDAO();

        List<Delivery> unassigned = dld.getUnassignedDeliveries();
        List<Delivery> staffDeliveries = dld.getDeliveriesByStaff(user.getId());
        List<Notification> notifs = ntd.getNotificationsByUserId(user.getId());
        long unread = notifs.stream().filter(n -> !n.isRead()).count();

        request.setAttribute("unassigned", unassigned);
        request.setAttribute("myDeliveries", staffDeliveries);
        request.setAttribute("notifications", notifs);
        request.setAttribute("unreadCount", unread);

        request.getRequestDispatcher("/delivery.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Authen user = (Authen) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"Delivery".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Ban khong co quyen truy cap.");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("deliveryId");
        DeliveryDAO dld = new DeliveryDAO();

        if (action != null && idStr != null && !idStr.trim().isEmpty()) {
            try {
                int deliveryId = Integer.parseInt(idStr.trim());
                switch (action) {
                    case "claim":
                        dld.claimDelivery(deliveryId, user.getId());
                        break;
                    case "confirm":
                        dld.confirmDelivery(deliveryId, user.getId());
                        break;
                }
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        response.sendRedirect(request.getContextPath() + "/delivery");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
