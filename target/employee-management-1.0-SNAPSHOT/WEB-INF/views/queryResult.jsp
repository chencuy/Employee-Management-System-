<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>查询结果 - 员工信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .table th { background-color: #f8f9fa; font-weight: 600; white-space: nowrap; }
        .badge-gender-M { background-color: #4facfe; }
        .badge-gender-F { background-color: #f093fb; }
        .page-header { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border-radius: 12px; }
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
            <div class="col-md-10">
                <!-- 页面标题 -->
                <div class="page-header p-4 mb-4">
                    <h4 class="mb-0"><i class="bi bi-search"></i> 查询结果</h4>
                    <small class="opacity-75">查询方式：${queryType} | 查询条件：${queryDesc}</small>
                </div>

                <!-- 查询结果 -->
                <div class="card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="mb-0">
                            <i class="bi bi-people"></i> 查询结果
                            <span class="badge bg-primary ms-2">${totalCount} 条</span>
                        </h5>
                        <a href="${pageContext.request.contextPath}/employee?action=dynamicQuery"
                           class="btn btn-outline-primary btn-sm">
                            <i class="bi bi-arrow-left"></i> 返回查询
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>姓名</th>
                                    <th>年龄</th>
                                    <th>性别</th>
                                    <th>邮箱</th>
                                    <th>部门</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employees}">
                                    <tr>
                                        <td><span class="badge bg-secondary">${emp.id}</span></td>
                                        <td><strong>${emp.empName}</strong></td>
                                        <td>${emp.empAge}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${emp.empGender == 'M'}">
                                                    <span class="badge badge-gender-M"><i class="bi bi-gender-male"></i> 男</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-gender-F"><i class="bi bi-gender-female"></i> 女</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${emp.empEmail}</td>
                                        <td><span class="badge bg-info text-dark">${emp.empDept}</span></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/employee?action=toEdit&id=${emp.id}"
                                               class="btn btn-outline-primary btn-sm" title="编辑">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/employee?action=resultMap&id=${emp.id}"
                                               class="btn btn-outline-info btn-sm" title="详情">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty employees}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox" style="font-size: 2rem;"></i><br>
                                            未找到匹配的员工记录
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
