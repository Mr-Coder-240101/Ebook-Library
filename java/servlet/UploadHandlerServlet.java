package servlet;

import bean.Book;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class UploadHandlerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession httpSession = request.getSession();

            String title = (String) httpSession.getAttribute("title");
            String author = (String) httpSession.getAttribute("author");
            int pages = (Integer) (httpSession.getAttribute("pages"));

            String id = UUID.randomUUID().toString();
            String path = "C:\\Users\\Jay Rathod\\Documents\\NetBeansProjects\\Ebook Library\\web\\ebooks\\" + id + ".pdf";

            ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);

            FileItem fileItem = fileItems.get(0);

            File file = new File(path);
            fileItem.write(file);

            Book book = new Book();

            book.setId(id);
            book.setAuthor(author);
            book.setTitle(title);
            book.setPages(pages);

            ServletContext application = getServletContext();
            SessionFactory factory = (SessionFactory) application.getAttribute("factory");

            Session hibernateSession = factory.openSession();
            Transaction hibernateTransaction = hibernateSession.beginTransaction();

            hibernateSession.save(book);

            hibernateTransaction.commit();
            hibernateSession.close();

            System.out.println(book);
            System.out.println("Book Saved Succesfully");

            httpSession.setAttribute("bookSaved", "saved");

            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}
