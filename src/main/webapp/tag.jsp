<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%-- 
    【修正のポイント】
    1. 「席替え機能」の下に「エラー共有」の見出しを追加しました
    2. インデントを合わせて「エラー投稿」と「エラー検索」のリンクを配置しました
--%>
<aside class="sidebar" style="width: 200px; padding: 0 0 20px 20px; box-sizing: border-box; background-color: #ffffff; height: 100vh;">

    <style>
        /* --- サイドバー全体のベース --- */
        .sidebar {
            width: 280px;
            min-width: 280px;
            background-color: #ffffff;
            height: auto !important;
            min-height: calc(100vh - 70px) !important;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            position: relative;
            font-family: 'Helvetica Neue', Arial, 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', Meiryo, sans-serif;
            transition: width 0.25s ease, min-width 0.25s ease, padding 0.25s ease, opacity 0.25s ease;
            overflow: hidden; 
        }

        /* 折りたたまれたとき */
        .sidebar.collapsed {
            width: 0 !important;
            min-width: 0 !important;
            padding: 20px 0 !important;
            border-right: none !important;
            opacity: 0 !important;
        }

        .sidebar-menu-content {
            position: relative;
            z-index: 2;
            margin-top: 10px;
            width: 240px; 
            transition: opacity 0.15s ease;
        }

        .sidebar.collapsed .sidebar-menu-content {
            opacity: 0 !important;
        }

        .sidebar ul { 
            list-style: none; 
            padding: 0; 
            margin: 0; 
        }

        .nav-item {
            margin-bottom: 12px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            justify-content: flex-start; 
            padding: 14px 18px;
            text-decoration: none;
            color: #333333;
            border-radius: 12px;
            font-weight: bold;
            font-size: 0.95em;
            transition: all 0.2s ease;
        }

        .sidebar a:hover { 
            background-color: #f5f7fa;
            text-decoration: none;
        }

        .nav-item.active > a {
            color: #5856d6;
            background-color: #f0f0ff;
            position: relative;
        }

        .nav-item.active > a::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 5px;
            background-color: #5856d6;
            border-radius: 12px 0 0 12px;
        }

        .link-content {
            display: flex;
            align-items: center;
            justify-content: flex-start; 
            width: 100%;
        }

        .nav-icon {
            font-size: 1.1em;
            margin-right: 14px;
            min-width: 20px;
            text-align: center;
            color: #555;
        }
        
        .nav-item.active .nav-icon {
            color: #5856d6;
        }

        /* --- 成績管理（子メニュー）のスタイル --- */
        .submenu {
            padding: 4px 0 0 0 !important;
            margin: 0;
            display: none; 
            overflow: hidden;
        }

        /* 展開用のクラス（開いた時） */
        .submenu.open {
            display: block;
        }

        .submenu-item {
            margin-bottom: 6px;
        }

        .submenu-link {
            display: flex !important;
            align-items: center !important;
            justify-content: flex-start !important; 
            padding: 12px 18px 12px 40px !important; 
            border-radius: 10px;
            font-size: 0.9em !important;
            background-color: transparent !important;
            color: #333333 !important;
        }

        .submenu-link:hover {
            background-color: #f5f7fa !important;
        }

        .submenu-icon {
            font-size: 1.1em;
            margin-right: 12px;
            min-width: 20px;
            text-align: center;
            color: #555;
        }

        /* --- 背景のグラフィック --- */
        .sidebar-bg-graphic {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 250px;
            overflow: hidden;
            pointer-events: none;
            z-index: 1;
            transition: opacity 0.2s ease;
        }
        
        .sidebar.collapsed .sidebar-bg-graphic {
            opacity: 0 !important;
        }

        .dot-grid {
            position: absolute;
            bottom: 120px;
            right: 30px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
            opacity: 0.5;
        }

        .dot {
            width: 5px;
            height: 5px;
            background-color: #cbd5e0;
            border-radius: 50%;
        }

        .fluid-bg {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 10% 90%, #e0dbff 0%, transparent 50%),
                        radial-gradient(circle at 50% 100%, #e6fffa 0%, transparent 60%);
            opacity: 0.8;
            filter: blur(4px);
        }
    </style>

    <div class="sidebar-menu-content">
        <ul>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/menu.jsp">
                    <div class="link-content">
                        <i class="fa-solid fa-house nav-icon"></i>
                        ダッシュボード
                    </div>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/StudentList.action">
                    <div class="link-content">
                        <i class="fa-solid fa-user-group nav-icon"></i>
                        学生管理
                    </div>
                </a>
            </li>

            <li class="nav-item">
                <a href="#" id="submenu-toggle" style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
                    <div class="link-content">
                        <i class="fa-solid fa-chart-line nav-icon"></i>
                        成績管理
                    </div>
                    <i class="fa-solid fa-chevron-down arrow-icon" id="submenu-arrow" style="font-size: 0.8em; color: #777; transition: transform 0.25s ease;"></i>
                </a>
                <ul class="submenu" id="target-submenu">
                    <li class="submenu-item">
                        <a href="${pageContext.request.contextPath}/ScoreListServlet.action" class="submenu-link">
                            <i class="fa-regular fa-pen-to-square submenu-icon"></i>
                            成績登録
                        </a>
                    </li>
                    <li class="submenu-item">
                        <a href="${pageContext.request.contextPath}/ScoreSubject.action" class="submenu-link">
                            <i class="fa-solid fa-chart-bar submenu-icon"></i>
                            成績参照
                        </a>
                    </li>
                </ul>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/SubjectList.action">
                    <div class="link-content">
                        <i class="fa-solid fa-book nav-icon"></i>
                        科目管理
                    </div>
                </a>
            </li>
        </ul>
    </div>

    <div class="sidebar-bg-graphic">
        <div class="fluid-bg"></div>
        <div class="dot-grid">
            <div class="dot"></div><div class="dot"></div><div class="dot"></div><div class="dot"></div>
            <div class="dot"></div><div class="dot"></div><div class="dot"></div><div class="dot"></div>
            <div class="dot"></div><div class="dot"></div><div class="dot"></div><div class="dot"></div>
            <div class="dot"></div><div class="dot"></div><div class="dot"></div><div class="dot"></div>
        </div>
    </div>
</aside>

        <li class="menu-title">成績管理</li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreListServlet.action">成績登録</a></li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ScoreSubject.action">成績参照</a></li>
        
        <!-- どの画面からでも1秒で起動できるように「席替え機能」を配置しました -->
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/SeatChange.action">席替え機能</a></li>

                <!-- 💡追加：エラー共有機能への導線 -->
        <li class="menu-title">エラー共有</li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ErrorPostInput.action">エラー投稿</a></li>
        <li style="padding-left: 20px;"><a href="${pageContext.request.contextPath}/ErrorPostList.action">エラー検索</a></li>
        

        <li class="menu-title"><a href="${pageContext.request.contextPath}/StudentPromote.action">年度末処理</a></li>

        <li class="menu-title"><a href="${pageContext.request.contextPath}/SubjectList.action">科目管理</a></li>
    </ul>
</aside>

