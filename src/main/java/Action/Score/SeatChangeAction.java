package Action.Score;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class SeatChangeAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ScoreDAO dao = new ScoreDAO();
        
        request.setAttribute("classNumList", dao.getClassNumList());
        request.setAttribute("subjects", dao.getSubjectList());

        String classNum = request.getParameter("classNum");
        String subjectCd = request.getParameter("subjectCd");

        if (classNum != null && !classNum.isEmpty() && subjectCd != null && !subjectCd.isEmpty()) {
            List<Map<String, Object>> sortedStudents = dao.getStudentsForSeatChange(classNum, subjectCd);
            int totalStudents = sortedStudents.size();

            // JSPに渡す多次元リスト（可変列用）
            List<List<List<Map<String, Object>>>> classroomColumns = new ArrayList<>();

            if (totalStudents > 0) {
                // 💡【総班数の計算】4人未満（3人以下）の班を作らない、正確な班数を逆算
                int targetTeamsCount = (totalStudents + 3) / 4;
                int remainder = totalStudents % 4;
                
                int fivePersonTeamCount = 0;
                if (remainder > 0) {
                    fivePersonTeamCount = remainder; 
                }
                if (targetTeamsCount == 0) targetTeamsCount = 1;

                // 💡【縦3〜4段に抑えるための列数計算】
                // 1列につき「最大3段まで」を基本ルールとし、はみ出た分を右の列へ流します。
                // 64人（16班）の場合、16 / 3 = 5.33 → 切り上げて「6列」になります（各列に3つずつ、最後の列に1つ）。
                int columnCount = (int) Math.ceil((double) targetTeamsCount / 3.0);
                if (columnCount < 3) columnCount = 3; 

                // 空の班の器を用意
                List<List<Map<String, Object>>> allTeams = new ArrayList<>();
                for (int i = 0; i < targetTeamsCount; i++) {
                    allTeams.add(new ArrayList<>());
                }

                // 各班の定員設計図（4人か5人か）を作成
                int[] teamMaxSizes = new int[targetTeamsCount];
                for (int i = 0; i < targetTeamsCount; i++) {
                    if (i >= targetTeamsCount - fivePersonTeamCount) {
                        teamMaxSizes[i] = 5;
                    } else {
                        teamMaxSizes[i] = 4;
                    }
                }

                // 生徒を定員通りに、成績順スネークソートで1人ずつ流し込み（データ消失防止・4人未満防止）
                int teamIndex = 0;
                boolean forward = true;

                for (Map<String, Object> student : sortedStudents) {
                    int originalIdx = teamIndex;
                    while (allTeams.get(teamIndex).size() >= teamMaxSizes[teamIndex]) {
                        if (forward) {
                            if (teamIndex < targetTeamsCount - 1) teamIndex++;
                            else { forward = false; teamIndex--; }
                        } else {
                            if (teamIndex > 0) teamIndex--;
                            else { forward = true; teamIndex++; }
                        }
                        if (teamIndex == originalIdx) break;
                    }

                    allTeams.get(teamIndex).add(student);

                    if (forward) {
                        if (teamIndex < targetTeamsCount - 1) { teamIndex++; } 
                        else { forward = false; }
                    } else {
                        if (teamIndex > 0) { teamIndex--; } 
                        else { forward = true; }
                    }
                }

                // 各班内を点数降順でソート（5人目は一番後ろ）
                for (List<Map<String, Object>> team : allTeams) {
                    team.sort((s1, s2) -> {
                        double p1 = s1.get("avg_point") != null ? ((Number) s1.get("avg_point")).doubleValue() : 0;
                        double p2 = s2.get("avg_point") != null ? ((Number) s2.get("avg_point")).doubleValue() : 0;
                        return Double.compare(p2, p1);
                    });
                }

                // 💡【列への詰め込み処理】縦を「最大3段まで」のルールに固定して、右側へ列を増やしていきます。
                for (int c = 0; c < columnCount; c++) {
                    classroomColumns.add(new ArrayList<>()); 
                }

                for (int i = 0; i < allTeams.size(); i++) {
                    int targetColumn = i / 3; // 3個配置したら次の列へ自動スライド
                    if (targetColumn >= columnCount) {
                        targetColumn = columnCount - 1; 
                    }
                    classroomColumns.get(targetColumn).add(allTeams.get(i));
                }
            }

            request.setAttribute("classroomColumns", classroomColumns);
            request.setAttribute("selectedClass", classNum);
            request.setAttribute("selectedSubject", subjectCd);
        }

        request.getRequestDispatcher("/result/seat_change.jsp").forward(request, response);
    }
}
