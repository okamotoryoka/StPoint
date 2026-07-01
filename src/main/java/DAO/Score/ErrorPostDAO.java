package DAO.Score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ErrorPostDAO {

    // 💡 ScoreDAOと完全に一致させた接続取得メソッドに修正しました
    private Connection getConnection() throws Exception {
        InitialContext context = new InitialContext();
        // ★[score_management] から [java:/comp/env/jdbc/stpoint] に修正
        DataSource ds = (DataSource) context.lookup("java:/comp/env/jdbc/stpoint");
        return ds.getConnection();
    }

    /**
     * アプリ起動時や投稿時に呼び出され、テーブルが存在しなければJavaコードから自動作成します。
     */
    public void createTableIfNotExists() throws Exception {
        String sql = "CREATE TABLE IF NOT EXISTS error_posts ("
                   + "  id INT AUTO_INCREMENT PRIMARY KEY,"
                   + "  subject_cd VARCHAR(10) NOT NULL," // 既存の科目コードを利用
                   + "  unit_name VARCHAR(100) NOT NULL," // 単元名
                   + "  error_title VARCHAR(200) NOT NULL," // エラーのタイトル
                   + "  error_detail TEXT,"                 // エラーの詳しい内容(NULLを許容)
                   + "  solution TEXT NOT NULL,"            // 解決方法
                   + "  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                   + ")";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.executeUpdate(); // SQLを実行してテーブルを自動作成
        }
    }

    /**
     * エラーの解決方法を投稿（保存）するメソッド
     */
    public boolean insertPost(String subjectCd, String unitName, String title, String detail, String solution) throws Exception {
        // 投稿する前に、念のためテーブルがあるかチェック＆自動作成
        createTableIfNotExists();

        String sql = "INSERT INTO error_posts (subject_cd, unit_name, error_title, error_detail, solution) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subjectCd);
            st.setString(2, unitName);
            st.setString(3, title);
            st.setString(4, detail);
            st.setString(5, solution);
            
            int row = st.executeUpdate();
            return row > 0;
        }
    }
    
    /**
     * 💡【新規追加】条件を指定してエラー投稿の一覧を動的に検索・取得するメソッド
     * @param subjectCd 絞り込み用の科目コード（未選択なら""またはnull）
     * @param keyword 検索キーワード（単元名、タイトル、詳細、解決策のいずれかに部分一致）
     * @return 検索結果のリスト（Mapのリスト形式）
     */
    public List<Map<String, Object>> searchPosts(String subjectCd, String keyword) throws Exception {
        List<Map<String, Object>> postList = new ArrayList<>();
        
        // 💡 既存のSUBJECT（科目マスタ）と結合して、画面に「科目名」を綺麗に出せるようにします
        StringBuilder sql = new StringBuilder(
            "SELECT ep.id, ep.subject_cd, sub.NAME AS subject_name, ep.unit_name, " +
            "       ep.error_title, ep.error_detail, ep.solution, ep.created_at " +
            "FROM error_posts ep " +
            "LEFT JOIN SUBJECT sub ON ep.subject_cd = sub.CD " +
            "WHERE 1=1"
        );

        // 動的条件（科目コードでの絞り込み）
        if (subjectCd != null && !subjectCd.trim().isEmpty()) {
            sql.append(" AND ep.subject_cd = ?");
        }
        
        // 動的条件（キーワード検索：単元名、タイトル、詳細、解決策のどれかに含まれていればヒット）
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (ep.unit_name LIKE ? OR ep.error_title LIKE ? OR ep.error_detail LIKE ? OR ep.solution LIKE ?)");
        }

        // 新着順（投稿日時が新しい順）に並べ替える
        sql.append(" ORDER BY ep.created_at DESC");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            
            // パラメータのセット（科目コード）
            if (subjectCd != null && !subjectCd.trim().isEmpty()) {
                st.setString(paramIndex++, subjectCd);
            }
            
            // パラメータのセット（キーワード：部分一致のため % で囲む）
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeStr = "%" + keyword.trim() + "%";
                st.setString(paramIndex++, likeStr);
                st.setString(paramIndex++, likeStr);
                st.setString(paramIndex++, likeStr);
                st.setString(paramIndex++, likeStr);
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("subject_cd", rs.getString("subject_cd"));
                    map.put("subject_name", rs.getString("subject_name"));
                    map.put("unit_name", rs.getString("unit_name"));
                    map.put("error_title", rs.getString("error_title"));
                    map.put("error_detail", rs.getString("error_detail"));
                    map.put("solution", rs.getString("solution"));
                    map.put("created_at", rs.getTimestamp("created_at"));
                    
                    postList.add(map);
                }
            }
        }
        return postList;
    }

}
