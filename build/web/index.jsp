<%-- 
    Document   : index
    Created on : Jun 1, 2023, 1:32:33 PM
    Author     : TTNhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Database.DB" %>

<% 
    boolean loged = false;
    String username = "";
    try {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    } catch (Exception e) {
    }
    if (DB.checkAdmin(username, "") != 1) {
        response.sendRedirect("studentList.jsp");
        return;
    }
%>

<jsp:include page="head.jsp">
    <jsp:param name="title" value="Login"/>
</jsp:include>

<div class="login-box">

    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <div class="login-logo">
                <b>Students Management</b>
            </div>
            <%if(request.getSession().getAttribute("error") != null){%>
            <div class="alert alert-danger">
                <%out.print(request.getSession().getAttribute("error"));%>
            </div>
            <%
                request.getSession().setAttribute("error", null);
    }%>

            <!-- Create Post Form -->

            <form action="./Login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-group mb-3">
                        <input type="text" id="username" name="username" class="form-control" placeholder="Username" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <i class="fa-solid fa-user"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="password">Username</label>
                    <div class="input-group mb-3">
                        <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
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

<%@ include file="foot.jsp" %>

<script>
    document.getElementById("cancelButton").onclick = function () {
        var a = document.getElementsByClassName("alert");
        if (a.length)
            a[0].remove();
        document.getElementsByName("username")[0].value = "";
        document.getElementsByName("password")[0].value = "";
    };


    $(function () {
        $('#loginForm').validate({
            rules: {
                username: {
                    required: true
                },
                password: {
                    required: true,
                    minlength: 5
                }
            },
            messages: {
                username: {
                    required: "Please enter a username"
                },
                password: {
                    required: "Please provide a password",
                    minlength: "Your password must be at least 5 characters long"
                }
            },
            errorElement: 'span',
            errorPlacement: function (error, element) {
                error.addClass('invalid-feedback');
                element.closest('.form-group').append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
            }
        });
    });

</script>