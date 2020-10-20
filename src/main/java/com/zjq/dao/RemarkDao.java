package com.zjq.dao;

import com.zjq.entity.Remark;
import com.zjq.entity.Search;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RemarkDao {

    void insRemark(Remark remark);

    List<Remark> getRemarksList(Search search);

    List<Remark> getLeaveMess();

    List<Remark> getRemark(@Param("noteId")int noteId);

    void delRemarkById(int remarkId);
}
