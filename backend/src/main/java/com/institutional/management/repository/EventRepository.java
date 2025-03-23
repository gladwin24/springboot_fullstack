package com.institutional.management.repository;

import com.institutional.management.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByActiveTrueOrderByDateTimeAsc();
    List<Event> findByDateTimeAfterAndActiveTrueOrderByDateTimeAsc(LocalDateTime dateTime);
} 