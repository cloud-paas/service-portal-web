package com.ai.paas.ipaas.test;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

/**
 * Controller测试基类
 * 
 * @author lixiongcheng
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({ "/common/springmvc-servlet.xml" })
public class BaseTestController {
	
	
	
}
