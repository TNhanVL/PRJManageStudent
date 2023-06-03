<%-- 
    Document   : index
    Created on : Jun 1, 2023, 1:32:33 PM
    Author     : TTNhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="head.jsp">
    <jsp:param name="title" value="Login"/>
</jsp:include>

<div class="login-box">
    <div class="login-logo">
        <b>Login form</b>
    </div>
    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">Enter your Username and Password</p>

            <%if(request.getSession().getAttribute("error") != null){%>
            <div class="alert alert-danger">
                <%out.print(request.getSession().getAttribute("error"));%>
            </div>
            <%
                request.getSession().setAttribute("error", null);
    }%>

            <!-- Create Post Form -->

            <form action="./Login" method="post">
                <div class="input-group mb-3">
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <i class="fa-solid fa-user"></i>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="row">

                    <div class="col-4">
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </div>
                    <!-- /.col -->
                    <div class="col-4">
                    </div><!-- /.col -->
                    <!-- /.col -->
                    <div class="col-4">
                        <button id="cancelButton" class="btn btn-danger btn-block">Cancel</button>
                    </div>

                </div>
            </form>
        </div>
        <!-- /.login-card-body -->
    </div>
</div>
<!-- /.login-box -->

<script>
    document.getElementById("cancelButton").onclick = function () {
        var a = document.getElementsByClassName("alert");
        if (a.length)
            a[0].remove();
        document.getElementsByName("username")[0].value = "";
        document.getElementsByName("password")[0].value = "";
    };
</script>

<%@ include file="foot.jsp" %>