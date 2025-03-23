CREATE DATABASE IF NOT EXISTS institutional_management;
USE institutional_management;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fullName VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    phoneNumber VARCHAR(20),
    address TEXT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create events table
CREATE TABLE IF NOT EXISTS events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    dateTime DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    imageUrl VARCHAR(255),
    isActive BOOLEAN DEFAULT TRUE,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create news table
CREATE TABLE IF NOT EXISTS news (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    imageUrl VARCHAR(255),
    category VARCHAR(100),
    isActive BOOLEAN DEFAULT TRUE,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample admin user (password: admin123)
INSERT INTO users (username, password, email, fullName, role)
VALUES 
('admin', '$2a$10$rS.bCqUUF1QhaPF6TkFpfOcPFKxN0RIcY7VKD.q8H.TQKUJzXGK.O', 'admin@example.com', 'System Administrator', 'ADMIN');

-- Insert sample events
INSERT INTO events (title, description, dateTime, location, imageUrl, isActive, createdAt, updatedAt)
VALUES 
('Annual Sports Day', 'Join us for our annual sports day featuring various athletic competitions and fun activities.', '2024-03-25 09:00:00', 'Main Ground', 'https://picsum.photos/800/600', true, NOW(), NOW()),
('Parent-Teacher Meeting', 'Important meeting to discuss student progress and upcoming academic plans.', '2024-03-28 14:00:00', 'Auditorium', 'https://picsum.photos/800/601', true, NOW(), NOW()),
('Science Fair', 'Students showcase their innovative science projects and experiments.', '2024-04-05 10:00:00', 'Science Block', 'https://picsum.photos/800/602', true, NOW(), NOW());

-- Insert sample news
INSERT INTO news (title, description, imageUrl, category, isActive, createdAt, updatedAt)
VALUES 
('Important Announcement', 'The institution will be closed for spring break from March 15 to March 20.', 'https://picsum.photos/800/603', 'Announcements', true, NOW(), NOW()),
('New Course Offering', 'We are excited to announce the introduction of new advanced courses in computer science.', 'https://picsum.photos/800/604', 'Academics', true, NOW(), NOW()),
('Student Achievement', 'Congratulations to our students who won first place in the regional debate competition.', 'https://picsum.photos/800/605', 'Achievements', true, NOW(), NOW()); 