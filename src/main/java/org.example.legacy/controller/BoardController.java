package org.example.legacy.controller;

import org.example.legacy.entity.Board;
import org.example.legacy.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private BoardMapper boardMapper;

    @RequestMapping("/boardList.do")
    public String boardList2(Model model) {

        System.out.println("boardList2.do 실행");
        List<Board> list = boardMapper.getLists();
        model.addAttribute("list", list);

        return "boardList";
    }

    @ResponseBody
    @PostMapping("/board")
    public ResponseEntity<Void> insertBoard(Board board) {
        boardMapper.insertList(board);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @PutMapping(value = "/board/{idx}")
    public ResponseEntity<Void> updateList(@PathVariable("idx") int idx
                                          ,@RequestBody Map<String, String> board
                                            ) {
        System.out.println(board);
        System.out.println("updateList called");
        //boardMapper.updateList(board);
        return ResponseEntity.ok().build();
    }

    @ResponseBody
    @DeleteMapping("/board/{idx}")
    public ResponseEntity<Void> deleteList(@PathVariable("idx") int idx) {
        boardMapper.deleteList(idx);
        return ResponseEntity.ok().build();
    }
}