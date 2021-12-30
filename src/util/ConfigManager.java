package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

//采用单例模式
public class ConfigManager {
    //2.提供静态的私有对象（自身）
    private static ConfigManager configManager;// = new ConfigManager();饿汉模式 线程安全模式
    private Properties p ;//配置属性对象 -- 静态好处 共享
    //1. 私有构造函数 --
    private ConfigManager(){
        //读取 数据库配置文件的内容
        String path = "database.properties";
        p = new Properties();
        //以 输入流的 方式 读取到 配置信息
        InputStream is = ConfigManager.class.getClassLoader().getResourceAsStream(path);
        try {
            p.load(is);//将流的 内容 加载到 Properties 对象中
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //3.自己创建实例--公开的静态方法 : 有且仅有1个ConfigManager对象
    public static synchronized ConfigManager getInstance(){
        //懒加载 : 线程不安全的模式 -- 同步
        if (configManager == null){
            configManager = new ConfigManager();
        }
        return configManager;
    }

    //4.提供公开的 方法 输出value值
    public String getProperties(String key){
        return p.getProperty(key);
    }
}
