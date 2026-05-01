package com.example.servlet;

import com.example.entity.Employee;
import com.example.mapper.EmployeeMapper;
import com.example.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * 员工管理 Servlet 控制器
 * 处理所有员工相关的请求
 */
public class EmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listEmployees(req, resp);
                break;
            case "toAdd":
                req.getRequestDispatcher("/WEB-INF/views/add.jsp").forward(req, resp);
                break;
            case "toEdit":
                toEdit(req, resp);
                break;
            case "delete":
                deleteEmployee(req, resp);
                break;
            case "search":
                searchEmployees(req, resp);
                break;
            case "queryParam":
                queryByParam(req, resp);
                break;
            case "queryMap":
                queryByMap(req, resp);
                break;
            case "queryEntity":
                queryByEntity(req, resp);
                break;
            case "resultMap":
                queryByResultMap(req, resp);
                break;
            case "dynamicQuery":
                dynamicQuery(req, resp);
                break;
            case "batchDelete":
                batchDelete(req, resp);
                break;
            default:
                listEmployees(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addEmployee(req, resp);
                break;
            case "update":
                updateEmployee(req, resp);
                break;
            case "dynamicUpdate":
                dynamicUpdateEmployee(req, resp);
                break;
            default:
                doGet(req, resp);
                break;
        }
    }

    /**
     * 查询所有员工
     */
    private void listEmployees(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> employees = mapper.selectAll();
            req.setAttribute("employees", employees);
            req.setAttribute("totalCount", employees.size());
            req.getRequestDispatcher("/WEB-INF/views/list.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 添加员工
     */
    private void addEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Employee employee = buildEmployeeFromRequest(req);
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.insert(employee);
            sqlSession.commit();
            req.getSession().setAttribute("msg", "员工添加成功！ID: " + employee.getId());
        } finally {
            sqlSession.close();
        }
        resp.sendRedirect(req.getContextPath() + "/employee?action=list");
    }

    /**
     * 跳转到编辑页面
     */
    private void toEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            Employee employee = mapper.selectById(id);
            req.setAttribute("employee", employee);
            req.getRequestDispatcher("/WEB-INF/views/edit.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 修改员工信息
     */
    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Employee employee = buildEmployeeFromRequest(req);
        employee.setId(Integer.parseInt(req.getParameter("id")));
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.updateById(employee);
            sqlSession.commit();
            req.getSession().setAttribute("msg", "员工信息修改成功！");
        } finally {
            sqlSession.close();
        }
        resp.sendRedirect(req.getContextPath() + "/employee?action=list");
    }

    /**
     * 删除员工
     */
    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.deleteById(id);
            sqlSession.commit();
            req.getSession().setAttribute("msg", "员工删除成功！");
        } finally {
            sqlSession.close();
        }
        resp.sendRedirect(req.getContextPath() + "/employee?action=list");
    }

    /**
     * 搜索员工（多条件组合查询 - 动态SQL）
     */
    private void searchEmployees(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Employee condition = new Employee();
        String empName = req.getParameter("empName");
        String empDept = req.getParameter("empDept");
        String empGender = req.getParameter("empGender");
        String empAge = req.getParameter("empAge");

        if (empName != null && !empName.trim().isEmpty()) {
            condition.setEmpName(empName.trim());
        }
        if (empDept != null && !empDept.trim().isEmpty()) {
            condition.setEmpDept(empDept.trim());
        }
        if (empGender != null && !empGender.trim().isEmpty()) {
            condition.setEmpGender(empGender.trim());
        }
        if (empAge != null && !empAge.trim().isEmpty()) {
            try {
                condition.setEmpAge(Integer.parseInt(empAge.trim()));
            } catch (NumberFormatException ignored) {
            }
        }

        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> employees = mapper.selectByCondition(condition);
            req.setAttribute("employees", employees);
            req.setAttribute("totalCount", employees.size());
            req.setAttribute("searchCondition", condition);
            req.getRequestDispatcher("/WEB-INF/views/list.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 第2题-1：根据姓名+部门精确查询（@Param传参）
     */
    private void queryByParam(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empName = req.getParameter("empName");
        String empDept = req.getParameter("empDept");
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> employees = mapper.selectByNameAndDept(empName, empDept);
            req.setAttribute("employees", employees);
            req.setAttribute("totalCount", employees.size());
            req.setAttribute("queryType", "@Param 多参数查询");
            req.setAttribute("queryDesc", "姓名: " + empName + ", 部门: " + empDept);
            req.getRequestDispatcher("/WEB-INF/views/queryResult.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 第2题-2：根据年龄和性别查询（Map传参）
     */
    private void queryByMap(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empAge = req.getParameter("empAge");
        String empGender = req.getParameter("empGender");
        Map<String, Object> params = new HashMap<>();
        params.put("empAge", Integer.parseInt(empAge));
        params.put("empGender", empGender);

        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> employees = mapper.selectByAgeAndGender(params);
            req.setAttribute("employees", employees);
            req.setAttribute("totalCount", employees.size());
            req.setAttribute("queryType", "Map 传参查询");
            req.setAttribute("queryDesc", "年龄 > " + empAge + ", 性别: " + ("M".equals(empGender) ? "男" : "女"));
            req.getRequestDispatcher("/WEB-INF/views/queryResult.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 第2题-3：根据姓名模糊查询（实体类传参）
     */
    private void queryByEntity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empName = req.getParameter("empName");
        Employee query = new Employee();
        query.setEmpName(empName);

        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            List<Employee> employees = mapper.selectByNameLike(query);
            req.setAttribute("employees", employees);
            req.setAttribute("totalCount", employees.size());
            req.setAttribute("queryType", "实体类传参查询");
            req.setAttribute("queryDesc", "姓名模糊: %" + empName + "%");
            req.getRequestDispatcher("/WEB-INF/views/queryResult.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 第3题：使用 resultMap 查询
     */
    private void queryByResultMap(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            Employee employee = mapper.selectByIdWithResultMap(id);
            req.setAttribute("employee", employee);
            req.setAttribute("queryType", "ResultMap 映射查询");
            req.getRequestDispatcher("/WEB-INF/views/detail.jsp").forward(req, resp);
        } finally {
            sqlSession.close();
        }
    }

    /**
     * 第4题-1：动态多条件查询页面
     */
    private void dynamicQuery(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/dynamicQuery.jsp").forward(req, resp);
    }

    /**
     * 第4题-2：动态更新
     */
    private void dynamicUpdateEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Employee employee = new Employee();
        employee.setId(Integer.parseInt(req.getParameter("id")));
        String empName = req.getParameter("empName");
        String empAge = req.getParameter("empAge");
        String empGender = req.getParameter("empGender");
        String empEmail = req.getParameter("empEmail");
        String empDept = req.getParameter("empDept");

        if (empName != null && !empName.trim().isEmpty()) {
            employee.setEmpName(empName.trim());
        }
        if (empAge != null && !empAge.trim().isEmpty()) {
            employee.setEmpAge(Integer.parseInt(empAge.trim()));
        }
        if (empGender != null && !empGender.trim().isEmpty()) {
            employee.setEmpGender(empGender.trim());
        }
        if (empEmail != null && !empEmail.trim().isEmpty()) {
            employee.setEmpEmail(empEmail.trim());
        }
        if (empDept != null && !empDept.trim().isEmpty()) {
            employee.setEmpDept(empDept.trim());
        }

        SqlSession sqlSession = MyBatisUtil.getSqlSession();
        try {
            EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
            mapper.updateDynamic(employee);
            sqlSession.commit();
            req.getSession().setAttribute("msg", "动态更新成功！仅更新了非空字段。");
        } finally {
            sqlSession.close();
        }
        resp.sendRedirect(req.getContextPath() + "/employee?action=list");
    }

    /**
     * 第4题-3：批量删除
     */
    private void batchDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] idStrs = req.getParameterValues("ids");
        if (idStrs != null && idStrs.length > 0) {
            List<Integer> ids = new ArrayList<>();
            for (String idStr : idStrs) {
                ids.add(Integer.parseInt(idStr));
            }
            SqlSession sqlSession = MyBatisUtil.getSqlSession();
            try {
                EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
                int count = mapper.deleteByIds(ids);
                sqlSession.commit();
                req.getSession().setAttribute("msg", "批量删除成功！共删除 " + count + " 条记录。");
            } finally {
                sqlSession.close();
            }
        } else {
            req.getSession().setAttribute("msg", "请选择要删除的员工！");
        }
        resp.sendRedirect(req.getContextPath() + "/employee?action=list");
    }

    /**
     * 从请求中构建 Employee 对象
     */
    private Employee buildEmployeeFromRequest(HttpServletRequest req) {
        Employee employee = new Employee();
        String empName = req.getParameter("empName");
        String empAge = req.getParameter("empAge");
        String empGender = req.getParameter("empGender");
        String empEmail = req.getParameter("empEmail");
        String empDept = req.getParameter("empDept");

        if (empName != null && !empName.trim().isEmpty()) {
            employee.setEmpName(empName.trim());
        }
        if (empAge != null && !empAge.trim().isEmpty()) {
            employee.setEmpAge(Integer.parseInt(empAge.trim()));
        }
        if (empGender != null && !empGender.trim().isEmpty()) {
            employee.setEmpGender(empGender.trim());
        }
        if (empEmail != null && !empEmail.trim().isEmpty()) {
            employee.setEmpEmail(empEmail.trim());
        }
        if (empDept != null && !empDept.trim().isEmpty()) {
            employee.setEmpDept(empDept.trim());
        }
        return employee;
    }
}
