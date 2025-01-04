package org.example.legacy.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.example.legacy.entity.Board;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<Board> getLists();
    void insertList(Board board);
    void updateList(Board board);
    void deleteList(int idx);
}
