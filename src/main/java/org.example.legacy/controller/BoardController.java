package org.example.legacy.controller;

import org.example.legacy.entity.Board;
import org.example.legacy.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardMapper boardMapper;

    @RequestMapping("/boardList.do")
    public String boardList2(Model model) {

        List<Board> list = boardMapper.getLists();
        model.addAttribute("list", list);

        return "boardList";
    }

    @ResponseBody
    @PostMapping(value="/board", consumes = "application/json")
    public ResponseEntity<Void> insertBoard(@RequestBody Board board) {
        System.out.println("Board: "+board);
        boardMapper.insertList(board);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @PutMapping(value = "/board/{idx}", consumes = "application/json")
    public ResponseEntity<Void> updateList(@PathVariable("idx") int idx
                                          ,@RequestBody Board board
                                            ) {
        System.out.println("Board: "+board);
        boardMapper.updateList(board);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @DeleteMapping("/board/{idx}")
    public ResponseEntity<Void> deleteList(@PathVariable("idx") int idx) {
        boardMapper.deleteList(idx);
        return ResponseEntity.ok().build();
    }
}