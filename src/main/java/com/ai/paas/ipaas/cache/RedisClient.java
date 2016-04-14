package com.ai.paas.ipaas.cache;

import java.util.List;
import java.util.ResourceBundle;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import com.ai.paas.ipaas.config.controller.ConfigController;
import com.ai.paas.ipaas.utils.ConfigUtil;
import com.alibaba.fastjson.JSON;

public class RedisClient {
	
	private static final Logger logger = LogManager
			.getLogger(RedisClient.class.getName());

    public static JedisPool jedisPool;// 池化管理jedis链接池

    static {
        // 读取相关的配置
        int maxActive = ConfigUtil.getIntProperty("redis.pool.maxActive");
        int maxIdle = ConfigUtil.getIntProperty("redis.pool.maxIdle");
        int maxWait = ConfigUtil.getIntProperty("redis.pool.maxWait");
        String ip = ConfigUtil.getProperty("redis.ip");
        int port = ConfigUtil.getIntProperty("redis.port");
        JedisPoolConfig config = new JedisPoolConfig();
        System.out.println("===================我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去===============================");
        System.out.println(ip);
        logger.info("===================我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去我欲乘风归去===============================");
        logger.info(ip);
        // 设置最大连接数
        config.setMaxTotal(maxActive);
        // 设置最大空闲数
        config.setMaxIdle(maxIdle);
        // 设置超时时间
        config.setMaxWaitMillis(maxWait);

        // 初始化连接池
        jedisPool = new JedisPool(config, ip, port);
    }

    public static void set4Json(String key, Object object) {
        load(key.getBytes(), JSON.toJSONBytes(object));
    }

    public static void set4Serial(String key, Object object) {
        load(key.getBytes(), SerializeUtil.serialize(object));
    }

    private static void load(byte[] key, byte[] data) {
        Jedis jedis = getJedis("加载");
        if (jedis != null) {
            try {
                jedis.set(key, data);
            } catch (Exception ex) {
            } finally {
                close(jedis);
            }
        }
    }

    public static Object get4Json(String key) {
        byte[] data = get(key.getBytes());
        if (data != null && data.length > 0) {
            return JSON.parse(data);
        }
        return null;
    }

    public static Object get4Serial(String key) {
        byte[] data = get(key.getBytes());
        if (data != null && data.length > 0) {
            return SerializeUtil.unserialize(data);
        }
        return null;
    }

    private static byte[] get(byte[] key) {
        Jedis jedis = getJedis("读取");
        if (jedis != null) {
            try {
                return jedis.get(key);
            } catch (Exception ex) {
            } finally {
                close(jedis);
            }
        }
        return null;
    }

    public static void del(String key) {
        Jedis jedis = getJedis("删除");
        if (jedis != null) {
            try {
                jedis.del(key.getBytes());
            } catch (Exception ex) {
            } finally {
                close(jedis);
            }
        }
    }

    public void expire(String key, int seconds) {
        Jedis jedis = getJedis("过期时间");
        if (jedis != null) {
            jedis.expire(key, seconds);
            close(jedis);
        }
    }

    public void flush() {
        Jedis jedis = getJedis("刷新");
        if (jedis != null) {
            try {
                jedis.flushAll();
            } catch (Exception ex) {
            } finally {
                close(jedis);
            }
        }
    }

    private static Jedis getJedis(String method) {
        try {
            Jedis jedis = jedisPool.getResource();
            jedis.connect();
            return jedis;
            
        } catch (Exception e) {
            try {
                throw new Exception(method + "缓存出错: REDIS连接失败", e);
            } catch (Exception e1) {
                e1.printStackTrace();
            }
        }
        return null;
    }

    public static void close(Jedis jedis) {
        if (jedis != null && jedis.isConnected()) {
            try {
                jedis.quit();
            } catch (Exception ex) {
            }
            jedis.disconnect();
        }
    }

public static void main(String[] args){
		
		List<CodeValueObject> list1;
		for(int i=0; i< 2; i++){
			System.out.println("==============="+i);
			list1 = CacheUtils.getCodeValueListByKey("WORKFLOW.URL_PREFIX");
			System.out.println("vmCPULoading...list1>>>>:"+list1);
		}
}

    
    
    
//    public static void main(String[] args) throws Exception {
//        String key = "s";
//        RedisClient.set4Json(key, "test");
//        System.out.println(RedisClient.get4Json(key));
//        RedisClient.set4Json(key, "test2");
//        System.out.println(RedisClient.get4Json(key));
//        RedisClient.del(key);
//        System.out.println(RedisClient.get4Json(key));
//    }
}