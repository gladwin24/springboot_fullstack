package com.institutional.management.controller;

import com.institutional.management.dto.AuthRequest;
import com.institutional.management.dto.AuthResponse;
import com.institutional.management.dto.RegisterRequest;
import com.institutional.management.entity.User;
import com.institutional.management.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@CrossOrigin(origins = "*") // Enable CORS for all origins
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody AuthRequest request) {
        String token = authService.authenticate(request.getUsername(), request.getPassword());
        return ResponseEntity.ok(new AuthResponse(token));
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        try {
            User user = new User();
            user.setUsername(request.getUsername());
            user.setPassword(request.getPassword());
            user.setEmail(request.getEmail());
            user.setFullName(request.getFullName());
            user.setRole(request.getRole() != null ? request.getRole() : "USER");
            
            User registeredUser = authService.register(user);
            return ResponseEntity.ok(registeredUser);
        } catch (RuntimeException e) {
            Map<String, String> response = new HashMap<>();
            response.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
} 