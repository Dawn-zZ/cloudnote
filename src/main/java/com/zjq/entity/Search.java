package com.zjq.entity;

public class Search {

    private String nickname;
    private String sex;
    private String status;
    private String createTimeStart;
    private String createTimeEnd;
    private int isAdmin;

    //Note用到的
    private String noteTitle;
    private int isOpen;
    private int uploadStatus;
    private int checkStatus;
    private int userId;

    //Remark用到的
	private int upStatus;
	private int isLeaveMess;
	//private int userId;

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreateTimeStart() {
		return createTimeStart;
	}

	public void setCreateTimeStart(String createTimeStart) {
		this.createTimeStart = createTimeStart;
	}

	public String getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(String createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getNoteTitle() {
		return noteTitle;
	}

	public void setNoteTitle(String noteTitle) {
		this.noteTitle = noteTitle;
	}

	public int getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(int isOpen) {
		this.isOpen = isOpen;
	}

	public int getUploadStatus() {
		return uploadStatus;
	}

	public void setUploadStatus(int uploadStatus) {
		this.uploadStatus = uploadStatus;
	}

	public int getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(int checkStatus) {
		this.checkStatus = checkStatus;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getUpStatus() {
		return upStatus;
	}

	public void setUpStatus(int upStatus) {
		this.upStatus = upStatus;
	}

	public int getIsLeaveMess() {
		return isLeaveMess;
	}

	public void setIsLeaveMess(int isLeaveMess) {
		this.isLeaveMess = isLeaveMess;
	}

	@Override
	public String toString() {
		return "Search{" +
				"nickname='" + nickname + '\'' +
				", sex='" + sex + '\'' +
				", status='" + status + '\'' +
				", createTimeStart='" + createTimeStart + '\'' +
				", createTimeEnd='" + createTimeEnd + '\'' +
				", isAdmin=" + isAdmin +
				", noteTitle='" + noteTitle + '\'' +
				", isOpen=" + isOpen +
				", uploadStatus=" + uploadStatus +
				", checkStatus=" + checkStatus +
				", userId=" + userId +
				", upStatus=" + upStatus +
				", isLeaveMess=" + isLeaveMess +
				'}';
	}
}
