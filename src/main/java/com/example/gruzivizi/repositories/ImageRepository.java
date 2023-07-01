package com.example.gruzivizi.repositories;

import com.example.gruzivizi.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
