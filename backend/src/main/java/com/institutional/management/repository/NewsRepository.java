package com.institutional.management.repository;

import com.institutional.management.model.News;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
    List<News> findByActiveTrueOrderByCreatedAtDesc();
    List<News> findByCategoryAndActiveTrueOrderByCreatedAtDesc(String category);
} 