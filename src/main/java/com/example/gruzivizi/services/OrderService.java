package com.example.gruzivizi.services;

import com.example.gruzivizi.models.Image;
import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.models.User;
import com.example.gruzivizi.models.Vehicle;
import com.example.gruzivizi.models.enums.Status;
import com.example.gruzivizi.repositories.OrderRepository;
import com.example.gruzivizi.repositories.UserRepository;
import com.example.gruzivizi.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final VehicleRepository vehicleRepository;

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

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    /*public void changeOrderStatus(Order order, Map<String, String> form) {
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
    }*/

    public boolean validateOrder(Principal principal, Order order) {
        for (Vehicle vehicle : vehicleRepository.findAll()) {
            if (!vehicle.isBusy()
                    && vehicle.getMaxWidth() >= order.getWidth()
                    && vehicle.getMaxHeight() >= order.getHeight()
                    && vehicle.getMaxWeight() >= order.getWeight()
                    && vehicle.getMaxPassengers() >= order.getPassengers()
                    && (vehicle.isHydroboard() == order.isHydroboard() || vehicle.isHydroboard())
                    && (vehicle.isThermalProtection() == order.isThermalProtection() || vehicle.isThermalProtection())
            ) {
                order.addVehicle(vehicle);
            }
        }
        order.setUser(getUserByPrincipal(principal));
        if (!order.getValidateVehicles().isEmpty())
            orderRepository.save(order);
        return !order.getValidateVehicles().isEmpty();
    }

    public String formatOrderDate(Order order) {
        return order.getDateOfCreated().format(DateTimeFormatter.ofPattern("dd MMMM yyyy г., HH:mm:ss"));
    }
}
