package com.zjq.controller;

import javax.servlet.http.HttpSession;

import com.zjq.entity.Admin;
import com.zjq.service.AdminService;
import com.zjq.utils.Base64Utils;
import com.zjq.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjq.entity.Search;
import com.zjq.utils.ResultUtil;

@Controller
@RequestMapping("/admin")
public class UserController {

    @Autowired
    private AdminService adminService;

    /**
     * 检查邮箱是否存在相同，避免重复
     *
     * @param email
     * @return
     */
    @RequestMapping("/checkUserEmail/{email}")
    @ResponseBody
    public ResultUtil checkUserEmail(@PathVariable("email") String email) {
        String userEmail = Base64Utils.decode(email);
        Admin admin = adminService.getAdminByEmail(userEmail);
        if (admin != null) {
            return new ResultUtil(500, "邮箱已被注册！");
        }
        return new ResultUtil(0);
    }

    /**
     * 找回密码
     *
     * @param username
     * @param email
     * @param code
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/findPassword")
    @ResponseBody
    public ResultUtil findPassword(String username, String email, String code, String password, HttpSession session) {
        Admin admin = adminService.getAdminByUsername(username);
        try {
            if (admin.getEmail().equals(email)) {
                if (session.getAttribute("vcode") == null) {
                    return new ResultUtil(502, "验证码错误或已失效");
                } else {
                    if (session.getAttribute("vcode").toString().equals(code)) {
                        admin.setPassword(MD5Utils.md5(password));
                        adminService.updAdmin(admin);
                        return ResultUtil.ok();
                    } else {
                        return new ResultUtil(502, "验证码错误或已失效");
                    }
                }
            } else {
                return new ResultUtil(502, "用户名与邮箱不匹配");
            }
        } catch (Exception e) {
            return new ResultUtil(502, "数据库错误");
        }

    }

    /**
     * 本人邮箱确认
     *
     * @param id
     * @param email
     * @param code
     * @param session
     * @return
     */
    @RequestMapping("/confirmEmail")
    @ResponseBody
    public ResultUtil confirmEmail(int id, String email, String code, HttpSession session) {
        Admin admin = adminService.getAdminById(id);
        try {
            if (admin.getEmail().equals(email)) {
                if (session.getAttribute("vcode") == null) {
                    return new ResultUtil(502, "验证码错误或已失效");
                } else {
                    if (session.getAttribute("vcode").toString().equals(code)) {
                        return ResultUtil.ok();
                    } else {
                        return new ResultUtil(502, "验证码错误或已失效");
                    }
                }
            } else {
                return new ResultUtil(502, "邮箱不匹配");
            }
        } catch (Exception e) {
            return new ResultUtil(502, "数据库错误");
        }

    }

    /**
     * 邮箱换绑操作
     *
     * @param id
     * @param email
     * @param code
     * @param session
     * @return
     */
    @RequestMapping("/updateEmail")
    @ResponseBody
    public ResultUtil updateEmail(int id, String email, String code, HttpSession session) {
            if (session.getAttribute("vcode") == null) {
                return new ResultUtil(502, "验证码错误或已失效");
            } else {
                if (session.getAttribute("vcode").toString().equals(code)) {
                    Admin admin = (Admin) session.getAttribute("admin");
                    admin.setEmail(email);
                    session.setAttribute("admin",admin);
                    return adminService.updateEmail(id,email);
                } else {
                    return new ResultUtil(502, "验证码错误或已失效");
                }
            }
    }

    /**
     * 获取用户列表
     *
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/getAllUserList")
    @ResponseBody
    public ResultUtil getAllUserList(Integer page, Integer limit, Search search) {
        search.setIsAdmin(100);
        return adminService.getAdminsList(page, limit, search);
    }

    /**
     * 新增用户
     *
     * @param user
     * @return
     */
    @RequestMapping("/insertUser")
    @ResponseBody
    public ResultUtil insUser(Admin user, HttpSession session) {
        //防止浏览器提交
        ResultUtil result = ResultUtil.ok();
        Admin user1 = adminService.getAdminByUsername(user.getUsername());
        if (null != user1) {
            result = new ResultUtil(500, "用户名已存在，请重新填写！");
        }
        if (session.getAttribute("vcode").toString().equals(user.getCode().toString())) {
            try {
                user.setRoleId(21);
                user.setIsAdmin(100);
                adminService.insAdmin(user);
            } catch (Exception e) {
                result = new ResultUtil(502, "网络错误，请检查网络！");
            }
        } else {
            result = new ResultUtil(502, "验证码错误或已失效");
        }
        return result;
    }

    /**
     * 改变账户状态
     *
     * @param id
     * @param status
     * @return
     */
    @RequestMapping("/updateUserStatusById")
    @ResponseBody
    public ResultUtil updateStatusById(int id, int status) {
        return adminService.updateStatusById(id, status);
    }


    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    @RequestMapping("/updateUser")
    @ResponseBody
    public ResultUtil updateUser(Admin user) {
        try {
            user.setIsAdmin(100);
            user.setRoleId(21);
            adminService.updAdmin(user);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /************************************页面跳转相关************************************/
    @RequestMapping("/editUser/{id}")
    public String editUser(@PathVariable("id") int id, HttpSession session) {
        Admin user = adminService.getAdminById(id);
        session.setAttribute("user", user);
        return "jsp/user/editUser";
    }

    @RequestMapping("/userList")
    public String userList() {
        return "jsp/user/userList";
    }

    @RequestMapping("/addUser")
    public String userAdd() {
        return "jsp/user/addUser";
    }

    @RequestMapping("/forgetPass")
    public String forgetPass() {
        return "jsp/user/forgetPassword";
    }

    @RequestMapping("/replaceEmail")
    public String replaceEmail() {
        return "jsp/admin/replaceEmail";
    }

}
