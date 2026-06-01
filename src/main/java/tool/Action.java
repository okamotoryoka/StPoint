package tool;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public abstract class Action {
    // 設計図通り、戻り値を void に変更します
    public abstract void execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
