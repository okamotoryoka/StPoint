package Action.Score;

import DAO.Score.ScoreDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tool.Action;

public class ScoreRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            // 💡 JSPから送信された、画面上で有効な行だけの連結キー情報を取得
            String[] combinedKeys = request.getParameterValues("studentIds");

            ScoreDAO dao = new ScoreDAO();

            if (combinedKeys != null) {
                for (String key : combinedKeys) {
                    if (key == null || key.trim().isEmpty()) {
                        continue;
                    }
                    
                    // 💡 ハイフンで安全に分割 [0:学生番号, 1:科目コード, 2:回数]
                    String[] token = key.split("-");
                    if (token.length == 3) {
                        String studentId = token[0];
                        String subjectCd = token[1];
                        int no = Integer.parseInt(token[2]);

                        // 各学生の学生番号に紐づく一意な点数をJSPから取得
                        String pointStr = request.getParameter("point_" + studentId);
                        
                        if (pointStr != null && !pointStr.trim().isEmpty()) {
                            int point = Integer.parseInt(pointStr);
                            
                            // 💡 紐付きが100%正しい状態で安全にデータベースをアップデート
                            dao.save(studentId, subjectCd, no, point);
                        }
                    }
                }
            }

            // 元の検索画面（FrontControllerに定義された正しいパス）へフォワードで戻る
            request.getRequestDispatcher("/ScoreSearch.action").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}
