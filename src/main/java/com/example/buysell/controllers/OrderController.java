package com.example.buysell.controllers;

import com.example.buysell.models.Order;
import com.example.buysell.services.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @GetMapping("/")
    public String orders(@RequestParam(name = "id", required = false) Long id, Principal principal, Model model) {
        model.addAttribute("orders", orderService.listOrders(id));
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "orders";
    }

    @GetMapping("/order/{id}")
    public String orderInfo(@PathVariable Long id, Model model, Principal principal) {
        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "order-info";
    }

    @PostMapping("/order/create")
    public String createOrder(Order order, Principal principal) throws IOException {
        orderService.saveOrder(principal, order);
        return "redirect:/";
    }

    @PostMapping("/order/delete/{id}")
    public String deleteOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
        return "redirect:/";
    }
}
