package com.ai.paas.ipaas.storm.demo.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.storm.sys.BaseController;

@Controller
@RequestMapping(value = "/storm/demo")
public class StormDemoController extends BaseController {
	private static final Logger logger = LogManager.getLogger(StormDemoController.class.getName());
	
}
