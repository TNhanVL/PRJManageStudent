/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Database.DB;
import Model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author TTNhan
 */
public class StudentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StudentController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StudentController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }
        switch (action) {
            case "/delete": {
                boolean ok = false;
                String query = request.getQueryString();
                if (query.split("=")[0].equals("id")) {
                    String ID = query.split("=")[1];
                    ok = DB.deleteStudent(ID);
                }
                if (ok) {
                    request.getSession().setAttribute("success", "Delete Student succeed!");
                } else {
                    request.getSession().setAttribute("error", "Delete Student failed!");
                }
                response.sendRedirect("../studentList.jsp");
                break;
            }
            case "/edit": {
                try {
                    String query = request.getQueryString();
                    String ID = "";
                    if (query.split("=")[0].equals("id")) {
                        ID = query.split("=")[1];
                    }
                    if (ID == null) {
                        ID = "";
                    }

                    request.setAttribute("id", ID);
//                        request.getRequestDispatcher("../updateStudentInfo.jsp").forward(request, response);
                    response.sendRedirect("../updateStudentInfo.jsp?id=" + ID);
                } catch (Exception e) {
                    response.sendRedirect("../studentList.jsp");
                }
                break;
            }
            default: {
                response.sendRedirect("../index.jsp");
                break;
            }
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }
        switch (action) {
            case "/edit": {
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String ID = request.getParameter("id");
                    String Name = request.getParameter("name");
                    Date Birthday = dateFormat.parse(request.getParameter("birthday"));
                    String Gender = request.getParameter("gender");
                    String Email = request.getParameter("email");
                    String Phone = request.getParameter("phone");
                    String Address = request.getParameter("address");

                    Student student = new Student(ID, Name, Birthday, Gender, Email, Phone, Address);

                    boolean ok = DB.updateStudent(student);

                    if (ok) {
                        request.getSession().setAttribute("success", "Update Student information succeed!");
                    }

                    response.sendRedirect("../studentList.jsp");
                } catch (ParseException e) {
                    System.out.println(e);
                    response.sendRedirect("../studentList.jsp");
                }
                break;
            }
            default: {
                response.sendRedirect("../index.jsp");
                break;
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
