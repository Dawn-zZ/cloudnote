package com.zjq.controller;

import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjq.utils.SendMailUtil;

@Controller
public class SendEmailController {


    @Autowired
    private SendMailUtil sendMailUtil;

    @RequestMapping("/code")
    @ResponseBody
    public int sendEmail(String email, HttpSession session) {

        String code = "";
        //判断是否是同一邮箱三分钟内重复提交
        if (session.getAttribute("email") != null) {
            if (email.equals(session.getAttribute("email").toString()) && session.getAttribute("vcode") != null) {
                code = session.getAttribute("vcode").toString();//不产生新的验证码
            } else {
                //随机产生验证码
                Random rd = new Random();
                while (code.length() < 6) {
                    code += rd.nextInt(10);
                }
            }
        } else if (session.getAttribute("vcode") == null && session.getAttribute("email") == null) {
            //随机产生验证码
            Random rd = new Random();
            while (code.length() < 6) {
                code += rd.nextInt(10);
            }
        } else {
            code = session.getAttribute("vcode").toString();
        }
        //如果验证码发送成功
        if (sendMailUtil.sendHtmlMail(email, "吾悦用户", code)) {
            session.setAttribute("vcode", code);
            session.setAttribute("email", email);

            //创建TimerTask用来三分钟之后移出vcode
            TimerTask task = new TimerTask() {

                @Override
                public void run() {
                    session.removeAttribute("vcode");
                    session.removeAttribute("email");
                }
            };

            //实例化这个task任务
            Timer timer = new Timer();
            timer.schedule(task, 180000);//三分钟之后执行task任务
            return 1;
        }

        return 0;
    }
}
