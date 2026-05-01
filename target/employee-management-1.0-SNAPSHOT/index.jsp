<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工信息管理系统</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .hero-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 60px;
            max-width: 700px;
            width: 100%;
        }
        .hero-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        .hero-subtitle {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 40px;
        }
        .feature-card {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
            margin-bottom: 15px;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            text-decoration: none;
            color: inherit;
        }
        .feature-icon {
            font-size: 2rem;
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .bg-gradient-primary { background: linear-gradient(135deg, #667eea, #764ba2); }
        .bg-gradient-success { background: linear-gradient(135deg, #11998e, #38ef7d); }
        .bg-gradient-info { background: linear-gradient(135deg, #4facfe, #00f2fe); }
        .bg-gradient-warning { background: linear-gradient(135deg, #f093fb, #f5576c); }
    </style>
</head>
<body>
    <div class="hero-card">
        <div class="text-center">
            <h1 class="hero-title"><i class="bi bi-people-fill text-primary"></i> 员工信息管理系统</h1>
            <p class="hero-subtitle">Employee Management System - MyBatis 综合实战</p>
        </div>

        <div class="row g-3">
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/employee?action=list" class="feature-card card p-4">
                    <div class="d-flex align-items-center">
                        <div class="feature-icon bg-gradient-primary me-3">
                            <i class="bi bi-list-ul"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">员工管理</h5>
                            <small class="text-muted">查看、添加、编辑、删除员工</small>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/employee?action=dynamicQuery" class="feature-card card p-4">
                    <div class="d-flex align-items-center">
                        <div class="feature-icon bg-gradient-success me-3">
                            <i class="bi bi-search"></i>
                        </div>
                        <div>
                            <h5 class="mb-1">高级查询</h5>
                            <small class="text-muted">多条件组合、参数传递方式演示</small>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="text-center mt-4">
            <small class="text-muted">
                <i class="bi bi-gear-fill"></i> 技术栈：MyBatis 3.5 + MySQL 8.0 + Servlet + JSP + Bootstrap 5
            </small>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
