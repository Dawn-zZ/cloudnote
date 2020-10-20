package com.zjq.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Remark {
    private int remarkId;
    private String content;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private int userId;
    private int noteId;
    private int upStatus;
    private int parentId;
    private int isParent;
    private int isLeaveMess;

    private String image;
    private String nickname;

    public int getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(int remarkId) {
        this.remarkId = remarkId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getNoteId() {
        return noteId;
    }

    public void setNoteId(int noteId) {
        this.noteId = noteId;
    }

    public int getUpStatus() {
        return upStatus;
    }

    public void setUpStatus(int upStatus) {
        this.upStatus = upStatus;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getIsParent() {
        return isParent;
    }

    public void setIsParent(int isParent) {
        this.isParent = isParent;
    }

    public int getIsLeaveMess() {
        return isLeaveMess;
    }

    public void setIsLeaveMess(int isLeaveMess) {
        this.isLeaveMess = isLeaveMess;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "Remark{" +
                "remarkId=" + remarkId +
                ", content='" + content + '\'' +
                ", createTime=" + createTime +
                ", userId=" + userId +
                ", noteId=" + noteId +
                ", upStatus=" + upStatus +
                ", parentId=" + parentId +
                ", isParent=" + isParent +
                ", isLeaveMess=" + isLeaveMess +
                ", image='" + image + '\'' +
                ", nickname='" + nickname + '\'' +
                '}';
    }
}
