package com.zjq.service;


import com.zjq.entity.Remark;
import com.zjq.entity.Search;
import com.zjq.utils.ResultUtil;

import java.util.List;

public interface RemarkService {

    void insRemark(Remark remark);

    ResultUtil getRemarksList(Integer page, Integer limit,Search search);

    ResultUtil getRemark(Integer page, Integer limit,int NoteId);

    List<Remark> getReply(int NoteId);

    ResultUtil getLeaveMess(Integer page, Integer limit);

    List<Remark> getLeaveMessReply();

    void delRemarkById(int remarkId);
}
