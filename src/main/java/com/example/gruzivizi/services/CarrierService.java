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

    /**
     * Accepts an order by a carrier.
     *
     * @param id        The ID of the order to be accepted.
     * @param principal The security principal of the current user (carrier).
     */
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

    /**
     * Cancels an order by admin, even if it was previously accepted by a carrier.
     *
     * @param id        The ID of the order to be cancelled.
     * @param principal The security principal of the current user (carrier).
     */
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

    /**
     * Processes an order that was accepted by a carrier.
     *
     * @param id The ID of the order to be processed.
     */
    public void processOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.ACCEPTED)) {
            order.setStatus(Status.IN_PROCESS);
            orderRepository.save(order);
        }
    }

    /**
     * Declines an order that was in process by a carrier.
     *
     * @param id The ID of the order to be declined.
     */
    public void declineOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.IN_PROCESS)) {
            order.setStatus(Status.ACCEPTED);
            orderRepository.save(order);
        }
    }

    /**
     * Completes an order that was in process by a carrier.
     *
     * @param id The ID of the order to be completed.
     */
    public void completeOrder(Long id) {
        Order order = orderService.getOrderById(id);
        if (order.getStatus().contains(Status.IN_PROCESS)) {
            order.setStatus(Status.COMPLETED);
            orderRepository.save(order);
        }
    }

    /**
     * Allows a carrier to take a vehicle.
     *
     * @param id        The ID of the vehicle to be taken.
     * @param principal The security principal of the current user (carrier).
     */
    public void takeVehicle(Long id, Principal principal) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        if (!vehicle.isBusy()) {
            vehicle.setBusy(true);
            vehicle.setCarrierId(orderService.getUserByPrincipal(principal).getId());
            vehicleRepository.save(vehicle);
        }
    }

    /**
     * Allows a carrier to release a vehicle.
     *
     * @param id        The ID of the vehicle to be released.
     * @param principal The security principal of the current user (carrier).
     */
    public void releaseVehicle(Long id, Principal principal) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        vehicle.setBusy(false);
        vehicle.setCarrierId((long) 0);
        vehicleRepository.save(vehicle);
    }
}
