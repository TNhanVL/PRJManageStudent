<%-- Document : studentList Created on : Jun 1, 2023, 2:48:19 PM Author : TTNhan --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@page import="java.util.ArrayList" %>
<%@page import="Model.Student" %>

<%-- check login --%>
<% boolean loged=false; String username="" ; try{ for(Cookie cookie: request.getCookies()){
    if(cookie.getName().equals("username")){ username=cookie.getValue(); break; } } }catch(Exception
    e){ response.sendRedirect("index.jsp"); return; } if(username=="" ){
    response.sendRedirect("index.jsp"); return; }%>

<jsp:include page="head.jsp">
    <jsp:param name="title" value="Student List" />
</jsp:include>


<div class="container-fluid">

    <div class="studentListTitle">
        <h1>Student List</h1>
        <button id="cancelButton" class="btn btn-danger btn-block"><i class="fa-solid fa-right-from-bracket" style="color: #ffffff;"></i> Logout</button>
    </div>

    <div class="row">
        <!-- left column -->
        <div class="col-md-12">
            <!-- jquery validation -->
            <div class="card card-primary student-list">
                <div class="card-header">
                    <h3 class="card-title">Student List</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->

                <div class="card-body">
                    <table id="usersTable">
                        <tr>
                            <th>StudentID</th>
                            <th>StudentName</th>
                            <th>Birthday</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Modify</th>
                        </tr>
                        <% ArrayList<Student> dataList = new ArrayList<>();
                                dataList = Database.DB.getStudents();
                                for (int i = 0; i < dataList.size(); i++) { %>
                        <tr>
                            <td>
                                <%out.println(dataList.get(i).getID());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getName());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getBirthday());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getGender());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getEmail());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getPhone());%>
                            </td>
                            <td>
                                <%out.println(dataList.get(i).getAddress());%>
                            </td>
                            <td>
                                <a
                                    href="/user/edit?id=<%out.println(dataList.get(i).getID());%>">
                                    <i class="fas fa-solid fa-pen"></i>
                                </a>
                                <a
                                    href="/user/delete?id=<%out.println(dataList.get(i).getID());%>">
                                    <i class="far fa-trash-alt"
                                       style="color: #e60a0a;"></i>
                                </a>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </div>


            </div>
            <!-- /.card -->
        </div>
        <!--/.col (left) -->
        <!--/.col (right) -->
    </div>
    <!-- /.row -->
</div><!-- /.container-fluid -->


<jsp:include page="foot.jsp" />