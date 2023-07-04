package com.example.gruzivizi.services;

import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.models.Vehicle;
import com.example.gruzivizi.models.enums.Status;
import com.example.gruzivizi.repositories.OrderRepository;
import com.example.gruzivizi.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;

@Service
@Slf4j
@RequiredArgsConstructor
public class CarrierService {
    private final VehicleService vehicleService;
    private final VehicleRepository vehicleRepository;
    private final OrderService orderService;
    private final OrderRepository orderRepository;

    public void acceptOrder(Long id, Principal principal) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.CREATED)) {
            order.setStatus(Status.ACCEPTED);
            order.setCarrierId(
                    orderService.getUserByPrincipal(principal).getId()
            );
            orderRepository.save(order);
        }
    }

    public void cancelOrder(Long id, Principal principal) {
        Order order = orderService.getOrderById(id);
        if (order.getCarrierId() != null &&
                order.getCarrierId().equals(
                        orderService.getUserByPrincipal(principal).getId())) {
            order.setStatus(Status.CREATED);
            order.setCarrierId(null);
            orderRepository.save(order);
        }
    }

    public void processOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.ACCEPTED)) {
            order.setStatus(Status.IN_PROCESS);
            orderRepository.save(order);
        }
    }

    public void declineOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.IN_PROCESS)) {
            order.setStatus(Status.ACCEPTED);
            orderRepository.save(order);
        }
    }

    public void completeOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.IN_PROCESS)) {
            order.setStatus(Status.COMPLETED);
            orderRepository.save(order);
        }
    }

    public void takeVehicle(Long id, Principal principal) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        if (!vehicle.isBusy()) {
            vehicle.setBusy(true);
            vehicle.setCarrierId(orderService.getUserByPrincipal(principal).getId());
            vehicleRepository.save(vehicle);
        }
    }

    public void releaseVehicle(Long id, Principal principal) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        vehicle.setBusy(false);
        vehicle.setCarrierId((long) 0);
        vehicleRepository.save(vehicle);
    }
}
