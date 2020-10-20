package com.zjq.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.zjq.entity.Search;
import com.zjq.service.NoteService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjq.entity.Admin;
import com.zjq.entity.Menu;
import com.zjq.entity.Role;
import com.zjq.service.AdminService;
import com.zjq.utils.GsonUtil;
import com.zjq.utils.MD5Utils;
import com.zjq.utils.ResultUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private NoteService noteService;


    /************************************登录相关************************************/
    /**
     * 跳转登录
     *
     * @param session
     * @return
     */
    @RequestMapping("/login")
    public String login(HttpSession session) {

        if (session.getAttribute("admin") != null) {
            return "redirect:/home";
        } else {
            return "redirect:/login.jsp";
        }
    }

    /**
     * 处理登录请求
     *
     * @param username
     * @param password
     * @param request
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("/checkLogin")
    @ResponseBody
    public ResultUtil login(String username, String password, HttpServletRequest request, HttpSession session)
            throws ParseException {
        Admin admin = adminService.login(username, password);
        if (null != admin) {
            if (admin.getStatus() == 100) {
                return new ResultUtil(-1, "此账号被禁用，请联系管理员");
            } else {
                session.setAttribute("admin", admin);
                if (admin.getIsAdmin() == 101) {
                    session.setAttribute("isAdmin", admin);
                }
                String loginIp = request.getHeader("x-forwarded-for");
                if (loginIp == null || loginIp.length() == 0 || "unknown".equalsIgnoreCase(loginIp)) {
                    loginIp = request.getHeader("Proxy-Client-IP");
                }
                if (loginIp == null || loginIp.length() == 0 || "unknown".equalsIgnoreCase(loginIp)) {
                    loginIp = request.getHeader("WL-Proxy-Client-IP");
                }
                if (loginIp == null || loginIp.length() == 0 || "unknown".equalsIgnoreCase(loginIp)) {
                    loginIp = request.getHeader("HTTP_CLIENT_IP");
                }
                if (loginIp == null || loginIp.length() == 0 || "unknown".equalsIgnoreCase(loginIp)) {
                    loginIp = request.getHeader("HTTP_X_FORWARDED_FOR");
                }
                if (loginIp == null || loginIp.length() == 0 || "unknown".equalsIgnoreCase(loginIp)) {
                    loginIp = request.getRemoteAddr();
                }
                Date date = new Date();// 获得系统时间.
                SimpleDateFormat sdf = new SimpleDateFormat(" yyyy-MM-dd HH:mm:ss ");
                String nowTime = sdf.format(date);
                Date loginTime = sdf.parse(nowTime);
                Admin admins = adminService.getAdminByUsername(username);
                int roleId = admins.getRoleId();
                adminService.insAdminLog(username, loginIp, loginTime, roleId);
                return ResultUtil.ok(admin.getId());
            }

        } else {
            return ResultUtil.error();
        }
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.invalidate();
        return "redirect:/home";
    }

    /************************************Admin相关************************************/

    /**
     * 更新个人信息
     *
     * @param admin
     * @return
     */
    @RequestMapping("/updateAdmin")
    @ResponseBody
    public ResultUtil updateAdmin(Admin admin, HttpSession session) {
        try {
            adminService.updAdmin(admin);
            session.setAttribute("admin", admin);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /**
     * 更新管理员列表上的管理员信息
     *
     * @param admin
     * @return
     */
    @RequestMapping("/updAdmin")
    @ResponseBody
    public ResultUtil updAdmin(Admin admin) {
        if (admin != null && admin.getId() == 1) {
            return ResultUtil.error("不允许修改!");
        }
        try {
            admin.setIsAdmin(101);
            admin.setStatus(101);
            adminService.updAdmin(admin);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /**
     * 修改登录密码
     *
     * @param oldPassword
     * @param newPassword1
     * @param username
     * @return
     */
    @RequestMapping("/changeAdminPassword")
    @ResponseBody
    public ResultUtil changeAdminPassword(String oldPassword, String newPassword1, String username, HttpSession session) {
        Admin admin = adminService.getAdminByUsername(username);
        if (admin != null) {
            if (admin.getPassword().equals(MD5Utils.md5(oldPassword))) {
                admin.setPassword(MD5Utils.md5(newPassword1));
                adminService.updAdmin(admin);
                session.removeAttribute("admin");
                return ResultUtil.ok();
            } else {
                return new ResultUtil(501, "旧密码错误，请重新填写！");
            }
        }
        return new ResultUtil(500, "请求错误！");
    }

    /**
     * 获取所有管理员列表，带分页
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/getAdminList")
    @ResponseBody
    public ResultUtil getAdminList(Integer page, Integer limit, Search search) {
        search.setIsAdmin(101);
        return adminService.getAdminsList(page, limit, search);
    }

    /**
     * 检查登录名是否相同，避免重复
     *
     * @param username
     * @return
     */
    @RequestMapping("/checkAdminName/{username}")
    @ResponseBody
    public ResultUtil checkAdminName(@PathVariable("username") String username) {
        Admin admin = adminService.getAdminByUsername(username);
        if (admin != null) {
            return new ResultUtil(500, "用户名已存在！");
        }
        return new ResultUtil(0);
    }


    /**
     * 增加管理员
     *
     * @param admin
     * @return
     */
    @RequestMapping("/insAdmin")
    @ResponseBody
    public ResultUtil insAdmin(Admin admin) {
        Admin a = adminService.getAdminByUsername(admin.getUsername());
        if (a != null) {
            return new ResultUtil(500, "用户名已存在,请重试！");
        }
        admin.setIsAdmin(101);
        adminService.insAdmin(admin);
        return ResultUtil.ok();
    }

    /**
     * 通过Id删除管理员
     *
     * @param id
     * @return
     */
    @RequestMapping("/delAdminById/{id}")
    @ResponseBody
    public ResultUtil delAdminById(@PathVariable("id") int id) {
        if (id == 1) {
            return ResultUtil.error();
        }
        try {
            adminService.delAdminById(id);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /************************************AdminLog相关************************************/
    /**
     * 获取所有人登录日志
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/getAdminLogList")
    @ResponseBody
    public ResultUtil getAdminLogList(Integer page, Integer limit) {
        return adminService.getAdminLogsList(page, limit);
    }

    /************************************Role相关************************************/
    /**
     * 获取所有角色列表，带分页
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/getRoleList")
    @ResponseBody
    public ResultUtil getRoleList(Integer page, Integer limit) {
        return adminService.getRoles(page, limit);
    }

    /**
     * 增加角色
     *
     * @param role
     * @param m
     * @return
     */
    @RequestMapping("/insRole")
    @ResponseBody
    public ResultUtil insertRole(Role role, String m) {
        Role r = adminService.getRoleByRoleName(role.getRoleName());
        if (r != null) {
            return new ResultUtil(500, "角色名已存在,请重试！");
        }
        //角色信息保存
        adminService.insRole(role, m);
        return ResultUtil.ok();
    }

    /**
     * 检查用户名是否重复
     *
     * @param roleName
     * @param roleId
     * @return
     */
    @RequestMapping("/checkRoleName")
    @ResponseBody
    public ResultUtil checkRoleName(String roleName, Long roleId) {
        Role role = adminService.getRoleByRoleName(roleName);
        if (role == null) {
            return new ResultUtil(0);
        } else if (role.getRoleId() == roleId) {
            return new ResultUtil(0);
        } else {
            return new ResultUtil(500, "角色名已存在！");
        }
    }

    /**
     * 更新角色
     *
     * @param role
     * @param m
     */
    @RequestMapping("/updateRole")
    @ResponseBody
    public void updRole(Role role, String m) {
        //角色信息保存
        adminService.updRole(role, m);
    }

    /**
     * 删除角色
     *
     * @param roleId
     * @return
     */
    @RequestMapping("/delRole/{roleId}")
    @ResponseBody
    public ResultUtil delRole(@PathVariable("roleId") int roleId) {
        ResultUtil resultUtil = new ResultUtil();
        try {
            adminService.delRole(roleId);
            resultUtil.setCode(0);
        } catch (Exception e) {
            resultUtil.setCode(500);
            e.printStackTrace();
        }
        return resultUtil;
    }

    /**
     * 得到指定角色权限树
     *
     * @param roleId
     * @return
     */
    @RequestMapping(value = "/xtreedata", produces = {"text/json;charset=UTF-8"})
    @ResponseBody
    public String xtreeData(@RequestParam(value = "roleId", defaultValue = "-1") int roleId) {
        Admin admin = new Admin();
        admin.setRoleId(roleId);
        return GsonUtil.entityToJson(adminService.getXtreeData(admin));
    }

    /************************************Menu相关************************************/

    /**
     * 获取所有菜单
     *
     * @return
     */
    @RequestMapping("/menuData")
    @ResponseBody
    public ResultUtil menuData() {
        List<Menu> list = adminService.getAllMenus();
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(list.size() + 0L);
        resultUtil.setData(list);
        return resultUtil;
    }

    /**
     * 获取登录人员对应的菜单，用于加载后台首页
     *
     * @param session
     * @return
     */
    @RequestMapping("/getMenus")
    @ResponseBody
    public List<Menu> getMenus(HttpSession session) {
        Admin mAdmin = (Admin) session.getAttribute("admin");
        Admin admin = adminService.getAdminById(mAdmin.getId());
        List<Menu> menus = null;
        if (null != admin) {
            menus = adminService.getMenus(admin);
        }
        return menus;
    }

    /**
     * 通过Id更新菜单排序
     *
     * @param menuId
     * @param sorting
     * @return
     */
    @RequestMapping("/updMenuSortingById")
    @ResponseBody
    public ResultUtil updMenuSortingById(int menuId, String sorting) {
        Menu menu = new Menu();
        menu.setMenuId(menuId);
        try {
            Long.parseLong(sorting);
        } catch (NumberFormatException e) {
            return ResultUtil.error("修改失败，只允许输入整数！");
        }
        menu.setSorting(Integer.parseInt(sorting));
        adminService.updMenuSortingById(menu);
        return ResultUtil.ok();
    }

    /**
     * 点击新增菜单后的操作，跳转页面
     *
     * @param menuId
     * @param model
     * @return
     */
    @RequestMapping("/toSaveMenu/{menuId}")
    public String toSaveMenu(@PathVariable("menuId") int menuId, Model model) {
        if (menuId != 1) {
            Menu menus = new Menu();
            menus.setMenuId(menuId);
            model.addAttribute("menu", menus);
            model.addAttribute("flag", "1");
            return "jsp/menu/menuForm";
        } else {
            model.addAttribute("msg", "不允许操作！");
            return "jsp/active";
        }
    }

    /**
     * 点击编辑菜单后的操作，跳转页面
     *
     * @param menuId
     * @param model
     * @return
     */
    @RequestMapping("/toEditMenu/{menuId}")
    public String toEditMenu(@PathVariable("menuId") int menuId, Model model) {
        if (menuId != 0 && menuId != 1) {
            Menu menus = adminService.getMenuById(menuId);
            model.addAttribute("menu", menus);
            return "jsp/menu/menuForm";
        } else if (menuId == 1) {
            model.addAttribute("msg", "不允许操作此菜单！");
            return "jsp/active";
        } else {
            model.addAttribute("msg", "不允许操作！");
            return "jsp/active";
        }
    }

    /**
     * 根据id删除菜单
     *
     * @param menuId
     * @return
     */
    @RequestMapping("/delMenuById/{menuId}")
    @ResponseBody
    public ResultUtil delMenuById(@PathVariable("menuId") int menuId) {
        try {
            if (menuId == 1) {
                return ResultUtil.error("此菜单不允许删除！");
            }
            //查询是否有子菜单，不允许删除
            List<Menu> data = adminService.getMenusByParentId(menuId);
            if (data != null && data.size() > 0) {
                return ResultUtil.error("包含子菜单，不允许删除！");
            }
            adminService.delMenuById(menuId);
            return ResultUtil.ok("删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error("系统错误！");
        }
    }

    /**
     * 维护菜单信息
     *
     * @param menus
     * @param flag
     * @return
     */
    @RequestMapping("/menuForm")
    @ResponseBody
    public ResultUtil menuForm(Menu menus, String flag) {
        if (StringUtils.isBlank(flag)) {
            //同级菜单名不相同
            List<Menu> data = adminService.checkNameSameLevel(menus);
            Menu m = adminService.getMenuById(menus.getMenuId());
            Boolean f = false;
            if (m.getName().equals(menus.getName()) || data.size() == 0) {
                f = true;
            }
            if (!f || data.size() > 1) {
                return ResultUtil.error("同级菜单名不能相同！");
            }
            menus.setSpread("false");
            adminService.updMenu(menus);
            return ResultUtil.ok("修改成功！");
        } else if (menus.getMenuId() != 1) {
            menus.setParentId(menus.getMenuId());

            //规定只能3级菜单
            Menu m = adminService.getMenuById(menus.getMenuId());
            if (m != null && m.getParentId() != 0) {
                Menu m1 = adminService.getMenuById(m.getParentId());
                if (m1 != null && m1.getParentId() != 0) {
                    return ResultUtil.error("此菜单不允许添加子菜单！");
                }
            }

            //同级菜单名不相同
            List<Menu> data = adminService.checkNameSameLevel(menus);
            if (data.size() > 0) {
                return ResultUtil.error("同级菜单名不能相同！");
            }

            menus.setMenuId(0);
            menus.setSpread("false");
            adminService.insMenu(menus);
            return ResultUtil.ok("添加成功！");
        } else {
            return ResultUtil.error("此菜单不允许操作！");
        }
    }

    /************************************页面跳转相关************************************/

    @RequestMapping("/personalData")
    public String personalDate(HttpSession session) {
        return "jsp/admin/personalInfo";
    }

    @RequestMapping("/updateInfo")
    public String updateInfo() {
        return "jsp/admin/updateInfo";
    }

    @RequestMapping("/tip")
    public String tip() {
        return "/jsp/temp";
    }

    @RequestMapping("/tip2")
    public String tip2() {
        return "/jsp/temp2";
    }

    @RequestMapping("/index")
    public String index() {
        return "/jsp/index";
    }

    @RequestMapping("/changePassword")
    public String changePassword() {
        return "jsp/admin/changePassword";
    }

    @RequestMapping("/main")
    public String getMain() {
        return "jsp/main";
    }

    @RequestMapping("/adminLoginLog")
    public String adminLoginLog() {
        return "jsp/admin/adminLogList";
    }

    @RequestMapping("/roleList")
    public String roleList() {
        return "jsp/role/roleList";
    }

    @RequestMapping("/editRole")
    public String editRole(Role role, Model model) {
        role = adminService.getRoleById(role.getRoleId());
        model.addAttribute("role", role);
        return "jsp/role/editRole";
    }

    @RequestMapping("/addRole")
    public String addRole() {
        return "jsp/role/addRole";
    }

    @RequestMapping("/addAdmin")
    public String addAdmin(HttpSession session) {
        List<Role> roles = adminService.getRoles();
        session.setAttribute("roles", roles);
        return "jsp/admin/addAdmin";
    }

    @RequestMapping("/editAdmin/{id}")
    public String editAdmin(HttpServletRequest req, @PathVariable("id") int id) {
        Admin ad = adminService.getAdminById(id);
        List<Role> roles = adminService.getRoles();
        req.setAttribute("ad", ad);
        req.setAttribute("roles", roles);
        return "jsp/admin/editAdmin";
    }

    @RequestMapping("/adminList")
    public String adminList() {
        return "jsp/admin/adminList";
    }

    @RequestMapping("/menuList")
    public String menuList() {
        return "jsp/menu/menuList";
    }

    //可视化数据
    @RequestMapping("/getData")
    public String getCount(HttpServletRequest req) {
        Map<String, Integer> map = noteService.getOpenAndCloseCount();
        Map<String, Integer> notenum = noteService.getNoteCount();
        Map<String, Integer> usernum = adminService.getUserCount();
        Map<String, Integer> lognum = adminService.getLogCount();
        Map<String, Integer> viewnum = noteService.getViewCount();
        map.putAll(notenum);
        map.putAll(usernum);
        map.putAll(lognum);
        map.putAll(viewnum);
        req.setAttribute("data", map);
        return "jsp/admin/data";
    }

}
