package org.example.legacy.entity;


public class Board {
    @Override
    public String toString() {
        return "Board{" +
                "idx=" + idx +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", writer='" + writer + '\'' +
                ", indate='" + indate + '\'' +
                ", count=" + count +
                '}';
    }

    private int idx;
    private String title;
    private String content;
    private String writer;
    private String indate;
    private int count;

    public Board() {}
    public Board(int idx, String title, String content, String writer, String indate, int count) {
        this.idx = idx;
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.indate = indate;
        this.count = count;

    }

    public int getIdx(){
        return this.idx;
    }

    public String getTitle() {
        return this.title;
    }
    public String getContent(){
        return this.content;
    }
    public String getWriter() {
        return this.writer;
    }
    public String getIndate() {
        return this.indate;
    }

    public int getCount() {
        return this.count;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public void setIndate(String indate) {
        this.indate = indate;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }
}
