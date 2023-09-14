package com.example.gruzivizi.services;

import com.example.gruzivizi.models.Image;
import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.models.User;
import com.example.gruzivizi.models.enums.Role;
import com.example.gruzivizi.models.enums.Status;
import com.example.gruzivizi.repositories.OrderRepository;
import com.example.gruzivizi.repositories.UserRepository;
import com.example.gruzivizi.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Service
@Slf4j
@RequiredArgsConstructor
public class AdminService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final VehicleRepository vehicleRepository;

    public void deleteOrder(Long id) {
        orderRepository.deleteById(id);
    }

    public void deleteVehicle(Long id) {
        vehicleRepository.deleteById(id);
    }

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


    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Ban user with id = {}; email: {}", user.getId(), user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unban user with id = {}; email: {}", user.getId(), user.getEmail());
            }
        }
        userRepository.save(user);
    }

    public void changeUserRole(User user, String role) {
        Set<Role> roles = new HashSet<>();
        if (role != null && !role.isEmpty()) {
            roles.add(Role.valueOf(role));
        }
        user.setRoles(roles);
        userRepository.save(user);
    }

    public void changeOrderStatus(Order order, String status) {
        if (status != null && !status.isEmpty()) {
            order.setStatus(Status.valueOf(status));
        }
        orderRepository.save(order);
    }
}
