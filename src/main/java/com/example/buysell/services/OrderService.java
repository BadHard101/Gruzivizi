package com.example.buysell.services;

import com.example.buysell.models.Image;
import com.example.buysell.models.Order;
import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.models.enums.Status;
import com.example.buysell.repositories.OrderRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.weaver.ast.Or;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    public List<Order> list() {
        return orderRepository.findAll();
    }

    public List<Order> listOrders(Long id) {
        if (id != null) return orderRepository.findOrderById(id);
        return orderRepository.findAll();
    }

    public void saveOrder(Principal principal, Order order) throws IOException {
        order.setUser(getUserByPrincipal(principal));
        log.info("Saving new Order. ID: {}; Author email: {}", order.getId(), order.getUser().getEmail());
        Order orderFromDb = orderRepository.save(order);
        orderRepository.save(order);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteOrder(Long id) {
        orderRepository.deleteById(id);
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public void changeOrderStatus(Order order, Map<String, String> form) {
        Set<String> status = Arrays.stream(Status.values())
                .map(Status::name)
                .collect(Collectors.toSet());
        order.getStatus().clear();
        for (String key : form.keySet()) {
            if (status.contains(key)) {
                order.getStatus().add(Status.valueOf(key));
            }
        }
        orderRepository.save(order);
    }
}
