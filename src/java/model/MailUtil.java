package model;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class MailUtil {

    public static void sendResetPasswordMail(String toEmail, String token) {

        final String fromEmail = "vinhthhe176773@fpt.edu.vn";
        final String appPassword = "sznh jktz uber fdoq"; 

      
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.mime.charset", "UTF-8");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            MimeMessage msg = new MimeMessage(session);

            // From
            msg.setFrom(new InternetAddress(fromEmail, "GreenStock System", "UTF-8"));

            // To
            msg.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );

            
            msg.setSubject(
                    MimeUtility.encodeText(
                            "Yêu cầu đặt lại mật khẩu – GreenStock",
                            "UTF-8",
                            "B"
                    )
            );

           
            String resetLink =
                    "http://localhost:8080/SWP391-G3/reset-password?token="
                    + token;

            
            String content = """
                <div style="font-family: Arial, sans-serif; line-height: 1.6;">
                    <h2 style="color:#2c3e50;">Yêu cầu đặt lại mật khẩu</h2>

                    <p>Xin chào,</p>

                    <p>
                        Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn
                        trên hệ thống <strong>GreenStock</strong>.
                    </p>

                    <p>
                        Vui lòng nhấn vào nút bên dưới để tạo mật khẩu mới.
                        <br>
                        <strong>Lưu ý:</strong> Liên kết này chỉ có hiệu lực trong <b>15 phút</b>.
                    </p>

                    <p style="margin: 30px 0;">
                        <a href="%s"
                           style="background-color:#3498db;
                                  color:white;
                                  padding:12px 20px;
                                  text-decoration:none;
                                  border-radius:5px;">
                            Đặt lại mật khẩu
                        </a>
                    </p>

                    <p>
                        Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.
                    </p>

                    <hr>

                    <p style="font-size: 12px; color: #777;">
                        Email này được gửi tự động từ hệ thống GreenStock.
                        Vui lòng không trả lời email này.
                    </p>
                </div>
                """.formatted(resetLink);

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            System.out.println("Đã gửi mail reset mật khẩu tới: " + toEmail);

        } catch (Exception e) {
            System.out.println("Lỗi gửi mail reset mật khẩu");
            e.printStackTrace();
        }
    }
}
