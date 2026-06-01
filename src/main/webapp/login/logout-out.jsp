<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@ include file="/header.html" %>

<!-- 2. 画面全体を「左メニュー」と「右コンテンツ」に2分割する外枠 -->
<div class="main-layout" style="display: flex; min-height: 80vh; width: 100%;">

    <!-- 3. footer.jspを専用の固定幅ブロックで囲んで左側に配置します（得点一覧と全く同じバランスに統一） -->
    <div class="left-menu-area" style="width: 220px; min-width: 220px; max-width: 220px; box-sizing: border-box;">
        <jsp:include page="/footer.jsp" />
    </div>

    <!-- 4. 右側メインコンテンツエリア（メッセージがメニューの下に落ちるバグを防ぎます） -->
    <div class="content-body" style="flex: 1; padding: 40px; box-sizing: border-box;">
        
        <!-- 得点一覧などのデザインに合わせた、白背景の角丸ボックス -->
        <div class="right-container" style="width: 100%; max-width: 600px; background: #fff; border-radius: 20px; padding: 40px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); border: 4px solid #d8c7a1; box-sizing: border-box; text-align: center;">
            
            <h2 style="color: #6b4f2d; margin-bottom: 20px; font-size: 24px; font-weight: bold;">ログアウト完了</h2>
            <p style="font-size: 18px; color: #333; margin-bottom: 30px;">ログアウトしました。</p>

            <form action="../form.jsp">
                <!-- ログイン画面へ安全に戻るための絶対パスリンク -->
                <a href="${pageContext.request.contextPath}/login/login.jsp" style="display: inline-block; padding: 10px 20px; background-color: #6b4f2d; color: #fff; text-decoration: none; border-radius: 8px; font-size: 16px;">ログイン画面へ</a>
            </form>

        </div>

    </div>

</div>
