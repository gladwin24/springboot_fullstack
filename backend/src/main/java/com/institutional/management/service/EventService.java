package com.institutional.management.service;

import com.institutional.management.model.Event;
import com.institutional.management.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class EventService {
    
    @Autowired
    private EventRepository eventRepository;

    public List<Event> getAllActiveEvents() {
        return eventRepository.findByActiveTrueOrderByDateTimeAsc();
    }

    public List<Event> getUpcomingEvents() {
        return eventRepository.findByDateTimeAfterAndActiveTrueOrderByDateTimeAsc(LocalDateTime.now());
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Event not found"));
    }

    public Event createEvent(Event event) {
        event.setCreatedAt(LocalDateTime.now());
        event.setUpdatedAt(LocalDateTime.now());
        return eventRepository.save(event);
    }

    public Event updateEvent(Long id, Event eventDetails) {
        Event event = getEventById(id);
        event.setTitle(eventDetails.getTitle());
        event.setDescription(eventDetails.getDescription());
        event.setDateTime(eventDetails.getDateTime());
        event.setLocation(eventDetails.getLocation());
        event.setImageUrl(eventDetails.getImageUrl());
        event.setUpdatedAt(LocalDateTime.now());
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        Event event = getEventById(id);
        event.setActive(false);
        event.setUpdatedAt(LocalDateTime.now());
        eventRepository.save(event);
    }
} 