<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>高级查询 - 员工信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08); }
        .form-label { font-weight: 600; color: #444; }
        .form-control, .form-select { border-radius: 8px; padding: 10px 15px; }
        .form-control:focus, .form-select:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25); }
        .query-card { transition: all 0.3s ease; }
        .query-card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.12); }
        .query-header-1 { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 12px 12px 0 0; }
        .query-header-2 { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border-radius: 12px 12px 0 0; }
        .query-header-3 { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; border-radius: 12px 12px 0 0; }
        .query-header-4 { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; border-radius: 12px 12px 0 0; }
        .query-header-5 { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; border-radius: 12px 12px 0 0; }
        .query-header-6 { background: linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%); color: white; border-radius: 12px 12px 0 0; }
        .badge-tech { background-color: #667eea; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/employee?action=dynamicQuery">
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
        <!-- 页面标题 -->
        <div class="text-center mb-4">
            <h2><i class="bi bi-search text-primary"></i> 高级查询中心</h2>
            <p class="text-muted">演示 MyBatis 多种参数传递方式和动态 SQL 功能</p>
        </div>

        <div class="row g-4">
            <!-- 第2题-1：@Param 多参数查询 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-1 p-3">
                        <h5 class="mb-0"><i class="bi bi-tag-fill"></i> 第2题-1：@Param 多参数查询</h5>
                        <small class="opacity-75">根据姓名 + 部门精确查询</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="get">
                            <input type="hidden" name="action" value="queryParam">
                            <div class="mb-3">
                                <label class="form-label">员工姓名</label>
                                <input type="text" class="form-control" name="empName" required placeholder="请输入员工姓名">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">所属部门</label>
                                <select class="form-select" name="empDept" required>
                                    <option value="">请选择部门</option>
                                    <option value="技术部">技术部</option>
                                    <option value="市场部">市场部</option>
                                    <option value="人事部">人事部</option>
                                    <option value="财务部">财务部</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> 精确查询
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code>@Param</code> 注解传递多个参数
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 第2题-2：Map 传参查询 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-2 p-3">
                        <h5 class="mb-0"><i class="bi bi-map-fill"></i> 第2题-2：Map 传参查询</h5>
                        <small class="opacity-75">根据年龄 > ? 并且 性别 = ? 查询</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="get">
                            <input type="hidden" name="action" value="queryMap">
                            <div class="mb-3">
                                <label class="form-label">年龄大于</label>
                                <input type="number" class="form-control" name="empAge" required placeholder="请输入年龄" min="1" max="150">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">性别</label>
                                <select class="form-select" name="empGender" required>
                                    <option value="">请选择性别</option>
                                    <option value="M">男</option>
                                    <option value="F">女</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-success w-100">
                                <i class="bi bi-search"></i> 条件查询
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code>Map<String, Object></code> 传参
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 第2题-3：实体类传参查询 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-3 p-3">
                        <h5 class="mb-0"><i class="bi bi-person-fill"></i> 第2题-3：实体类传参查询</h5>
                        <small class="opacity-75">根据姓名模糊查询员工列表</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="get">
                            <input type="hidden" name="action" value="queryEntity">
                            <div class="mb-3">
                                <label class="form-label">姓名关键词</label>
                                <input type="text" class="form-control" name="empName" required placeholder="请输入姓名关键词（支持模糊匹配）">
                            </div>
                            <button type="submit" class="btn btn-info w-100">
                                <i class="bi bi-search"></i> 模糊查询
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code>Employee</code> 实体类传参
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 第3题：ResultMap 查询 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-4 p-3">
                        <h5 class="mb-0"><i class="bi bi-diagram-3-fill"></i> 第3题：ResultMap 映射查询</h5>
                        <small class="opacity-75">使用自定义 resultMap 返回结果</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="get">
                            <input type="hidden" name="action" value="resultMap">
                            <div class="mb-3">
                                <label class="form-label">员工ID</label>
                                <input type="number" class="form-control" name="id" required placeholder="请输入员工ID" min="1">
                            </div>
                            <button type="submit" class="btn btn-danger w-100">
                                <i class="bi bi-search"></i> ResultMap 查询
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code><resultMap></code> 手动映射字段
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 第4题-1：动态多条件查询 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-5 p-3">
                        <h5 class="mb-0"><i class="bi bi-funnel-fill"></i> 第4题-1：动态多条件查询</h5>
                        <small class="opacity-75">支持姓名、年龄、性别、部门任意组合</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="get">
                            <input type="hidden" name="action" value="search">
                            <div class="row g-2">
                                <div class="col-6">
                                    <label class="form-label">姓名</label>
                                    <input type="text" class="form-control" name="empName" placeholder="模糊匹配">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">年龄</label>
                                    <input type="number" class="form-control" name="empAge" placeholder="精确匹配" min="1">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">性别</label>
                                    <select class="form-select" name="empGender">
                                        <option value="">全部</option>
                                        <option value="M">男</option>
                                        <option value="F">女</option>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">部门</label>
                                    <select class="form-select" name="empDept">
                                        <option value="">全部</option>
                                        <option value="技术部">技术部</option>
                                        <option value="市场部">市场部</option>
                                        <option value="人事部">人事部</option>
                                        <option value="财务部">财务部</option>
                                    </select>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-warning w-100 mt-3">
                                <i class="bi bi-search"></i> 动态查询
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code><where></code> + <code><if></code> 动态SQL
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 第4题-2：动态更新 -->
            <div class="col-md-6">
                <div class="card query-card">
                    <div class="query-header-6 p-3">
                        <h5 class="mb-0"><i class="bi bi-pencil-fill"></i> 第4题-2：动态更新</h5>
                        <small class="opacity-75">只更新非空字段，不修改未传字段</small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/employee" method="post">
                            <input type="hidden" name="action" value="dynamicUpdate">
                            <div class="mb-3">
                                <label class="form-label">员工ID <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="id" required placeholder="请输入要更新的员工ID" min="1">
                            </div>
                            <div class="row g-2">
                                <div class="col-6">
                                    <label class="form-label">姓名 <small class="text-muted">(留空不更新)</small></label>
                                    <input type="text" class="form-control" name="empName" placeholder="新姓名">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">年龄 <small class="text-muted">(留空不更新)</small></label>
                                    <input type="number" class="form-control" name="empAge" placeholder="新年龄" min="1">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">性别 <small class="text-muted">(留空不更新)</small></label>
                                    <select class="form-select" name="empGender">
                                        <option value="">不更新</option>
                                        <option value="M">男</option>
                                        <option value="F">女</option>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">部门 <small class="text-muted">(留空不更新)</small></label>
                                    <select class="form-select" name="empDept">
                                        <option value="">不更新</option>
                                        <option value="技术部">技术部</option>
                                        <option value="市场部">市场部</option>
                                        <option value="人事部">人事部</option>
                                        <option value="财务部">财务部</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3 mt-2">
                                <label class="form-label">邮箱 <small class="text-muted">(留空不更新)</small></label>
                                <input type="email" class="form-control" name="empEmail" placeholder="新邮箱">
                            </div>
                            <button type="submit" class="btn btn-purple w-100" style="background: linear-gradient(135deg, #a18cd1, #fbc2eb); color: white; border: none;">
                                <i class="bi bi-pencil-square"></i> 动态更新
                            </button>
                            <div class="mt-2">
                                <small class="text-muted">
                                    <i class="bi bi-code-slash"></i> 使用 <code><set></code> + <code><if></code> 动态SQL
                                </small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- 技术说明 -->
        <div class="card mt-4 mb-4">
            <div class="card-body p-4">
                <h5 class="mb-3"><i class="bi bi-book-fill text-primary"></i> MyBatis 知识点总结</h5>
                <div class="row">
                    <div class="col-md-4">
                        <h6 class="text-primary"><i class="bi bi-tag"></i> 参数传递方式</h6>
                        <ul class="list-unstyled ms-3">
                            <li><i class="bi bi-check-circle text-success"></i> <code>@Param</code> 注解传参</li>
                            <li><i class="bi bi-check-circle text-success"></i> <code>Map</code> 集合传参</li>
                            <li><i class="bi bi-check-circle text-success"></i> 实体类对象传参</li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h6 class="text-primary"><i class="bi bi-diagram-3"></i> 结果映射</h6>
                        <ul class="list-unstyled ms-3">
                            <li><i class="bi bi-check-circle text-success"></i> <code>resultType</code> 自动映射</li>
                            <li><i class="bi bi-check-circle text-success"></i> <code>resultMap</code> 手动映射</li>
                            <li><i class="bi bi-check-circle text-success"></i> 驼峰命名自动转换</li>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <h6 class="text-primary"><i class="bi bi-lightning"></i> 动态 SQL</h6>
                        <ul class="list-unstyled ms-3">
                            <li><i class="bi bi-check-circle text-success"></i> <code><if></code> 条件判断</li>
                            <li><i class="bi bi-check-circle text-success"></i> <code><where></code> 智能WHERE</li>
                            <li><i class="bi bi-check-circle text-success"></i> <code><set></code> 智能SET</li>
                            <li><i class="bi bi-check-circle text-success"></i> <code><foreach></code> 循环遍历</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="text-center text-muted py-4">
        <small>Employee Management System &copy; 2024 | MyBatis 综合实战练习</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
