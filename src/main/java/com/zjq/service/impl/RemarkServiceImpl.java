package com.zjq.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjq.dao.AdminDao;
import com.zjq.dao.RemarkDao;
import com.zjq.entity.Admin;
import com.zjq.entity.Remark;
import com.zjq.entity.Search;
import com.zjq.service.RemarkService;
import com.zjq.utils.ResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class RemarkServiceImpl implements RemarkService {

    @Autowired
    RemarkDao remarkDao;

    @Autowired
    AdminDao adminDao;

    @Override
    public void insRemark(Remark remark) {
        remark.setCreateTime(new Date());
        remarkDao.insRemark(remark);
    }

    @Override
    public ResultUtil getRemarksList(Integer page, Integer limit,Search search) {
        PageHelper.startPage(page, limit);
        List<Remark> remarks = remarkDao.getRemarksList(search);
        for(Remark remark : remarks) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(remark.getUserId() == admin.getId()) {
                    remark.setImage(admin.getImage());
                    remark.setNickname(admin.getNickname());
                }
            }
        }
        PageInfo<Remark> pageInfo = new PageInfo<Remark>(remarks);
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(pageInfo.getTotal());
        resultUtil.setData(pageInfo.getList());
        return resultUtil;
    }

    @Override
    public ResultUtil getRemark(Integer page, Integer limit, int NoteId) {
        PageHelper.startPage(page, limit);
        Search search = new Search();
        List<Remark> remarks = remarkDao.getRemark(NoteId);
        for(Remark remark : remarks) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(remark.getUserId() == admin.getId()) {
                    remark.setImage(admin.getImage());
                    remark.setNickname(admin.getNickname());
                }
            }
        }

        PageInfo<Remark> pageInfo = new PageInfo<Remark>(remarks);
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(pageInfo.getTotal());
        resultUtil.setData(pageInfo.getList());
        return resultUtil;
    }
    @Override
    public List<Remark> getReply(int NoteId) {
        Search search = new Search();
        List<Remark> remarks = remarkDao.getRemark(NoteId);
        for(Remark remark : remarks) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(remark.getUserId() == admin.getId()) {
                    remark.setImage(admin.getImage());
                    remark.setNickname(admin.getNickname());
                }
            }
        }
        return remarks;
    }

    @Override
    public ResultUtil getLeaveMess(Integer page, Integer limit) {
        PageHelper.startPage(page, limit);
        Search search = new Search();
        List<Remark> remarks = remarkDao.getLeaveMess();
        for(Remark remark : remarks) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(remark.getUserId() == admin.getId()) {
                    remark.setImage(admin.getImage());
                    remark.setNickname(admin.getNickname());
                }
            }
        }

        PageInfo<Remark> pageInfo = new PageInfo<Remark>(remarks);
        ResultUtil resultUtil = new ResultUtil();
        resultUtil.setCode(0);
        resultUtil.setCount(pageInfo.getTotal());
        resultUtil.setData(pageInfo.getList());
        return resultUtil;
    }
    @Override
    public List<Remark> getLeaveMessReply() {
        Search search = new Search();
        List<Remark> remarks = remarkDao.getLeaveMess();
        for(Remark remark : remarks) {
            List<Admin> admins = adminDao.getAdminsList(search);
            for(Admin admin : admins) {
                if(remark.getUserId() == admin.getId()) {
                    remark.setImage(admin.getImage());
                    remark.setNickname(admin.getNickname());
                }
            }
        }
        return remarks;
    }

    @Override
    public void delRemarkById(int remarkId) {
        remarkDao.delRemarkById(remarkId);
    }

}
