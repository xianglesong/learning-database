package com.xianglesong.database;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * CREATE TABLE `course`.`course` ( `id` CHAR(32) NOT NULL , `course_no` VARCHAR(45) NOT NULL ,
 * `course_name` VARCHAR(45) NOT NULL COMMENT 'course information' , PRIMARY KEY (`id`) ) ENGINE =
 * InnoDB DEFAULT CHARACTER SET = utf8;
 * 
 * @author rollin
 *
 */
public class JdbcUtil {

  public static Connection getConnection(String driver, String url, String user, String password)
      throws SQLException, ClassNotFoundException {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, password);
    return conn;
  }

  public static void close(ResultSet rs, Statement st, Connection conn) {
    if (rs != null) {
      try {
        rs.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    if (st != null) {
      try {
        st.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    if (conn != null) {
      try {
        conn.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }

  public static String encrypt(String a) {
    // String a = "测试a";
    char[] c = a.toCharArray();

    return "";
  }

  public static void main(String[] args) throws Exception {
    String user = "newuser";
    String password = "pwd123";
    String url = "jdbc:mysql://localhost:3306/course?useUnicode=true&characterEncoding=utf8";
    String driver = "com.mysql.jdbc.Driver";
    Connection conn = null;
    Class.forName(driver);
    conn = DriverManager.getConnection(url, user, password);
    // insert(conn);
    queryDb(conn);
    // insertClob(conn);
    // queryClob(conn);
    // String c2 = encrypt("你");
    // System.out.println(c2);
    // System.out.println(encrypt(c2));
  }

  private static void queryDb(Connection conn) throws SQLException {
    ResultSet rs = null;
    Statement st = null;
    try {
      st = conn.createStatement();
      String sql = "select id, course_no,course_name from course ";
      rs = st.executeQuery(sql);
      while (rs.next()) {
        System.out.println(rs.getInt("id"));
        System.out.println(rs.getString("course_no"));
        System.out.println(rs.getString("course_name"));
        // System.out.println(encrypt(rs.getString("content")));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (rs != null) {
        rs.close();
      }
      if (st != null) {
        st.close();
      }
      if (conn != null) {
        conn.close();
      }
    }
  }

  private static void insert(Connection conn) throws SQLException {
    Statement st = null;
    try {
      st = conn.createStatement();
      String c1 = "测试说明的内容，欢迎你的光临。";
      String c2 = "test，欢迎你的光临。";
      String c3 = "我们的，大家的家园。";
      // String c1 = encrypt("测试说明的内容，欢迎你的光临。");
      // String c2 = encrypt("test，欢迎你的光临。");
      // String c3 = encrypt("我们的，大家的家园。");
      // System.out.println(c1);
      st.addBatch("insert into course(id,course_no,course_name) values(11,'测试','" + c1 + "')");
      st.addBatch("insert into course(id,course_no,course_name)  values(22,'test','" + c2 + "')");
      st.addBatch("insert into course(id,course_no,course_name)  values(33,'我们的','" + c3 + "')");
      // String sql =
      // "insert into Search_Keywords values(?,?,?,?,?,?,?,?,?,?,?,?)";;
      // st = conn.prepareStatement(sql);
      int[] r = st.executeBatch();

      System.out.println(r.length);
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      if (st != null) {
        st.close();
      }
      if (conn != null) {
        conn.close();
      }
    }
  }

  public static void insertClob(Connection conn) {
    PreparedStatement ps = null;
    try {
      String sql = "insert into testdb.user (name, pswd, remark) values (?, ?, ?)";
      ps = conn.prepareStatement(sql);
      ps.setString(1, "zhangsan");
      ps.setString(2, "111");
      // 设置二进制参数
      File file = new File("E:\\javaworkspace\\tools\\jd.htm");
      // InputStreamReader reader = new InputStreamReader(new
      // FileInputStream("D:\\new\\dbtools\\src\\res\\TEXT.txt"),"GB18030");
      InputStreamReader reader =
          new InputStreamReader(new FileInputStream("E:\\javaworkspace\\tools\\jd.htm"));
      ps.setCharacterStream(3, reader, (int) file.length());
      ps.executeUpdate();
      reader.close();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      close(null, null, conn);
    }
  }

  public static void queryClob(Connection conn) {
    PreparedStatement ps = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
      String sql = "select remark from user where id = 1";
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      if (rs.next()) {
        Reader reader = rs.getCharacterStream(1);
        File file = new File("E:\\javaworkspace\\tools\\jd2.htm");
        OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(file));
        char[] buff = new char[1024];
        for (int i = 0; (i = reader.read(buff)) > 0;) {
          writer.write(buff, 0, i);
        }
        writer.flush();
        writer.close();
        reader.close();
      }
      rs.close();
      stmt.close();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      close(null, null, conn);
    }
  }
}
