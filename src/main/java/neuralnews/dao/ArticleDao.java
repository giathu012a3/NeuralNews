package neuralnews.dao;

import neuralnews.model.Article;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {

    public List<Article> getArticlesByAuthor(long authorId) {

        List<Article> list = new ArrayList<>();

        String sql = """
            SELECT a.id, a.title, a.content, a.summary, a.image_url,
                   a.author_id, a.category_id, a.status, a.views, a.likes_count,
                   a.sentiment_label, a.source_score, a.popularity_score,
                   a.published_at, a.created_at,
                   c.name AS category_name
            FROM articles a
            LEFT JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ?
            ORDER BY a.created_at DESC
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Article a = new Article();
                a.setId(rs.getLong("id"));
                a.setTitle(rs.getString("title"));
                a.setContent(rs.getString("content"));
                a.setSummary(rs.getString("summary"));
                a.setImageUrl(rs.getString("image_url"));
                a.setAuthorId(rs.getLong("author_id"));
                a.setCategoryId(rs.getInt("category_id"));
                a.setStatus(rs.getString("status"));
                a.setViews(rs.getInt("views"));
                a.setLikesCount(rs.getInt("likes_count"));
                a.setSentimentLabel(rs.getString("sentiment_label"));
                a.setSourceScore(rs.getDouble("source_score"));
                a.setPopularityScore(rs.getDouble("popularity_score"));
                a.setPublishedAt(rs.getTimestamp("published_at"));
                a.setCreatedAt(rs.getTimestamp("created_at"));
                a.setCategoryName(rs.getString("category_name"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}