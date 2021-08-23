package servlet;

import bean.Book;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class DownloadHandlerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        ServletContext application = getServletContext();

        SessionFactory factory = (SessionFactory) application.getAttribute("factory");
        Session hibernateSession = factory.openSession();
        Transaction hibernateTransaction = hibernateSession.beginTransaction();

        Book book = (Book) hibernateSession.get(bean.Book.class, id);

        File file = new File("C:\\Users\\Jay Rathod\\Documents\\NetBeansProjects\\Ebook Library\\web\\ebooks\\" + id + ".pdf");

        response.setContentType("application/pdf");
        response.addHeader("Content-Disposition", "attachment; filename=" + book.getTitle() + ".pdf");
        response.setContentLength((int) file.length());

        ServletOutputStream servletOutputStream = response.getOutputStream();
        BufferedInputStream bufferdInputStream = new BufferedInputStream(new FileInputStream(file));

        byte buffer[] = new byte[1024];
        int length = bufferdInputStream.read(buffer);
        while (length > 0) {
            servletOutputStream.write(buffer, 0, length);
            length = bufferdInputStream.read(buffer);
        }

        servletOutputStream.close();
        bufferdInputStream.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
