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

    //0 - ok
    //1 - not exist
    //2 - incorrect pw
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

//    public static void insertUser(User user) {
//        try {
//            connect();
//            statement = conn.prepareStatement("insert into user(user_name, password, full_name) values(?, ?, ?)");
//            statement.setString(1, user.getUser_name());
//            statement.setString(2, user.getPassword());
//            statement.setString(3, user.getFull_name());
//            statement.execute();
//            disconnect();
//        } catch (SQLException | ClassNotFoundException ex) {
//            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    public static void updateUser(User user) {
//        try {
//            connect();
//            statement = conn.prepareStatement("update user set user_name=?, password=?, full_name=? where id=?");
//            statement.setString(1, user.getUser_name());
//            statement.setString(2, user.getPassword());
//            statement.setString(3, user.getFull_name());
//            statement.setString(4, String.valueOf(user.getID()));
//            statement.executeUpdate();
//            disconnect();
//        } catch (SQLException | ClassNotFoundException ex) {
//            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    public static void deleteUser(int ID) {
//        try {
//            connect();
//            statement = conn.prepareStatement("delete from user where id=?");
//            statement.setString(1, String.valueOf(ID));
//            statement.execute();
//            disconnect();
//        } catch (SQLException | ClassNotFoundException ex) {
//            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
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

//        System.out.println(checkUserExist("Nhan"));
    }
}
