package com.zjq.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AdminFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        HttpSession session = httpServletRequest.getSession();

        if (session.getAttribute("admin")!=null && session.getAttribute("isAdmin")==null){
            // 没有登录
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/admin/tip2");
        }else {
            // 已经登录，继续请求下一级资源（继续访问）
            chain.doFilter(request,response);
        }
    }

    @Override
    public void destroy() {

    }
}
