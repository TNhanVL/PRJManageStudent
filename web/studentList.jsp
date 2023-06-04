<%-- Document : studentList Created on : Jun 1, 2023, 2:48:19 PM Author : TTNhan --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%@page import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="Model.Student" %>
<%@page import="Database.DB" %>

<%-- check login --%>
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
        response.sendRedirect("index.jsp");
        return;
    }
    if (DB.checkAdmin(username, "") == 1) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<jsp:include page="head.jsp">
    <jsp:param name="title" value="Student List" />
</jsp:include>


<div class="container-fluid">

    <!--<button onclick="showSuccesToast('abc')">asdf</button>-->
    
    <div class="studentListTitle">
        <h1>Student List</h1>
        <button onclick="location.href = './Logout';" class="btn btn-danger btn-block"><i class="fa-solid fa-right-from-bracket" style="color: #ffffff;"></i> Logout</button>
    </div>

    <div class="row">
        <!-- left column -->
        <div class="col-md-12 content">
            <table id="studentsTable">
                <tr class="tableHeader">
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
                        <%out.print(dataList.get(i).getID());%>
                    </td>
                    <td>
                        <%out.print(dataList.get(i).getName());%>
                    </td>
                    <td>
                        <%
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            out.print(dateFormat.format(dataList.get(i).getBirthday()));
                        %>
                    </td>
                    <td>
                        <%out.print(dataList.get(i).getGender());%>
                    </td>
                    <td>
                        <%out.print(dataList.get(i).getEmail());%>
                    </td>
                    <td>
                        <%out.print(dataList.get(i).getPhone());%>
                    </td>
                    <td>
                        <%out.print(dataList.get(i).getAddress());%>
                    </td>
                    <td>
                        <a
                            href="./Student/edit?id=<%out.print(dataList.get(i).getID());%>">
                            <i class="fas fa-solid fa-pen"></i>
                        </a>
                        <a
                            href="./Student/delete?id=<%out.print(dataList.get(i).getID());%>">
                            <i class="fa-solid fa-trash" style="color: #ff0000;"></i>
                        </a>
                    </td>
                </tr>
                <%}%> 
            </table>
            <!-- /.card -->
        </div>
        <!--/.col (left) -->
        <!--/.col (right) -->
    </div>
    <!-- /.row -->
</div><!-- /.container-fluid -->


<jsp:include page="foot.jsp" />