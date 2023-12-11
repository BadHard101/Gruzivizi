package com.example.gruzivizi.services;

import com.example.gruzivizi.models.User;
import com.example.gruzivizi.models.enums.Role;
import com.example.gruzivizi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean userExists(User user) {
        if (userRepository.findByEmail(user.getEmail()) != null) return true;
        else return false;
    }

    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_USER);
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        return true;
    }

    public List<User> list() {
        return userRepository.findAll();
    }

    public List<User> listUsers(String tel) {
        if (tel != null) return userRepository.findByPhoneNumber(tel);
        return userRepository.findAll();
    }

    public String formatUserDate(User user) {
        return user.getDateOfCreated().format(DateTimeFormatter.ofPattern("dd MMMM yyyy г."));
    }

    /*public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }*/
}
