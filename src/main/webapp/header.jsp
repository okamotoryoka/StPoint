<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
    header.header_fixed_style {
        all: unset !important;
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        background-color: #ffffff !important;
        border-bottom: 1px solid #edf2f7 !important;
        height: 70px !important;
        padding: 0 30px !important;
        box-sizing: border-box !important;
        width: 100% !important;
        position: relative !important;
        z-index: 9999 !important;
    }

    .header_fixed_style .header-left-box {
        display: flex !important;
        align-items: center !important;
        margin-right: auto !important;
    }

    /* 【追加】三本線メニューボタンのスタイル */
    .header_fixed_style .menu-toggle-btn {
        background: none !important;
        border: none !important;
        font-size: 20px !important;
        color: #4a5568 !important;
        cursor: pointer !important;
        margin-right: 15px !important;
        padding: 5px !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        border-radius: 6px !important;
        transition: background-color 0.2s !important;
    }
    .header_fixed_style .menu-toggle-btn:hover {
        background-color: #f7fafc !important;
        color: #5d5fef !important;
    }

    .header_fixed_style .logo-icon-box {
        font-size: 26px !important;
        color: #5d5fef !important;
        margin-right: 12px !important;
        display: inline-block !important;
    }

    .header_fixed_style .logo-text-box {
        display: flex !important;
        flex-direction: column !important;
        text-align: left !important;
    }

    .header_fixed_style .title-jp-box {
        font-weight: bold !important;
        font-size: 1.1em !important;
        color: #1a202c !important;
        line-height: 1.2 !important;
    }

    .header_fixed_style .title-en-box {
        color: #a0aec0 !important;
        font-size: 0.75em !important;
        margin-top: 2px !important;
    }

    .header_fixed_style .header-right-box {
        display: flex !important;
        align-items: center !important;
        gap: 24px !important;
        margin-left: auto !important;
    }

    .header_fixed_style .user-info-box {
        display: flex !important;
        align-items: center !important;
        gap: 8px !important;
    }

    .header_fixed_style .user-icon-box {
        font-size: 24px !important;
        color: #5d5fef !important;
    }

    .header_fixed_style .user-name-box {
        font-weight: bold !important;
        color: #4a5568 !important;
    }

    .header_fixed_style .logout-box {
        display: flex !important;
        align-items: center !important;
        gap: 6px !important;
        color: #4a5568 !important;
        text-decoration: none !important;
        font-weight: bold !important;
    }

    .header_fixed_style .logout-box:hover {
        color: #5d5fef !important;
        text-decoration: underline !important;
    }
</style>

<header class="header_fixed_style">
    <div class="header-left-box">
        <button type="button" id="toggle-sidebar" class="menu-toggle-btn">
            <i class="fa-solid fa-bars"></i>
        </button>
        
        <i class="fa-solid fa-cube logo-icon-box"></i>
        <div class="logo-text-box">
            <span class="title-jp-box">得点管理システム</span>
            <span class="title-en-box">Score Management System</span>
        </div>
    </div>

    <div class="header-right-box">
        <% if(session.getAttribute("teacher_name") != null){ %>
            <div class="user-info-box">
                <i class="fa-solid fa-circle-user user-icon-box"></i>
                <span class="user-name-box">${sessionScope.teacher_name} 様</span>
            </div>

            <a href="${pageContext.request.contextPath}/Logout.action" class="logout-box">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>ログアウト</span>
            </a>
        <% } %>
    </div>
</header>