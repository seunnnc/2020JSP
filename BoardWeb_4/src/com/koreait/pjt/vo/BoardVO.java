package com.koreait.pjt.vo;

public class BoardVO {
	private int i_board;
	private String title;
	private String ctnt;
	private int hits;
	private int i_user;
	private String r_dt;
	private String m_dt;
	private String nm;
	private int yn_like;
	private int like_count;
	private int record_cnt;	//페이지당 레코드 수
	private int sIdx;
	private int eIdx;
	private int page;
	
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public int getI_board() {
		return i_board;
	}
	public void setI_board(int i_board) {
		this.i_board = i_board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCtnt() {
		return ctnt;
	}
	public void setCtnt(String ctnt) {
		this.ctnt = ctnt;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getI_user() {
		return i_user;
	}
	public void setI_user(int i_user) {
		this.i_user = i_user;
	}
	public String getR_dt() {
		return r_dt;
	}
	public void setR_dt(String r_dt) {
		this.r_dt = r_dt;
	}
	public String getM_dt() {
		return m_dt;
	}
	public void setM_dt(String m_dt) {
		this.m_dt = m_dt;
	}
	public int getYn_like() {
		return yn_like;
	}
	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getRecord_cnt() {
		return record_cnt;
	}
	public void setRecord_cnt(int record_cnt) {
		this.record_cnt = record_cnt;
	}
	
	public int getsIdx() {
		return sIdx;
	}
	public void setsIdx(int sIdx) {
		this.sIdx = sIdx;
	}
	public int geteIdx() {
		return eIdx;
	}
	public void seteIdx(int eIdx) {
		this.eIdx = eIdx;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	
}
