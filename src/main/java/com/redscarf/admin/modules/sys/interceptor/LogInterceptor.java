package com.redscarf.admin.modules.sys.interceptor;

import com.redscarf.admin.common.service.BaseService;
import com.redscarf.admin.common.utils.DateUtils;
import com.redscarf.admin.modules.sys.utils.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.NamedThreadLocal;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 日志拦截器
 *
 * @version 2014-8-19
 */
@Component("controllerLogInterceptor")
public class LogInterceptor extends BaseService implements HandlerInterceptor {

    private Logger logger = LoggerFactory.getLogger("controller-log");
    private static final ThreadLocal<Long> startTimeThreadLocal =
            new NamedThreadLocal<Long>("ThreadLocal StartTime");

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        startTimeThreadLocal.set(System.currentTimeMillis());
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
    }
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception {
        logger.info("URI: {},耗时：{}   ",
                request.getRequestURI(), DateUtils.formatDateTime(System.currentTimeMillis() - startTimeThreadLocal.get()));
        //删除线程变量中的数据，防止内存泄漏
        startTimeThreadLocal.remove();
        // 保存日志
        LogUtils.saveLog(request, handler, ex, null);
    }
}
