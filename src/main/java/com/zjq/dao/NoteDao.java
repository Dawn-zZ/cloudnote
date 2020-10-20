package com.zjq.dao;

import com.zjq.entity.Note;
import com.zjq.entity.Search;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface NoteDao {

    int updNote(Note note);

    List<Note> getNoteList(Search search);

    List<Note> getForeNoteList(@Param("title")String title);

    List<Note> getHotNote();

    Note getNoteById(int id);

    void updateNoteCheckStatusById(@Param("id")int id, @Param("checkStatus")int checkStatus);

    void updateNoteOpenStatusById(@Param("id")int id, @Param("isOpen")int isOpen);

    void updateNoteViewNumById(@Param("id")int id, @Param("viewNum")int viewNum);

    void insNote(Note note);

    void delNoteById(int id);

    Map<String,Integer> getOpenAndCloseCount();

    Map<String,Integer> getNoteCount();

    Map<String,Integer> getViewCount();
}
