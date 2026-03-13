package neuralnews.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import neuralnews.model.Category_Model;
import neuralnews.util.DBConnection;

public class Category_Dao {

    public List<Category_Model> getAllCategory() {
        List<Category_Model> list = new ArrayList<>();
        String sql = "SELECT id, name FROM categories";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category_Model c = new Category_Model();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}