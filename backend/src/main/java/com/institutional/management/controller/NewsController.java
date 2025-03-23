package com.institutional.management.controller;

import com.institutional.management.model.News;
import com.institutional.management.service.NewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/news")
@CrossOrigin(origins = "*")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @GetMapping
    public ResponseEntity<List<News>> getAllNews() {
        return ResponseEntity.ok(newsService.getAllActiveNews());
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<News>> getNewsByCategory(@PathVariable String category) {
        return ResponseEntity.ok(newsService.getNewsByCategory(category));
    }

    @GetMapping("/{id}")
    public ResponseEntity<News> getNewsById(@PathVariable Long id) {
        return ResponseEntity.ok(newsService.getNewsById(id));
    }

    @PostMapping
    public ResponseEntity<News> createNews(@RequestBody News news) {
        return ResponseEntity.ok(newsService.createNews(news));
    }

    @PutMapping("/{id}")
    public ResponseEntity<News> updateNews(@PathVariable Long id, @RequestBody News newsDetails) {
        return ResponseEntity.ok(newsService.updateNews(id, newsDetails));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteNews(@PathVariable Long id) {
        newsService.deleteNews(id);
        return ResponseEntity.ok().build();
    }
} 