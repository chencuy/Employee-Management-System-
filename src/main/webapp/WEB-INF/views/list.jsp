<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工列表 - 员工信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar-brand { font-weight: 700; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .table th { background-color: #f8f9fa; font-weight: 600; white-space: nowrap; }
        .badge-gender-M { background-color: #4facfe; }
        .badge-gender-F { background-color: #f093fb; }
        .btn-action { padding: 4px 10px; font-size: 0.85rem; }
        .search-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .search-card .form-control, .search-card .form-select { border-radius: 8px; }
        .toast-container { position: fixed; top: 20px; right: 20px; z-index: 9999; }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-people-fill"></i> 员工管理系统
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/employee?action=list">
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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="bi bi-house"></i> 首页
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- 提示消息 -->
        <c:if test="${not empty sessionScope.msg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill"></i> ${sessionScope.msg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("msg"); %>
        </c:if>

        <!-- 搜索区域 -->
        <div class="card search-card mb-4 p-4">
            <h5 class="mb-3"><i class="bi bi-funnel-fill"></i> 多条件组合查询（动态SQL）</h5>
            <form action="${pageContext.request.contextPath}/employee" method="get">
                <input type="hidden" name="action" value="search">
                <div class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="empName" placeholder="员工姓名"
                               value="${searchCondition.empName}">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="empDept">
                            <option value="">全部部门</option>
                            <option value="技术部" ${searchCondition.empDept == '技术部' ? 'selected' : ''}>技术部</option>
                            <option value="市场部" ${searchCondition.empDept == '市场部' ? 'selected' : ''}>市场部</option>
                            <option value="人事部" ${searchCondition.empDept == '人事部' ? 'selected' : ''}>人事部</option>
                            <option value="财务部" ${searchCondition.empDept == '财务部' ? 'selected' : ''}>财务部</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="empGender">
                            <option value="">全部性别</option>
                            <option value="M" ${searchCondition.empGender == 'M' ? 'selected' : ''}>男</option>
                            <option value="F" ${searchCondition.empGender == 'F' ? 'selected' : ''}>女</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <input type="number" class="form-control" name="empAge" placeholder="年龄"
                               value="${searchCondition.empAge}">
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-light me-2">
                            <i class="bi bi-search"></i> 搜索
                        </button>
                        <a href="${pageContext.request.contextPath}/employee?action=list" class="btn btn-outline-light">
                            <i class="bi bi-arrow-counterclockwise"></i> 重置
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <!-- 员工列表 -->
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="mb-0">
                    <i class="bi bi-people"></i> 员工列表
                    <span class="badge bg-primary ms-2">${totalCount} 条</span>
                </h5>
                <div>
                    <button class="btn btn-danger btn-sm me-2" onclick="batchDelete()">
                        <i class="bi bi-trash"></i> 批量删除
                    </button>
                    <a href="${pageContext.request.contextPath}/employee?action=toAdd" class="btn btn-success btn-sm">
                        <i class="bi bi-plus-circle"></i> 添加员工
                    </a>
                </div>
            </div>

            <form id="batchDeleteForm" action="${pageContext.request.contextPath}/employee" method="get">
                <input type="hidden" name="action" value="batchDelete">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
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
                                    <td><input type="checkbox" name="ids" value="${emp.id}" class="emp-checkbox"></td>
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
                                           class="btn btn-outline-primary btn-action" title="编辑">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/employee?action=resultMap&id=${emp.id}"
                                           class="btn btn-outline-info btn-action" title="ResultMap查询">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/employee?action=delete&id=${emp.id}"
                                           class="btn btn-outline-danger btn-action"
                                           onclick="return confirm('确定要删除员工 ${emp.empName} 吗？')" title="删除">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty employees}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox" style="font-size: 2rem;"></i><br>
                                        暂无员工数据
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
    </div>

    <footer class="text-center text-muted py-4 mt-4">
        <small>Employee Management System &copy; 2024 | MyBatis 综合实战练习</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleSelectAll() {
            var selectAll = document.getElementById('selectAll');
            var checkboxes = document.querySelectorAll('.emp-checkbox');
            checkboxes.forEach(function(cb) { cb.checked = selectAll.checked; });
        }

        function batchDelete() {
            var checked = document.querySelectorAll('.emp-checkbox:checked');
            if (checked.length === 0) {
                alert('请先选择要删除的员工！');
                return;
            }
            if (confirm('确定要删除选中的 ' + checked.length + ' 名员工吗？此操作不可撤销！')) {
                document.getElementById('batchDeleteForm').submit();
            }
        }
    </script>
</body>
</html>
