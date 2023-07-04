package com.example.gruzivizi.repositories;

import com.example.gruzivizi.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    List<User> findByPhoneNumber(String tel);
}
