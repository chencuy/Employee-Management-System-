package com.example.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

/**
 * MyBatis 工具类
 * 用于获取 SqlSession 实例
 */
public class MyBatisUtil {

    private static SqlSessionFactory sqlSessionFactory;

    // 静态代码块，初始化 SqlSessionFactory（只执行一次）
    static {
        try {
            // 读取 MyBatis 配置文件
            String resource = "mybatis-config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            // 创建 SqlSessionFactory
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("初始化 SqlSessionFactory 失败", e);
        }
    }

    /**
     * 获取 SqlSession 实例
     * @return SqlSession
     */
    public static SqlSession getSqlSession() {
        return sqlSessionFactory.openSession();
    }

    /**
     * 获取 SqlSession 实例
     * @param autoCommit 是否自动提交事务
     * @return SqlSession
     */
    public static SqlSession getSqlSession(boolean autoCommit) {
        return sqlSessionFactory.openSession(autoCommit);
    }
}
