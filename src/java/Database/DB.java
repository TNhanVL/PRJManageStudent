/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Database;

import Model.Student;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TTNhan
 */
public class DB {

    static Connection conn;
    static PreparedStatement statement;

    private static void connect() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(Config.DB_URL, Config.USERNAME, Config.PASSWORD);
    }

    private static void disconnect() throws SQLException {
        conn.close();
    }

    /**
     *
     * @param username
     * @param password
     * @return 0 - ok; 1 - not exist; 2 - incorrect pw
     */
    public static int checkAdmin(String username, String password) {
        int status = 1;
        try {
            connect();
            statement = conn.prepareStatement("select Password from admins where Username = ?");
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
                status = 1;
            } else {
                String pw = resultSet.getString("Password");
                if (pw.equals(password)) {
                    status = 0;
                } else {
                    status = 2;
                }
            }

            disconnect();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public static Student getStudent(String ID) {
        Student student = new Student();

        try {
            connect();
            statement = conn.prepareStatement("select * from students where StudentID = ?");
            statement.setString(1, ID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                student = new Student(
                        resultSet.getString("StudentID"),
                        resultSet.getString("StudentName"),
                        resultSet.getDate("Birthday"),
                        resultSet.getString("Gender"),
                        resultSet.getString("Email"),
                        resultSet.getString("Phone"),
                        resultSet.getString("Address")
                );
            }
            disconnect();

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return student;
    }

    public static ArrayList<Student> getStudents() {
        ArrayList<Student> dataList = new ArrayList<>();

        try {
            connect();
            statement = conn.prepareStatement("select * from students");
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Student user = new Student(
                        resultSet.getString("StudentID"),
                        resultSet.getString("StudentName"),
                        resultSet.getDate("Birthday"),
                        resultSet.getString("Gender"),
                        resultSet.getString("Email"),
                        resultSet.getString("Phone"),
                        resultSet.getString("Address")
                );
                dataList.add(user);
            }
            disconnect();

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return dataList;
    }

    public static boolean checkStudent(String ID) {
        boolean exist = false;
        try {
            connect();
            statement = conn.prepareStatement("select StudentID from students where StudentID = ?");
            statement.setString(1, ID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                exist = true;
            }

            disconnect();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exist;
    }

//    public static void insertStudent(Student user) {
//        try {
//            connect();
//            statement = conn.prepareStatement("insert into user(user_name, password, full_name) values(?, ?, ?)");
//            statement.setString(1, user.getStudent_name());
//            statement.setString(2, user.getPassword());
//            statement.setString(3, user.getFull_name());
//            statement.execute();
//            disconnect();
//        } catch (SQLException | ClassNotFoundException ex) {
//            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
    public static boolean updateStudent(Student student) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            connect();
            statement = conn.prepareStatement("update students set StudentName=?, Birthday=?, Gender=?, Email=?, Phone=?, Address=? where StudentID=?");
            statement.setString(7, student.getID());
            statement.setString(1, student.getName());
            statement.setString(2, dateFormat.format(student.getBirthday()));
            statement.setString(3, student.getGender());
            statement.setString(4, student.getEmail());
            statement.setString(5, student.getPhone());
            statement.setString(6, student.getAddress());
            statement.executeUpdate();
            disconnect();
            return true;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean deleteStudent(String ID) {
        try {
            if (!checkStudent(ID)) {
                return false;
            }
            connect();
            statement = conn.prepareStatement("delete from students where StudentID=?");
            statement.setString(1, ID);
            statement.execute();
            disconnect();
            if (!checkStudent(ID)) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) {
//        try {
//            connect();
//            statement = conn.prepareStatement("select user_name from user where user_name = 'ttNhan'");
//            ResultSet resultSet = statement.executeQuery();
//            boolean found = resultSet.next();
//            disconnect();
//            System.out.println(found);
//        } catch (SQLException | ClassNotFoundException ex) {
//            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
//        }

//        System.out.println(checkStudentExist("Nhan"));
    }
}
