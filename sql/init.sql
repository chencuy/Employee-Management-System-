-- =============================================
-- 员工信息管理系统 - 数据库初始化脚本
-- =============================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS employee_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE employee_db;

-- 创建 employee 表
CREATE TABLE IF NOT EXISTS employee (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '员工ID，自增主键',
    emp_name VARCHAR(20) NOT NULL COMMENT '员工姓名',
    emp_age INT COMMENT '员工年龄',
    emp_gender CHAR(1) COMMENT '员工性别：M-男，F-女',
    emp_email VARCHAR(50) COMMENT '员工邮箱',
    emp_dept VARCHAR(30) COMMENT '员工部门'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工信息表';

-- 插入测试数据
INSERT INTO employee (emp_name, emp_age, emp_gender, emp_email, emp_dept) VALUES
('张三', 28, 'M', 'zhangsan@example.com', '技术部'),
('李四', 32, 'F', 'lisi@example.com', '市场部'),
('王五', 25, 'M', 'wangwu@example.com', '技术部'),
('赵六', 30, 'F', 'zhaoliu@example.com', '人事部'),
('孙七', 27, 'M', 'sunqi@example.com', '财务部'),
('周八', 35, 'M', 'zhouba@example.com', '技术部'),
('吴九', 24, 'F', 'wujiu@example.com', '市场部'),
('郑十', 29, 'M', 'zhengshi@example.com', '人事部');
