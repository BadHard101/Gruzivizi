package com.example.buysell.controllers;

import com.example.buysell.models.Order;
import com.example.buysell.models.enums.Status;
import com.example.buysell.repositories.OrderRepository;
import com.example.buysell.services.OrderService;
import com.example.buysell.services.UserService;
import com.example.buysell.services.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_CARRIER')")
public class CarrierController {
    private final UserService userService;
    private final OrderService orderService;
    private final OrderRepository orderRepository;
    private final VehicleService vehicleService;

    @GetMapping("/carrier")
    public String carriersPanel(Model model) {
        model.addAttribute("orders", orderService.list());
        return "carrier";
    }
    @PostMapping("/carrier/order/accept/{id}")
    public String acceptOrder(@PathVariable("id") Long id, Principal principal) {
        Order order = orderService.getOrderById(id);
        if (order.getCarrierId() == null) {
            order.setCarrierId(
                    orderService.getUserByPrincipal(principal).getId()
            );
            order.setStatus(Status.ACCEPTED);
            orderRepository.save(order);
        }
        return "redirect:/carrier";
    }

}
