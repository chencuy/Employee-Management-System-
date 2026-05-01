package com.example.mapper;

import com.example.entity.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 员工 Mapper 接口
 * 包含所有 CRUD 操作、参数传递、动态 SQL 方法
 */
public interface EmployeeMapper {

    // ==================== 第1题：基础 CRUD 功能 ====================

    /**
     * 1. 根据 id 查询员工
     * @param id 员工ID
     * @return 员工对象
     */
    Employee selectById(Integer id);

    /**
     * 2. 添加员工（返回自增主键）
     * @param employee 员工对象
     * @return 影响行数
     */
    int insert(Employee employee);

    /**
     * 3. 根据 id 修改员工信息
     * @param employee 员工对象（包含id和要修改的字段）
     * @return 影响行数
     */
    int updateById(Employee employee);

    /**
     * 4. 根据 id 删除员工
     * @param id 员工ID
     * @return 影响行数
     */
    int deleteById(Integer id);

    /**
     * 5. 查询所有员工
     * @return 员工列表
     */
    List<Employee> selectAll();

    // ==================== 第2题：多种参数传递方式 ====================

    /**
     * 1. 根据姓名 + 部门精确查询员工（多参数传递 @Param）
     * @param empName 员工姓名
     * @param empDept 员工部门
     * @return 员工列表
     */
    List<Employee> selectByNameAndDept(@Param("empName") String empName, @Param("empDept") String empDept);

    /**
     * 2. 根据年龄 > ? 并且 性别 = ? 查询（Map 传参）
     * @param params 包含 empAge 和 empGender 的 Map
     * @return 员工列表
     */
    List<Employee> selectByAgeAndGender(Map<String, Object> params);

    /**
     * 3. 根据姓名模糊查询员工列表（实体类传参）
     * @param employee 包含 empName 的员工对象
     * @return 员工列表
     */
    List<Employee> selectByNameLike(Employee employee);

    // ==================== 第3题：resultMap 自定义映射 ====================

    /**
     * 根据 id 查询员工，使用自定义 resultMap 返回结果
     * @param id 员工ID
     * @return 员工对象
     */
    Employee selectByIdWithResultMap(Integer id);

    // ==================== 第4题：动态 SQL 综合实现 ====================

    /**
     * 1. 多条件组合查询（动态SQL）
     * 支持：姓名模糊、年龄区间、部门、性别，任意组合查询
     * @param employee 包含查询条件的员工对象
     * @return 员工列表
     */
    List<Employee> selectByCondition(Employee employee);

    /**
     * 2. 动态更新（只更新非空字段）
     * @param employee 员工对象（只更新非空字段）
     * @return 影响行数
     */
    int updateDynamic(Employee employee);

    /**
     * 3. 批量删除（传入多个id）
     * @param ids 员工ID列表
     * @return 影响行数
     */
    int deleteByIds(List<Integer> ids);
}
