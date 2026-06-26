package controller.customer;

import dal.AddressDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Authen;
import model.CustomerAddress;

@WebServlet(name = "AddressServlet", urlPatterns = {"/address"})
public class AddressServlet extends HttpServlet {

    private final AddressDAO addressDAO = new AddressDAO();

    // =====================================================
    // GET: Hiển thị danh sách địa chỉ + form thêm/sửa
    // =====================================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Authen user = (Authen) session.getAttribute("user");
        String action = request.getParameter("action");

        // Nếu action=edit → load địa chỉ cần sửa vào form
        if ("edit".equals(action)) {
            try {
                int addressId = Integer.parseInt(request.getParameter("id"));
                CustomerAddress address = addressDAO.getById(addressId);
                // Kiểm tra địa chỉ thuộc về user hiện tại
                if (address != null && address.getUserId() == user.getId()) {
                    request.setAttribute("editAddress", address);
                }
            } catch (NumberFormatException e) {
                // id không hợp lệ, bỏ qua
            }
        }

        // Nếu action=delete → xóa và redirect
        if ("delete".equals(action)) {
            try {
                int addressId = Integer.parseInt(request.getParameter("id"));
                addressDAO.delete(addressId, user.getId());
            } catch (NumberFormatException e) {
                // id không hợp lệ, bỏ qua
            }
            response.sendRedirect(request.getContextPath() + "/address?success=deleted");
            return;
        }

        // Nếu action=setDefault → đặt mặc định và redirect
        if ("setDefault".equals(action)) {
            try {
                int addressId = Integer.parseInt(request.getParameter("id"));
                addressDAO.setDefault(addressId, user.getId());
            } catch (NumberFormatException e) {
                // id không hợp lệ, bỏ qua
            }
            response.sendRedirect(request.getContextPath() + "/address?success=default");
            return;
        }

        // Load danh sách địa chỉ
        List<CustomerAddress> addresses = addressDAO.getByUserId(user.getId());
        request.setAttribute("addresses", addresses);

        request.getRequestDispatcher("/customer/addresses.jsp").forward(request, response);
    }

    // =====================================================
    // POST: Thêm mới hoặc cập nhật địa chỉ
    // =====================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Authen user = (Authen) session.getAttribute("user");
        String action = request.getParameter("action");

        String label         = request.getParameter("label");
        String receiverName  = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String addressDetails = request.getParameter("addressDetails");
        boolean isDefault    = "on".equals(request.getParameter("isDefault"));

        // ====== VALIDATION ======
        StringBuilder errorMsg = new StringBuilder();
        
        // 1. Check trường rỗng
        if (label == null || label.trim().isEmpty()) {
            errorMsg.append("Nhãn địa chỉ không được bỏ trống!<br>");
        }
        if (receiverName == null || receiverName.trim().isEmpty()) {
            errorMsg.append("Tên người nhận không được bỏ trống!<br>");
        }
        if (receiverPhone == null || receiverPhone.trim().isEmpty()) {
            errorMsg.append("Số điện thoại không được bỏ trống!<br>");
        }
        if (addressDetails == null || addressDetails.trim().isEmpty()) {
            errorMsg.append("Địa chỉ chi tiết không được bỏ trống!<br>");
        }
        
        // 2. Validate định dạng số điện thoại (10-11 số, bắt đầu bằng 0)
        if (receiverPhone != null && !receiverPhone.trim().isEmpty()) {
            String phonePattern = "^0[0-9]{9,10}$";
            if (!receiverPhone.trim().matches(phonePattern)) {
                errorMsg.append("Số điện thoại không hợp lệ! (Phải là 10-11 số, bắt đầu bằng 0)<br>");
            }
        }
        
        // 3. Validate độ dài
        if (receiverName != null && receiverName.trim().length() < 2) {
            errorMsg.append("Tên người nhận phải có ít nhất 2 ký tự!<br>");
        }
        if (receiverName != null && receiverName.trim().length() > 100) {
            errorMsg.append("Tên người nhận không được quá 100 ký tự!<br>");
        }
        // Validate ký tự hợp lệ cho tên người nhận (chỉ chữ cái và khoảng trắng)
        if (receiverName != null && !receiverName.trim().isEmpty()) {
            String namePattern = "^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$";
            if (!receiverName.trim().matches(namePattern)) {
                errorMsg.append("Tên người nhận chỉ được chứa chữ cái và khoảng trắng!<br>");
            }
        }
        if (addressDetails != null && addressDetails.trim().length() < 10) {
            errorMsg.append("Địa chỉ chi tiết phải có ít nhất 10 ký tự!<br>");
        }
        if (addressDetails != null && addressDetails.trim().length() > 500) {
            errorMsg.append("Địa chỉ chi tiết không được quá 500 ký tự!<br>");
        }
        
        // 4. Nếu có lỗi → trả về form với thông báo lỗi
        if (errorMsg.length() > 0) {
            List<CustomerAddress> addresses = addressDAO.getByUserId(user.getId());
            request.setAttribute("addresses", addresses);
            request.setAttribute("error", errorMsg.toString());
            
            // Giữ lại dữ liệu đã nhập
            request.setAttribute("inputLabel", label);
            request.setAttribute("inputReceiverName", receiverName);
            request.setAttribute("inputReceiverPhone", receiverPhone);
            request.setAttribute("inputAddressDetails", addressDetails);
            request.setAttribute("inputIsDefault", isDefault);
            
            request.getRequestDispatcher("/customer/addresses.jsp").forward(request, response);
            return;
        }

        CustomerAddress address = new CustomerAddress();
        address.setUserId(user.getId());
        address.setLabel(label.trim());
        address.setReceiverName(receiverName.trim());
        address.setReceiverPhone(receiverPhone.trim());
        address.setAddressDetails(addressDetails.trim());
        address.setDefault(isDefault);

        boolean success;

        if ("edit".equals(action)) {
            try {
                int addressId = Integer.parseInt(request.getParameter("addressId"));
                address.setAddressId(addressId);
                success = addressDAO.update(address);
                response.sendRedirect(request.getContextPath() + "/address?success=" + (success ? "updated" : "error"));
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/address?success=error");
            }
        } else {
            // action=add
            success = addressDAO.insert(address);
            response.sendRedirect(request.getContextPath() + "/address?success=" + (success ? "added" : "error"));
        }
    }
}
