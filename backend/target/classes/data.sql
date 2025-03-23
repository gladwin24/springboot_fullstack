-- Insert sample events
INSERT INTO events (title, description, date_time, location, image_url, is_active, created_at, updated_at)
VALUES 
('Annual Tech Conference', 'Join us for our annual technology conference featuring industry experts.', '2024-06-15 09:00:00', 'Main Auditorium', 'tech-conf.jpg', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Career Fair 2024', 'Connect with top employers and explore career opportunities.', '2024-07-20 10:00:00', 'Exhibition Hall', 'career-fair.jpg', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Alumni Meetup', 'Network with fellow alumni and share experiences.', '2024-08-25 18:00:00', 'Garden Court', 'alumni-meet.jpg', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Annual Sports Day', 'Join us for our annual sports day featuring various athletic competitions and fun activities.', '2024-03-25 09:00:00', 'Main Ground', 'https://picsum.photos/800/600', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Parent-Teacher Meeting', 'Important meeting to discuss student progress and upcoming academic plans.', '2024-03-28 14:00:00', 'Auditorium', 'https://picsum.photos/800/601', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Science Fair', 'Students showcase their innovative science projects and experiments.', '2024-04-05 10:00:00', 'Science Block', 'https://picsum.photos/800/602', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert sample news
INSERT INTO news (title, description, image_url, category, is_active, created_at, updated_at)
VALUES 
('New Research Center Opening', 'State-of-the-art research facility to open next month.', 'research-center.jpg', 'Research', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Student Achievement Award', 'Our students win national competition in robotics.', 'robotics-award.jpg', 'Achievement', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Important Announcement', 'The institution will be closed for spring break from March 15 to March 20.', 'https://picsum.photos/800/603', 'Announcements', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('New Course Offering', 'We are excited to announce the introduction of new advanced courses in computer science.', 'https://picsum.photos/800/604', 'Academics', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Student Achievement', 'Congratulations to our students who won first place in the regional debate competition.', 'https://picsum.photos/800/605', 'Achievements', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP); 