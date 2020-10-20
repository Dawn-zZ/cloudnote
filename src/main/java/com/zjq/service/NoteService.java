package com.zjq.service;

import com.zjq.entity.Note;
import com.zjq.entity.Search;
import com.zjq.utils.ResultUtil;

import java.util.List;
import java.util.Map;

public interface NoteService {

    void updNote(Note note);

    ResultUtil getNoteList(Integer page, Integer limit, Search search);

    ResultUtil getForeNoteList(Integer page, Integer limit,String title);

    List<Note> getHotNote();

    Note getNoteById(int id);

    ResultUtil updateNoteCheckStatusById(int id, int checkStatus);

    ResultUtil updateNoteOpenStatusById(int id,int isOpen);

    ResultUtil updateNoteViewNumById(int id,int viewNum);

    void insNote(Note note);

    void delNoteById(int id);

    Map<String,Integer> getOpenAndCloseCount();

    Map<String,Integer> getNoteCount();

    Map<String,Integer> getViewCount();

}
