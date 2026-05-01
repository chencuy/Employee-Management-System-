package com.example.entity;

/**
 * 员工实体类
 */
public class Employee {

    private Integer id;        // 员工ID
    private String empName;    // 员工姓名
    private Integer empAge;    // 员工年龄
    private String empGender;  // 员工性别
    private String empEmail;   // 员工邮箱
    private String empDept;    // 员工部门

    // 无参构造
    public Employee() {
    }

    // 全参构造
    public Employee(Integer id, String empName, Integer empAge, String empGender, String empEmail, String empDept) {
        this.id = id;
        this.empName = empName;
        this.empAge = empAge;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.empDept = empDept;
    }

    // Getter 和 Setter 方法
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public Integer getEmpAge() {
        return empAge;
    }

    public void setEmpAge(Integer empAge) {
        this.empAge = empAge;
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpDept() {
        return empDept;
    }

    public void setEmpDept(String empDept) {
        this.empDept = empDept;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", empName='" + empName + '\'' +
                ", empAge=" + empAge +
                ", empGender='" + empGender + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", empDept='" + empDept + '\'' +
                '}';
    }
}
