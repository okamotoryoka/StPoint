package Action;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

@WebServlet("*.action")
public class FrontController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        Action action = null;

        if (path.equals("/AdminLogin.action")) {
            action = new AdminLoginAction();
        } 

        if (action == null) {
            response.sendError(404);
            return;
        }

 
        try {
            String url = action.execute(request, response);
            request.getRequestDispatcher(url).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        } // ← try-catch の閉じカッコ
    } // ← doPost メソッドの閉じカッコ
} 
