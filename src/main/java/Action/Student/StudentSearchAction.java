package Action.Student;

import java.util.List;

import Bean.Student;
import DAO.Student.StudentDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class StudentSearchAction extends Action {

	// 戻り値の型を String から void に変更します
	@Override
	public void execute(
	        HttpServletRequest request,
	        HttpServletResponse response
	) throws Exception {

	    String name = request.getParameter("name");
	    String classNum = request.getParameter("classNum");
	    String gradeStr = request.getParameter("grade"); // 追加: 学年のパラメータ取得
	    String sort = request.getParameter("sort");

	    if (name == null) {
	        name = "";
	    }

	    if (classNum == null) {
	        classNum = "";
	    }

	    // 追加: 画面から送られてきた学年を数値に変換（未指定や空文字なら0にする）
	    int grade = 0;
	    if (gradeStr != null && !gradeStr.isEmpty()) {
	        grade = Integer.parseInt(gradeStr);
	    }

	    StudentDAO dao = new StudentDAO();

	    // 修正: 引数に学年（grade）を追加してDAOの検索を呼び出す
	    List<Student> list =
	            dao.search(name, classNum, grade, sort);

	    request.setAttribute("students", list);
	    
	    // 追加: 画面側で選択状態をキープしたり利用したりできるように値を引き渡す
	    request.setAttribute("selectedName", name);
	    request.setAttribute("selectedClass", classNum);
	    request.setAttribute("selectedGrade", gradeStr);
	    request.setAttribute("selectedSort", sort);
	    
	    // 追加: 検索画面のプルダウン用に学年の一覧リストも渡しておく
	    request.setAttribute("gradeList", dao.getGrades());

	    // 【修正】その場で直接JSPへフォワードし、画面を表示します
	    request.getRequestDispatcher("/student/search.jsp").forward(request, response);
	}
}
