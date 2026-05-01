<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加员工 - 员工信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .form-label { font-weight: 600; color: #444; }
        .form-control, .form-select { border-radius: 8px; padding: 10px 15px; }
        .form-control:focus, .form-select:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25); }
        .page-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 12px; }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-people-fill"></i> 员工管理系统
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/employee?action=list">
                            <i class="bi bi-list-ul"></i> 员工列表
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/employee?action=toAdd">
                            <i class="bi bi-plus-circle"></i> 添加员工
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/employee?action=dynamicQuery">
                            <i class="bi bi-search"></i> 高级查询
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <!-- 页面标题 -->
                <div class="page-header p-4 mb-4">
                    <h4 class="mb-0"><i class="bi bi-person-plus-fill"></i> 添加新员工</h4>
                    <small class="opacity-75">填写以下信息创建新员工记录（第1题：添加员工，返回自增主键）</small>
                </div>

                <!-- 添加表单 -->
                <div class="card p-4">
                    <form action="${pageContext.request.contextPath}/employee" method="post">
                        <input type="hidden" name="action" value="add">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-person text-primary"></i> 员工姓名 <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="empName" required
                                       placeholder="请输入员工姓名" maxlength="20">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-calendar text-primary"></i> 年龄
                                </label>
                                <input type="number" class="form-control" name="empAge"
                                       placeholder="请输入年龄" min="1" max="150">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-gender-ambiguous text-primary"></i> 性别
                                </label>
                                <select class="form-select" name="empGender">
                                    <option value="">请选择性别</option>
                                    <option value="M">男</option>
                                    <option value="F">女</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-envelope text-primary"></i> 邮箱
                                </label>
                                <input type="email" class="form-control" name="empEmail"
                                       placeholder="请输入邮箱" maxlength="50">
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">
                                    <i class="bi bi-building text-primary"></i> 部门
                                </label>
                                <select class="form-select" name="empDept">
                                    <option value="">请选择部门</option>
                                    <option value="技术部">技术部</option>
                                    <option value="市场部">市场部</option>
                                    <option value="人事部">人事部</option>
                                    <option value="财务部">财务部</option>
                                    <option value="测试部">测试部</option>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/employee?action=list"
                               class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left"></i> 返回列表
                            </a>
                            <div>
                                <button type="reset" class="btn btn-outline-warning me-2">
                                    <i class="bi bi-arrow-counterclockwise"></i> 重置
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle"></i> 提交保存
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
