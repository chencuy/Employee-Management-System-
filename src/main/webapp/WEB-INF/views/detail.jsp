<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工详情 - 员工信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .page-header { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; border-radius: 12px; }
        .detail-label { font-weight: 600; color: #555; min-width: 100px; }
        .detail-value { color: #333; font-size: 1.1rem; }
        .info-row { padding: 15px 0; border-bottom: 1px dashed #e9ecef; }
        .info-row:last-child { border-bottom: none; }
        .avatar { width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; color: white; }
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/employee?action=toAdd">
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
                    <h4 class="mb-0"><i class="bi bi-person-badge"></i> 员工详情</h4>
                    <small class="opacity-75">查询方式：${queryType}（第3题：使用 resultMap 自定义映射）</small>
                </div>

                <!-- 员工信息卡片 -->
                <div class="card p-4">
                    <div class="d-flex align-items-center mb-4">
                        <div class="avatar me-3" style="background: linear-gradient(135deg, #667eea, #764ba2);">
                            <i class="bi bi-person-fill"></i>
                        </div>
                        <div>
                            <h3 class="mb-0">${employee.empName}</h3>
                            <span class="badge bg-info text-dark">${employee.empDept}</span>
                            <span class="badge bg-secondary">ID: ${employee.id}</span>
                        </div>
                    </div>

                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-hash text-primary"></i> 员工ID</span>
                        <span class="detail-value">${employee.id}</span>
                    </div>
                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-person text-primary"></i> 姓名</span>
                        <span class="detail-value">${employee.empName}</span>
                    </div>
                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-calendar text-primary"></i> 年龄</span>
                        <span class="detail-value">${employee.empAge} 岁</span>
                    </div>
                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-gender-ambiguous text-primary"></i> 性别</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${employee.empGender == 'M'}">
                                    <span class="badge" style="background-color: #4facfe;"><i class="bi bi-gender-male"></i> 男</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge" style="background-color: #f093fb;"><i class="bi bi-gender-female"></i> 女</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-envelope text-primary"></i> 邮箱</span>
                        <span class="detail-value">${employee.empEmail}</span>
                    </div>
                    <div class="info-row d-flex align-items-center">
                        <span class="detail-label"><i class="bi bi-building text-primary"></i> 部门</span>
                        <span class="detail-value"><span class="badge bg-info text-dark">${employee.empDept}</span></span>
                    </div>

                    <hr class="my-4">

                    <!-- ResultMap 说明 -->
                    <div class="alert alert-info mb-4">
                        <h6 class="alert-heading"><i class="bi bi-info-circle-fill"></i> ResultMap 映射说明</h6>
                        <p class="mb-1">此查询使用了自定义 <code><resultMap></code> 进行字段映射：</p>
                        <ul class="mb-0">
                            <li><code>emp_name</code> → <code>empName</code></li>
                            <li><code>emp_age</code> → <code>empAge</code></li>
                            <li><code>emp_dept</code> → <code>empDept</code></li>
                        </ul>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/employee?action=list"
                           class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> 返回列表
                        </a>
                        <a href="${pageContext.request.contextPath}/employee?action=toEdit&id=${employee.id}"
                           class="btn btn-primary">
                            <i class="bi bi-pencil-square"></i> 编辑员工
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
