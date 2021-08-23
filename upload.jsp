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
        <title>E-book Library</title>
    </head>
    <body>
        <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark" >
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp"><i class="fas fa-book-open fa-2x"></i> <h4 style="display: inline-block;">Ebook Library</h4></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="index.jsp"><h6 style="margin: 10px;">Home</h6></a></li>
                        <li class="nav-item"><a class="nav-link active" href="upload.jsp"><h6 style="margin: 10px;">Upload</h6></a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div style="min-height: 86vh;">

            <%
                if (request.getParameter("next") == null) {
            %>

            <div class="container-sm constainer-md position-absolute top-50 start-50 translate-middle text-center">
                <h1 class="text-center">Book Details</h1>
                <form method="post">
                    <div class="row mt-3 mb-3 mx-auto w-50">
                        <input id="title" class="form-control" type="text" name="title" placeholder="Book Name" autocomplete="off" required>
                    </div>
                    <div class="row mb-3 mx-auto w-50">
                        <input id="author" class="form-control" type="text" name="author" placeholder="Author Name" autocomplete="off" required>
                    </div>
                    <div class="row mb-3 mx-auto w-50">
                        <input id="pages" class="form-control" type="number" name="pages" placeholder="Number of Pages" required>
                    </div>
                    <div class="row mb-3 mx-auto w-50">
                        <input id="next" class="form-control" type="submit" name="next" value="Next">
                    </div>
                </form>
            </div>
            <%
                }
            %>

            <%
                if (request.getParameter("next") != null) {
                    session.setAttribute("title", request.getParameter("title"));
                    session.setAttribute("author", request.getParameter("author"));
                    session.setAttribute("pages", Integer.parseInt(request.getParameter("pages")));
            %>

            <div class="container-sm constainer-md position-absolute top-50 start-50 translate-middle text-center">

                <h1 class="text-center">Upload File</h1>
                <form action="upload" method="post" enctype="multipart/form-data">
                    <div class="row mb-3 mx-auto w-50">
                        <input id="book" class="form-control" type="file" name="book" accept=".pdf" required>
                    </div>
                    <div class="row mb-3 mx-auto w-50">
                        <input id="submit" class="form-control" type="submit" name="submit" value="Upload">
                    </div>
                </form>
            </div>

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