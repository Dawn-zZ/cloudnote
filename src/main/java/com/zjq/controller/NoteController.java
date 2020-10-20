package com.zjq.controller;

import com.zjq.dao.NoteDao;
import com.zjq.entity.Admin;
import com.zjq.entity.Note;
import com.zjq.entity.Remark;
import com.zjq.entity.Search;
import com.zjq.service.AdminService;
import com.zjq.service.NoteService;
import com.zjq.service.RemarkService;
import com.zjq.utils.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class NoteController {
    @Autowired
    private NoteService noteService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private RemarkService remarkService;

    /**
     * 更新笔记
     * @param note
     * @return
     */
    @RequestMapping("/admin/updateNote")
    @ResponseBody
    public ResultUtil updateNote(Note note){
        try{
            noteService.updNote(note);
            return ResultUtil.ok();
        }catch (Exception e){
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /**
     * 管理员获取所有公开笔记列表，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getNoteList")
    @ResponseBody
    public ResultUtil adminGetNoteList(Integer page, Integer limit, Search search){
        search.setIsOpen(101);//只获取用户公开的笔记
        search.setUploadStatus(101);//不获取用户草稿
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 管理员获取待审核笔记列表，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/checkNoteList")
    @ResponseBody
    public ResultUtil checkNoteList(Integer page, Integer limit, Search search){
        search.setIsOpen(101);//只获取用户公开的笔记
        search.setUploadStatus(101);//不获取用户草稿
        search.setCheckStatus(100);//只获取未审核的
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 用户获取自己所有公开笔记，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getUserNoteList")
    @ResponseBody
    public ResultUtil getNoteList(Integer page, Integer limit, Search search,HttpSession session){
        Admin admin = (Admin)session.getAttribute("admin");
        search.setIsOpen(101);//公开笔记
        search.setUserId(admin.getId());//查询条件设置为自身（登陆用户）
        System.out.println("****************************************"+search.getNoteTitle());
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 用户获取自己所有待审核笔记，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getNotCheckNoteList")
    @ResponseBody
    public ResultUtil getNotCheckNoteList(Integer page, Integer limit, Search search,HttpSession session){
        Admin admin = (Admin)session.getAttribute("admin");
        search.setIsOpen(101);//公开笔记
        search.setCheckStatus(100);//未审核状态
        search.setUserId(admin.getId());//查询条件设置为自身（登陆用户）
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 用户获取自己所有私密笔记，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getSMNoteList")
    @ResponseBody
    public ResultUtil getSMNoteList(Integer page, Integer limit, Search search,HttpSession session){
        Admin admin = (Admin)session.getAttribute("admin");
        search.setIsOpen(100);//私密状态
        search.setUserId(admin.getId());//查询条件设置为自身（登陆用户）
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 用户获取自己所有草稿，带分页
     * @param page
     * @param limit
     * @param search
     * @return
     */
    @RequestMapping("/admin/getCGNoteList")
    @ResponseBody
    public ResultUtil getCGNoteList(Integer page, Integer limit, Search search,HttpSession session){
        Admin admin = (Admin)session.getAttribute("admin");
        search.setUploadStatus(100);//草稿状态
        search.setUserId(admin.getId());//查询条件设置为自身（登陆用户）
        return noteService.getNoteList(page, limit, search);
    }

    /**
     * 更新笔记公开状态
     * @param id
     * @param checkStatus
     * @return
     */
    @RequestMapping("/admin/updateNoteCheckStatusById")
    @ResponseBody
    public ResultUtil updateNoteCheckStatusById(int id, int checkStatus) {
        return noteService.updateNoteCheckStatusById(id, checkStatus);
    }

    /**
     * 更新笔记审核状态
     * @param id
     * @param isOpen
     * @return
     */
    @RequestMapping("/admin/updateNoteOpenStatusById")
    @ResponseBody
    public ResultUtil updateNoteOpenStatusById(int id, int isOpen) {
        return noteService.updateNoteOpenStatusById(id, isOpen);
    }

    /**
     * 新增笔记
     * @param note
     * @return
     */
    @RequestMapping("/admin/insNote")
    @ResponseBody
    public ResultUtil insNote(Note note,HttpSession session) {
        Admin admin = (Admin)session.getAttribute("admin");
        note.setUserId(admin.getId());
        noteService.insNote(note);
        return ResultUtil.ok();
    }

    /**
     * 通过Id删除笔记
     * @param id
     * @return
     */
    @RequestMapping("/admin/delNoteById/{id}")
    @ResponseBody
    public ResultUtil delNoteById(@PathVariable("id") int id) {
        try {
            noteService.delNoteById(id);
            return ResultUtil.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return ResultUtil.error();
        }
    }

    /************************************页面跳转相关************************************/

    @RequestMapping("/admin/noteList")
    public String noteList() {
        return "jsp/note/noteList";
    }

    @RequestMapping("/admin/checkNote")
    public String checkNote() {
        return "jsp/note/checkNoteList";
    }

    @RequestMapping("/admin/sMNote")
    public String sMNote() {
        return "jsp/note/userSMNote";
    }

    @RequestMapping("/admin/cGNote")
    public String cGNote() {
        return "jsp/note/userCGNote";
    }

    @RequestMapping("/admin/userNoteList")
    public String userNoteList() {
        return "jsp/note/userNote";
    }

    @RequestMapping("/admin/addNote")
    public String addNote() {
        return "jsp/note/addNote";
    }

    @RequestMapping("/admin/editNote/{id}")
    public String editNote(HttpServletRequest req,@PathVariable("id") int id){
        Note note = noteService.getNoteById(id);
        req.setAttribute("note",note);
        return "jsp/note/editNote";
    }

    @RequestMapping("/admin/showNote/{id}")
    public String showNote(HttpServletRequest req,@PathVariable("id") int id){
        Note note = noteService.getNoteById(id);
        Admin ad = adminService.getAdminById(note.getUserId());
        note.setAuthor(ad.getNickname());
        req.setAttribute("note",note);
        return "jsp/note/showNote";
    }

    /***************************************网站前台***********************************************/

    @RequestMapping("/note")
    @ResponseBody
    public ResultUtil note(Integer page, Integer limit, String title){
        return noteService.getForeNoteList(page, limit, title);
    }
    @RequestMapping("/noteList")
    public String getNote(){
        return "jsp/fore/noteList";
    }

    @RequestMapping("/updateNoteViewNumById")
    @ResponseBody
    public ResultUtil updateNoteViewNumById(int id, int viewNum) {
        return noteService.updateNoteViewNumById(id, viewNum);
    }

    @RequestMapping("/getHotNote")
    @ResponseBody
    public List<Note> getHotNote() {
        return noteService.getHotNote();
    }

    @RequestMapping("/detail/{id}")
    public String detail(HttpServletRequest req,@PathVariable("id") int id){
        Search search = new Search();
        Note note = noteService.getNoteById(id);
        Admin ad = adminService.getAdminById(note.getUserId());
        List<Admin> ads = adminService.getAdminsList(search);
        note.setAuthor(ad.getNickname());
        req.setAttribute("ad",ads);
        req.setAttribute("note",note);
        return "jsp/fore/detail";
    }

    @RequestMapping("/home")
    public String home(){
        return "jsp/fore/home";
    }

    @RequestMapping("/about")
    public String about(){
        return "jsp/fore/about";
    }

    @RequestMapping("/leavemessage")
    public String leavemessage(){
        return "jsp/fore/leavemess";
    }

    @RequestMapping("/admin/person")
    public String person(){
        return "jsp/fore/person";
    }
}
