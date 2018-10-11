package com.redscarf.admin;

import com.redscarf.admin.modules.sys.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;

@EnableCaching
@SpringBootApplication
@ServletComponentScan("com.redscarf.admin")
@ComponentScan(value = "com.redscarf.admin",lazyInit = true)
public class AdminWebApplication {
    private static Logger logger = LoggerFactory.getLogger(AdminWebApplication.class);

    public static void main(String[] args) {
        String applicationPath = System.getProperty("spring.config.location") == null ? "application.yml" : System.getProperty("spring.config.location");
        logger.info("默认文件为 application.yml , application Path : " + applicationPath);
        new SpringApplicationBuilder(AdminWebApplication.class).web(true).run(args);
        SystemService.printKeyLoadMessage();
    }
}
