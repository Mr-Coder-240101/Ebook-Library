package listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class ApplicationListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        Configuration configuration = new Configuration();
        configuration.configure();
        configuration.addAnnotatedClass(bean.Book.class);

        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder();
        builder.applySettings(configuration.getProperties());

        SessionFactory factory = configuration.buildSessionFactory(builder.build());

        ServletContext servletContext = event.getServletContext();
        servletContext.setAttribute("factory", factory);
        System.out.println("Factory Started");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        ServletContext servletContext = event.getServletContext();
        SessionFactory factory = (SessionFactory) servletContext.getAttribute("factory");
        servletContext.removeAttribute("factory");
        factory.close();

        System.out.println("Factory Closed");
    }
}
