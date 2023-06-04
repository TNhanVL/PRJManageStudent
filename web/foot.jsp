<%-- 
    Document   : foot
    Created on : Jun 1, 2023, 1:34:45 PM
    Author     : TTNhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="toast"></div>

<script>
    <%
        String message = (String) request.getSession().getAttribute("success");
        if(message != null && message != ""){
            out.println("showSuccesToast('" + message + "');");
            request.getSession().removeAttribute("success");
        }
        message = (String) request.getSession().getAttribute("error");
        if(message != null && message != ""){
            out.println("showErrorToast('" + message + "');");
            request.getSession().removeAttribute("error");
        }
    %>
</script>

<!-- jQuery -->
<script src="./public/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="./public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jquery-validation -->
<script src="./public/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="./public/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- AdminLTE App -->
<script src="./public/dist/js/adminlte.min.js"></script>
</body>
</html>
