package com.institutional.management.service;

import com.institutional.management.model.News;
import com.institutional.management.repository.NewsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class NewsService {
    
    @Autowired
    private NewsRepository newsRepository;

    public List<News> getAllActiveNews() {
        return newsRepository.findByActiveTrueOrderByCreatedAtDesc();
    }

    public List<News> getNewsByCategory(String category) {
        return newsRepository.findByCategoryAndActiveTrueOrderByCreatedAtDesc(category);
    }

    public News getNewsById(Long id) {
        return newsRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("News not found"));
    }

    public News createNews(News news) {
        news.setCreatedAt(LocalDateTime.now());
        news.setUpdatedAt(LocalDateTime.now());
        return newsRepository.save(news);
    }

    public News updateNews(Long id, News newsDetails) {
        News news = getNewsById(id);
        news.setTitle(newsDetails.getTitle());
        news.setDescription(newsDetails.getDescription());
        news.setImageUrl(newsDetails.getImageUrl());
        news.setCategory(newsDetails.getCategory());
        news.setUpdatedAt(LocalDateTime.now());
        return newsRepository.save(news);
    }

    public void deleteNews(Long id) {
        News news = getNewsById(id);
        news.setActive(false);
        news.setUpdatedAt(LocalDateTime.now());
        newsRepository.save(news);
    }
} 