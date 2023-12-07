package com.example.gruzivizi.controllers;

import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.services.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        return "user/orders";
    }

    @GetMapping("/order/{id}")
    public String orderInfo(@PathVariable Long id, Model model, Principal principal) {
        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "user/order-info";
    }

    @GetMapping("/order/getAddingOrderPage")
    public String getAddingOrderPage(Principal principal, Model model) {
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "user/addOrder";
    }

    @PostMapping("/order/create")
    public String createOrder(Model model, Order order, Principal principal) throws IOException {
        if (orderService.validateOrder(principal, order)) {
            orderService.saveOrder(principal, order);
            return "redirect:/";
        } else {
            model.addAttribute("errorMessage", "Сожалеем, но у нас нет " +
                    "подходящего транспорта для Вашего заказа.\nПожалуйста, проверьте правильность " +
                    "введенных данных в заказ или свяжитесь с нами по телефону: +7 (800) 255-35-35");
        }

        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "user/addOrder";
    }

}
