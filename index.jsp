<%@page import="java.util.List"%>
<%@page import="bean.Book"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
        crossorigin="anonymous"></script>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
            crossorigin="anonymous">
        <link rel="icon" href="logo/fevicon.jpg">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <script src="https://kit.fontawesome.com/9a4e1c0fcb.js" crossorigin="anonymous"></script>
        <style>
            .bg-soft-base {
                background-color: #e1f5f7;
            }
            .bg-soft-warning {
                background-color: #fff4e1;
            }
            .bg-soft-success {
                background-color: #d1f6f2;
            }
            .bg-soft-danger {
                background-color: #fedce0;
            }
            .bg-soft-info {
                background-color: #d7efff;
            }


            .search-form {
                width: 80%;
                margin: 0 auto;
                margin-top: 1rem;
            }

            .search-form input {
                height: 100%;
                background: transparent;
                border: 0;
                display: block;
                width: 100%;
                padding: 1rem;
                height: 100%;
                font-size: 1rem;
            }

            .search-form select {
                background: transparent;
                border: 0;
                padding: 1rem;
                height: 100%;
                font-size: 1rem;
            }

            .search-form select:focus {
                border: 0;
            }

            .search-form button {
                height: 100%;
                width: 100%;
                font-size: 1rem;
            }

            .search-form button svg {
                width: 24px;
                height: 24px;
            }

            .search-body {
                margin-bottom: 1.5rem;
            }

            .search-body .search-filters .filter-list {
                margin-bottom: 1.3rem;
            }

            .search-body .search-filters .filter-list .title {
                color: #3c4142;
                margin-bottom: 1rem;
            }

            .search-body .search-filters .filter-list .filter-text {
                color: #727686;
            }

            .search-body .search-result .result-header {
                margin-bottom: 2rem;
            }

            .search-body .search-result .result-header .records {
                color: #3c4142;
            }

            .search-body .search-result .result-header .result-actions {
                text-align: right;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .search-body .search-result .result-header .result-actions .result-sorting {
                display: flex;
                align-items: center;
            }

            .search-body .search-result .result-header .result-actions .result-sorting span {
                flex-shrink: 0;
                font-size: 0.8125rem;
            }

            .search-body .search-result .result-header .result-actions .result-sorting select {
                color: #68CBD7;
            }

            .search-body .search-result .result-header .result-actions .result-sorting select option {
                color: #3c4142;
            }

            @media (min-width: 768px) and (max-width: 991.98px) {
                .search-body .search-filters {
                    display: flex;
                }
                .search-body .search-filters .filter-list {
                    margin-right: 1rem;
                }
            }

            .card-margin {
                margin-bottom: 1.875rem;
            }

            @media (min-width: 992px){
                .col-lg-2 {
                    flex: 0 0 16.66667%;
                    max-width: 16.66667%;
                }
            }

            .card-margin {
                margin-bottom: 1.875rem;
            }
            .card {
                border: 0;
                box-shadow: 0px 0px 10px 0px black;
                -webkit-box-shadow: 0px 0px 10px 0px black;
                -moz-box-shadow: 0px 0px 10px 0px black;
                -ms-box-shadow: 0px 0px 10px 0px black;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #ffffff;
                background-clip: border-box;
                border: 1px solid #e6e4e9;
                border-radius: 8px;
            }
        </style>
        <title>Ebook Library</title>
    </head>
    <body>

        <%
            if (session.getAttribute("bookSaved") != null) {
                out.println("<script>alert('Book Saved Successfully')</script>");
                session.removeAttribute("bookSaved");
            }
        %>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark" >
            <div class="container-fluid">
                <a class="navbar-brand mx-2" href="index.jsp"><i class="fas fa-book-open fa-2x"></i> <h4 style="display: inline-block;">Ebook Library</h4></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" href="index.jsp"><h6 style="margin: 10px;">Home</h6></a></li>
                        <li class="nav-item"><a class="nav-link" href="upload.jsp"><h6 style="margin: 10px;">Upload</h6></a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container pt-3" style="min-height: 86vh;">
            <div class="row">
                <div class="col-lg-12 card-margin">
                    <div class="card search-form">
                        <div class="card-body p-0">
                            <form id="search-form">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="row no-gutters">
                                            <div class="col-lg-3 col-md-3 col-sm-12 pl-2">
                                                <select class="form-control" name="option">
                                                    <option value="title" selected>Title</option>
                                                    <option value="author">Author</option>
                                                </select>
                                            </div>
                                            <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                                                <input class="form-control" type="text" placeholder="Search" name="keyword" autocomplete="off">
                                            </div>
                                            <div class="col-lg-1 col-md-3 col-sm-12 p-0">
                                                <button class="btn btn-base" type="submit" name="submit" value="Search">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <%
                if (request.getParameter("submit") != null) {
                    response.sendRedirect("index.jsp?" + (String) request.getParameter("option") + "=" + (String) request.getParameter("keyword"));
                }
            %>

            <%                SessionFactory factory = (SessionFactory) application.getAttribute("factory");
                Session hibernateSession = factory.openSession();
                Transaction hibernateTransaction = hibernateSession.beginTransaction();

                String hql;
                Query query;
                if (request.getParameter("title") != null) {
                    String title = (String) request.getParameter("title");
                    hql = "from bean.Book where title like ? order by title";
                    query = hibernateSession.createQuery(hql);
                    query.setString(0, "%" + title + "%");
                } else if (request.getParameter("author") != null) {
                    String author = (String) request.getParameter("author");
                    hql = "from bean.Book where author like ? order by title";
                    query = hibernateSession.createQuery(hql);
                    query.setString(0, "%" + author + "%");
                } else {
                    hql = "from bean.Book order by title";
                    query = hibernateSession.createQuery(hql);
                }

                List<Book> books = query.list();

                hibernateTransaction.commit();

                hibernateSession.close();
            %>

            <%
                if (books.size() == 0) {
            %>
            <h1 class="text-center">No Book Found</h1>
            <%
                }
            %>
            <%
                if (books.size() != 0) {
            %>
            <h1 class="text-center">Book Details</h1>
            <table border="1" class="container-sm constainer-md   text-center table table-dark table-striped" >
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Pages</th>
                    <th>Download</th>
                </tr>

                <%
                    for (Book book : books) {
                %>
                <tr>
                    <td>
                        <%= book.getTitle()%>
                    </td>
                    <td>
                        <%= book.getAuthor()%>
                    </td>
                    <td>
                        <%= book.getPages()%>
                    </td>
                    <td>
                        <%String link = "http://localhost:8080/ebook-library/download?id=" + book.getId();%>
                        <a href=<%=link%>>Download</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>



        </div>

        <footer class="footer mt-auto py-2 bg-dark">
            <div class="container text-center">
                <span class="text-muted text-center"><h6>Ebook Library &copy; 2021</h6></span>
            </div>
        </footer>
    </body>
</html>