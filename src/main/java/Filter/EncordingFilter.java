package Filter; // プロジェクトのフォルダ構成に合わせて変更してください

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;

/**
 * すべてのリクエストに対して文字エンコーディングを設定するフィルター
 */
@WebFilter("/*") // すべてのアクセス（/*）に対して実行されるようにします
public class EncordingFilter implements Filter {

    // クラス図にあるメソッド：init
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初期化処理（特に必要なければ空でOK）
    }

    // クラス図にあるメソッド：doFilter（メインの処理）
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // 1. リクエストの文字コードを UTF-8 に設定（文字化け防止）
        request.setCharacterEncoding("UTF-8");
        
        // 2. レスポンス（画面表示）の文字コードも設定
        response.setContentType("text/html; charset=UTF-8");

        // 3. 次の処理（FrontControllerなど）へバトンタッチする
        chain.doFilter(request, response);
    }

    // クラス図にあるメソッド：destroy
    @Override
    public void destroy() {
        // 終了処理（特に必要なければ空でOK）
    }
}
