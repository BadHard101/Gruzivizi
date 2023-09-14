package com.example.gruzivizi.services;

import com.example.gruzivizi.models.Image;
import com.example.gruzivizi.models.User;
import com.example.gruzivizi.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
@Slf4j
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    public User photoUpdate(Long id, MultipartFile file1) throws IOException {
        Image image1;
        User user = userRepository.getById(id);
        if (file1.getSize() != 0) {
            image1 =  toImageEntity(file1);
            image1.setPreviewImage(true);
            user.setAvatar(image1);
        }
        userRepository.save(user);
        return user;
    }

    private static Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }
}
