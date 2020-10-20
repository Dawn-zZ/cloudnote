package com.zjq.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjq.dao.AdminDao;
import com.zjq.dao.NoteDao;
import com.zjq.entity.Admin;
import com.zjq.entity.Note;
import com.zjq.entity.Search;
import com.zjq.utils.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zjq.service.NoteService;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class NoteServiceImpl implements NoteService {

    @Autowired
    NoteDao noteDao;

    @Autowired
    AdminDao adminDao;

    @Override
    public void updNote(Note note) {
        noteDao.updNote(note);
    }

    @Override
    public ResultUtil getNoteList(Integer page, Integer limit, Search search) {
        PageHelper.startPage(page, limit);
        List<Note> notes = noteDao.getNoteList(search);
        for(Note note : notes) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(note.getUserId() == admin.getId()) {
                    note.setAuthor(admin.getNickname());
                }
            }
        }
        PageInfo<Note> pageInfo = new PageInfo<Note>(notes);
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(pageInfo.getTotal());
        resultUtil.setData(pageInfo.getList());
        return resultUtil;
    }

    @Override
    public ResultUtil getForeNoteList(Integer page, Integer limit, String title) {
        Search search = new Search();
        PageHelper.startPage(page, limit);
        List<Note> notes = noteDao.getForeNoteList(title);
        for(Note note : notes) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(note.getUserId() == admin.getId()) {
                    note.setAuthor(admin.getNickname());
                }
            }
        }
        PageInfo<Note> pageInfo = new PageInfo<Note>(notes);
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(pageInfo.getTotal());
        resultUtil.setData(pageInfo.getList());
        return resultUtil;
    }

    @Override
    public List<Note> getHotNote() {
        Search search = new Search();
        List<Note> notes = noteDao.getHotNote();
        for(Note note : notes) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(note.getUserId() == admin.getId()) {
                    note.setAuthor(admin.getNickname());
                }
            }
        }
        return notes;
    }


    @Override
    public Note getNoteById(int id) {
        return noteDao.getNoteById(id);
    }

    @Override
    public ResultUtil updateNoteCheckStatusById(int id, int checkStstus) {
        noteDao.updateNoteCheckStatusById(id, checkStstus);
        return ResultUtil.ok();
    }

    @Override
    public ResultUtil updateNoteOpenStatusById(int id, int isOpen) {
        noteDao.updateNoteOpenStatusById(id, isOpen);
        return ResultUtil.ok();
    }

    @Override
    public ResultUtil updateNoteViewNumById(int id, int viewNum) {
        noteDao.updateNoteViewNumById(id, viewNum);
        return ResultUtil.ok();
    }

    @Override
    public void insNote(Note note) {
        note.setCreateTime(new Date());
        noteDao.insNote(note);
    }

    @Override
    public void delNoteById(int id) {
        noteDao.delNoteById(id);
    }

    @Override
    public Map<String, Integer> getOpenAndCloseCount() {
        return noteDao.getOpenAndCloseCount();
    }

    @Override
    public Map<String, Integer> getNoteCount() {
        return noteDao.getNoteCount();
    }

    @Override
    public Map<String, Integer> getViewCount() {
        return noteDao.getViewCount();
    }

}
