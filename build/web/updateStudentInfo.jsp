<%-- 
    Document   : updateStudentInfo
    Created on : Jun 4, 2023, 8:11:21 PM
    Author     : TTNhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Model.Student" %>
<%@page import="Database.DB" %>

<%-- check login --%>
<% 
    boolean loged = false;
    String username = "";
    String ID = "";
    
    try {
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    } catch (Exception e) {
        response.sendRedirect("index.jsp");
        return;
    }
    if (DB.checkAdmin(username, "") == 1) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    try {
        ID = request.getParameter("id");
        if (!DB.checkStudent(ID)) {
            throw new Exception();
        }
    } catch (Exception e) {
        response.sendRedirect("studentList.jsp");
        return;
    }
    
%>

<jsp:include page="head.jsp">
    <jsp:param name="title" value="Update Student Info" />
</jsp:include>

<div class="container-fluid">

    <div class="studentListTitle">
        <h1>Update Student Information</h1>
        <button onclick="location.href = './Logout';" class="btn btn-danger btn-block"><i class="fa-solid fa-right-from-bracket" style="color: #ffffff;"></i> Logout</button>
    </div>

    <div class="row">
        <!-- left column -->
        <div class="col-md-12 content">

            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Add A User</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->

                <%
                    Student student = DB.getStudent(ID);
                %>

                <form action="Student/edit" method="post" id="updateStudentForm">
                    <div class="card-body">

                        <div class="form-group">
                            <label for="exampleInputEmail1">StudentID</label>
                            <input type="text" class="form-control" value="<%out.print(student.getID());%>" disabled>
                        </div>
                        <div class="form-group">
                            <input type="text" name="id" value="<%out.print(student.getID());%>" style="display: none">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Student Name</label>
                            <input type="text" class="form-control" id="name"
                                   name="name" placeholder="Student Name" value="<%out.print(student.getName());%>" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Birthday</label>
                            <input type="date" class="form-control" id="birthday"
                                   name="birthday" placeholder="Birthday" value="<%
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            out.print(dateFormat.format(student.getBirthday()));
                                   %>" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Gender</label>
                            <input type="text" class="form-control" id="gender"
                                   name="gender" placeholder="Gender" value="<%out.print(student.getGender());%>" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Email</label>
                            <input type="email" class="form-control" id="email"
                                   name="email" placeholder="Email" value="<%out.print(student.getEmail());%>" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Phone</label>
                            <input type="text" class="form-control" id="phone"
                                   name="phone" placeholder="Phone" value="<%out.print(student.getPhone());%>" required>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Address</label>
                            <input type="text" class="form-control" id="address"
                                   name="address" placeholder="Address" value="<%out.print(student.getAddress());%>" required>
                        </div>
                        <div></div>
                    </div>
                    <!-- /.card-body -->

                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </form>


            </div>

        </div>
        <!--/.col (left) -->
        <!--/.col (right) -->
    </div>
    <!-- /.row -->
</div><!-- /.container-fluid -->

<jsp:include page="foot.jsp" />