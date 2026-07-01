package Action.Student;

import java.util.List;

import Bean.Student;
import DAO.Student.ClassNumDAO;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentUpdateAction extends Action {

    // 戻り値の型を String から void に変更します
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        
        // 1. 画面から学生番号を取得
        String no = req.getParameter("no");

        // 2. 学生の専門配達員を使ってデータ取得
        StudentDAO studentDAO = new StudentDAO(); 
        Student student = studentDAO.get(no);

        // 3. クラスの専門配達員を呼ぶ
        ClassNumDAO classNumDAO = new ClassNumDAO();
        
        // 4. 引数は空文字のまま呼び出し、上で直した「全件取得のDAO」を動かします
        List<String> classList = classNumDAO.filter(""); 

        // 5. 取得したクラス一覧と学生データ、および学年リストをお皿（request）にセット
        req.setAttribute("class_list", classList);
        req.setAttribute("student", student);
        req.setAttribute("grades", studentDAO.getGrades()); // 追加: 画面のプルダウン用に学年リストをセット

        // 【修正】その場で直接JSPへフォワードし、画面を表示します
        req.getRequestDispatcher("/result/student_update.jsp").forward(req, res); 
    }
}
