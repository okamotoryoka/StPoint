package Action.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import Bean.School;
import Bean.Subject;
import Bean.Teacher;
import DAO.Subject.SubjectDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SubjectListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        
        try {
            // 1. セッションからユーザーデータと学校データを取得（設計図通り）
            Teacher teacher = Util.getUser(request);
            School school = teacher.getSchool();
            
            // 2. 以前成功したSubjectDAOを使い、プルダウン用の「科目一覧」を取得してセット
            SubjectDAO subjectDao = new SubjectDAO();
            List<Subject> subjectList = subjectDao.filter(school);
            request.setAttribute("subjectList", subjectList);
            
            // 3. 【追加】データベース（stpoint）から、その学校に存在する「入学年度」を重複なしで取得
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:/comp/env/jdbc/stpoint");
            
            List<Integer> yearList = new ArrayList<>();
            String yearSql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?)) ORDER BY ENT_YEAR DESC";
            
            // 4. 【追加】データベースから、その学校に存在する「クラス番号」を重複なしで取得
            List<String> classList = new ArrayList<>();
            String classSql = "SELECT DISTINCT CLASS_NUM FROM STUDENT WHERE UPPER(TRIM(SCHOOL_CD)) = UPPER(TRIM(?)) ORDER BY CLASS_NUM ASC";
            
            try (Connection con = ds.getConnection()) {
                // 入学年度の取得
                try (PreparedStatement st = con.prepareStatement(yearSql)) {
                    st.setString(1, school.getCd());
                    try (ResultSet rs = st.executeQuery()) {
                        while (rs.next()) {
                            yearList.add(rs.getInt("ENT_YEAR"));
                        }
                    }
                }
                // クラス番号の取得
                try (PreparedStatement st = con.prepareStatement(classSql)) {
                    st.setString(1, school.getCd());
                    try (ResultSet rs = st.executeQuery()) {
                        while (rs.next()) {
                            classList.add(rs.getString("CLASS_NUM").trim());
                        }
                    }
                }
            }
            
            // 5. JSP画面（subject_list.jsp）の各プルダウンが受け取る名前に合わせてデータをセット
            request.setAttribute("yearList", yearList);   // 入学年度用
            request.setAttribute("classList", classList); // クラス用
            
            // 6. 「回数」はデータベースではなく、通常1〜2回（または1〜5回）の固定なのでリストを作ってセットします
            List<Integer> countList = new ArrayList<>();
            countList.add(1);
            countList.add(2);
            request.setAttribute("countList", countList); // 回数用
            
            // 7. 画面へフォワード
            request.getRequestDispatcher("/subject/subject_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            throw new jakarta.servlet.ServletException(e);
        }
    }
}
