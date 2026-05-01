package com.example;

import com.example.entity.Employee;
import com.example.mapper.EmployeeMapper;
import com.example.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.*;

/**
 * 员工 Mapper 测试类
 * 包含所有4道编程题的测试
 */
public class EmployeeMapperTest {

    private SqlSession sqlSession;
    private EmployeeMapper employeeMapper;

    @Before
    public void setUp() {
        // 获取 SqlSession（手动提交事务）
        sqlSession = MyBatisUtil.getSqlSession();
        // 获取 Mapper 接口代理对象
        employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
    }

    @After
    public void tearDown() {
        // 关闭 SqlSession
        if (sqlSession != null) {
            sqlSession.close();
        }
    }

    // ==================== 第1题：基础 CRUD 功能测试 ====================

    /**
     * 测试1.1：根据 id 查询员工
     */
    @Test
    public void testSelectById() {
        System.out.println("===== 测试：根据 id 查询员工 =====");
        Employee employee = employeeMapper.selectById(1);
        System.out.println("查询结果：" + employee);
        assert employee != null : "根据id查询员工失败";
        System.out.println("测试通过！\n");
    }

    /**
     * 测试1.2：添加员工（返回自增主键）
     */
    @Test
    public void testInsert() {
        System.out.println("===== 测试：添加员工 =====");
        Employee employee = new Employee();
        employee.setEmpName("测试员工");
        employee.setEmpAge(26);
        employee.setEmpGender("M");
        employee.setEmpEmail("test@example.com");
        employee.setEmpDept("测试部");

        int rows = employeeMapper.insert(employee);
        sqlSession.commit(); // 手动提交事务

        System.out.println("插入行数：" + rows);
        System.out.println("返回的自增主键ID：" + employee.getId());
        assert rows > 0 : "添加员工失败";
        assert employee.getId() != null : "返回自增主键失败";
        System.out.println("测试通过！\n");
    }

    /**
     * 测试1.3：根据 id 修改员工信息
     */
    @Test
    public void testUpdateById() {
        System.out.println("===== 测试：根据 id 修改员工信息 =====");
        Employee employee = new Employee();
        employee.setId(1); // 修改 id=1 的员工
        employee.setEmpName("张三（已修改）");
        employee.setEmpAge(30);
        employee.setEmpGender("M");
        employee.setEmpEmail("zhangsan_new@example.com");
        employee.setEmpDept("研发部");

        int rows = employeeMapper.updateById(employee);
        sqlSession.commit();

        System.out.println("修改行数：" + rows);
        // 验证修改结果
        Employee updated = employeeMapper.selectById(1);
        System.out.println("修改后的员工信息：" + updated);
        assert rows > 0 : "修改员工信息失败";
        System.out.println("测试通过！\n");
    }

    /**
     * 测试1.4：根据 id 删除员工
     */
    @Test
    public void testDeleteById() {
        System.out.println("===== 测试：根据 id 删除员工 =====");
        // 先插入一条测试数据
        Employee employee = new Employee();
        employee.setEmpName("待删除员工");
        employee.setEmpAge(25);
        employee.setEmpGender("F");
        employee.setEmpEmail("delete@example.com");
        employee.setEmpDept("临时部");
        employeeMapper.insert(employee);
        sqlSession.commit();

        Integer idToDelete = employee.getId();
        System.out.println("插入的待删除员工ID：" + idToDelete);

        // 执行删除
        int rows = employeeMapper.deleteById(idToDelete);
        sqlSession.commit();

        System.out.println("删除行数：" + rows);
        // 验证删除结果
        Employee deleted = employeeMapper.selectById(idToDelete);
        System.out.println("删除后查询结果：" + deleted);
        assert rows > 0 : "删除员工失败";
        assert deleted == null : "员工未被删除";
        System.out.println("测试通过！\n");
    }

    /**
     * 测试1.5：查询所有员工
     */
    @Test
    public void testSelectAll() {
        System.out.println("===== 测试：查询所有员工 =====");
        List<Employee> employees = employeeMapper.selectAll();
        System.out.println("员工总数：" + employees.size());
        for (Employee emp : employees) {
            System.out.println(emp);
        }
        assert employees != null && !employees.isEmpty() : "查询所有员工失败";
        System.out.println("测试通过！\n");
    }

    // ==================== 第2题：多种参数传递方式测试 ====================

    /**
     * 测试2.1：根据姓名 + 部门精确查询（多参数传递 @Param）
     */
    @Test
    public void testSelectByNameAndDept() {
        System.out.println("===== 测试：根据姓名 + 部门精确查询 =====");
        List<Employee> employees = employeeMapper.selectByNameAndDept("张三", "技术部");
        System.out.println("查询结果数量：" + employees.size());
        for (Employee emp : employees) {
            System.out.println(emp);
        }
        System.out.println("测试通过！\n");
    }

    /**
     * 测试2.2：根据年龄 > ? 并且 性别 = ? 查询（Map 传参）
     */
    @Test
    public void testSelectByAgeAndGender() {
        System.out.println("===== 测试：根据年龄和性别查询（Map传参） =====");
        Map<String, Object> params = new HashMap<>();
        params.put("empAge", 25);
        params.put("empGender", "M");

        List<Employee> employees = employeeMapper.selectByAgeAndGender(params);
        System.out.println("年龄>25且性别为男的员工数量：" + employees.size());
        for (Employee emp : employees) {
            System.out.println(emp);
        }
        System.out.println("测试通过！\n");
    }

    /**
     * 测试2.3：根据姓名模糊查询（实体类传参）
     */
    @Test
    public void testSelectByNameLike() {
        System.out.println("===== 测试：根据姓名模糊查询（实体类传参） =====");
        Employee query = new Employee();
        query.setEmpName("张");

        List<Employee> employees = employeeMapper.selectByNameLike(query);
        System.out.println("姓名包含'张'的员工数量：" + employees.size());
        for (Employee emp : employees) {
            System.out.println(emp);
        }
        System.out.println("测试通过！\n");
    }

    // ==================== 第3题：resultMap 自定义映射测试 ====================

    /**
     * 测试3：使用 resultMap 查询员工
     */
    @Test
    public void testSelectByIdWithResultMap() {
        System.out.println("===== 测试：使用 resultMap 查询员工 =====");
        Employee employee = employeeMapper.selectByIdWithResultMap(1);
        System.out.println("使用 resultMap 查询结果：" + employee);
        assert employee != null : "使用 resultMap 查询失败";
        System.out.println("测试通过！\n");
    }

    // ==================== 第4题：动态 SQL 综合实现测试 ====================

    /**
     * 测试4.1：多条件组合查询（动态SQL）
     */
    @Test
    public void testSelectByCondition() {
        System.out.println("===== 测试：多条件组合查询 =====");

        // 测试场景1：只按姓名模糊查询
        System.out.println("--- 场景1：只按姓名模糊查询 ---");
        Employee condition1 = new Employee();
        condition1.setEmpName("张");
        List<Employee> result1 = employeeMapper.selectByCondition(condition1);
        System.out.println("姓名包含'张'的员工数量：" + result1.size());
        result1.forEach(System.out::println);

        // 测试场景2：按部门查询
        System.out.println("\n--- 场景2：按部门查询 ---");
        Employee condition2 = new Employee();
        condition2.setEmpDept("技术部");
        List<Employee> result2 = employeeMapper.selectByCondition(condition2);
        System.out.println("技术部员工数量：" + result2.size());
        result2.forEach(System.out::println);

        // 测试场景3：按性别 + 部门组合查询
        System.out.println("\n--- 场景3：按性别 + 部门组合查询 ---");
        Employee condition3 = new Employee();
        condition3.setEmpGender("M");
        condition3.setEmpDept("技术部");
        List<Employee> result3 = employeeMapper.selectByCondition(condition3);
        System.out.println("技术部男性员工数量：" + result3.size());
        result3.forEach(System.out::println);

        // 测试场景4：无条件查询（查询所有）
        System.out.println("\n--- 场景4：无条件查询（查询所有） ---");
        Employee condition4 = new Employee();
        List<Employee> result4 = employeeMapper.selectByCondition(condition4);
        System.out.println("所有员工数量：" + result4.size());

        System.out.println("\n测试通过！\n");
    }

    /**
     * 测试4.2：动态更新（只更新非空字段）
     */
    @Test
    public void testUpdateDynamic() {
        System.out.println("===== 测试：动态更新 =====");

        // 先查询原始数据
        Employee original = employeeMapper.selectById(1);
        System.out.println("原始数据：" + original);

        // 只更新姓名和邮箱，其他字段不更新
        Employee update = new Employee();
        update.setId(1);
        update.setEmpName("张三（动态更新）");
        update.setEmpEmail("dynamic_update@example.com");
        // empAge、empGender、empDept 为 null，不会被更新

        int rows = employeeMapper.updateDynamic(update);
        sqlSession.commit();

        System.out.println("更新行数：" + rows);

        // 验证更新结果
        Employee updated = employeeMapper.selectById(1);
        System.out.println("更新后数据：" + updated);
        assert rows > 0 : "动态更新失败";
        System.out.println("测试通过！\n");
    }

    /**
     * 测试4.3：批量删除
     */
    @Test
    public void testDeleteByIds() {
        System.out.println("===== 测试：批量删除 =====");

        // 先插入3条测试数据
        List<Integer> insertedIds = new ArrayList<>();
        for (int i = 1; i <= 3; i++) {
            Employee emp = new Employee();
            emp.setEmpName("批量删除测试" + i);
            emp.setEmpAge(20 + i);
            emp.setEmpGender("F");
            emp.setEmpEmail("batch" + i + "@example.com");
            emp.setEmpDept("测试部");
            employeeMapper.insert(emp);
            insertedIds.add(emp.getId());
        }
        sqlSession.commit();

        System.out.println("插入的测试数据ID：" + insertedIds);

        // 执行批量删除
        int rows = employeeMapper.deleteByIds(insertedIds);
        sqlSession.commit();

        System.out.println("删除行数：" + rows);

        // 验证删除结果
        for (Integer id : insertedIds) {
            Employee emp = employeeMapper.selectById(id);
            assert emp == null : "ID=" + id + " 的员工未被删除";
        }

        System.out.println("测试通过！\n");
    }
}
