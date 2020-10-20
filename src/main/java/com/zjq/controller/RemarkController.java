package com.zjq.controller;


import com.zjq.entity.Admin;
import com.zjq.entity.Remark;
import com.zjq.entity.Search;
import com.zjq.service.RemarkService;
import com.zjq.utils.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class RemarkController {
    @Autowired
    private RemarkService remarkService;

    /**
     * 新增评论
     * @param remark
     * @return
     */
    @RequestMapping("/insRemark")
    @ResponseBody
    public ResultUtil insRemark(Remark remark, HttpSession session) {
        Admin admin = (Admin)session.getAttribute("admin");
        if(admin==null){
            return ResultUtil.error("登录后才可操作！");
        }else{
            remark.setUserId(admin.getId());
            remarkService.insRemark(remark);
            return ResultUtil.ok();
        }
    }
    /**
     * 通过Id删除笔记
     * @param remarkId
     * @return
     */
    @RequestMapping("/admin/delRemarkById/{remarkId}")
    @ResponseBody
    public ResultUtil delRemarkById(@PathVariable("remarkId") int remarkId) {
        try {
            remarkService.delRemarkById(remarkId);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /**
     * 获取所有评论留言
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getRemarksList")
    @ResponseBody
    public ResultUtil getRemarksList(Integer page, Integer limit,Search search){
        return remarkService.getRemarksList(page,limit,search);
    }

    @RequestMapping("/admin/getSelfRemarkList")
    @ResponseBody
    public ResultUtil getSelfRemarkList(Integer page, Integer limit,Search search,HttpSession session){
        Admin admin = (Admin) session.getAttribute("admin");
        search.setUserId(admin.getId());
        return remarkService.getRemarksList(page,limit,search);
    }

    @RequestMapping("/getRemark")
    @ResponseBody
    public ResultUtil getRemark(Integer page, Integer limit, int noteId){
        return remarkService.getRemark(page,limit,noteId);
    }

    @RequestMapping("/getReply")
    @ResponseBody
    public List<Remark> getReply(int noteId){
        return remarkService.getReply(noteId);
    }

    @RequestMapping("/admin/remarkList")
    public String remarkList() {
        return "jsp/admin/remarkList";
    }

    @RequestMapping("/admin/getRemark")
    public String getSelfRemarkList() {
        return "jsp/admin/selfRemarkList";
    }

    /*************************留言模块****************************/
    @RequestMapping("/getLeaveMess")
    @ResponseBody
    public ResultUtil getRemark(Integer page, Integer limit){
        return remarkService.getLeaveMess(page,limit);
    }

    @RequestMapping("/getLeaveMessReply")
    @ResponseBody
    public List<Remark> getLeaveMessReply(){
        return remarkService.getLeaveMessReply();
    }





}
