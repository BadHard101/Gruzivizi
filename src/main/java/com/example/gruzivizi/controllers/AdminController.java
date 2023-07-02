package com.example.gruzivizi.controllers;

import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.models.User;
import com.example.gruzivizi.models.enums.Role;
import com.example.gruzivizi.models.enums.Status;
import com.example.gruzivizi.services.OrderService;
import com.example.gruzivizi.services.UserService;
import com.example.gruzivizi.services.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserService userService;
    private final OrderService orderService;
    private final VehicleService vehicleService;

    @GetMapping("/admin")
    public String admin(Model model) {
        return "admin";
    }

    @GetMapping("/admin/usersPanel")
    public String usersPanel(Model model) {
        model.addAttribute("users", userService.list());
        return "usersPanel";
    }

    @GetMapping("/admin/ordersPanel")
    public String ordersPanel(Model model) {
        model.addAttribute("orders", orderService.list());
        return "ordersPanel";
    }

    @GetMapping("/admin/vehiclesPanel")
    public String vehiclesPanel(Model model) {
        model.addAttribute("vehicles", vehicleService.list());
        return "vehiclesPanel";
    }

    @PostMapping("/admin/order/delete/{id}")
    public String orderDelete(@PathVariable("id") Long id) {
        orderService.deleteOrder(id);
        return "redirect:/admin/ordersPanel";
    }

    @PostMapping("/admin/vehicle/delete/{id}")
    public String vehicleDelete(@PathVariable("id") Long id) {
        vehicleService.deleteVehicle(id);
        return "redirect:/admin/vehiclesPanel";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin/usersPanel";
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam("userRole") String role) {
        userService.changeUserRole(user, role);
        return "redirect:/admin/usersPanel";
    }

    @GetMapping("/admin/order/edit/{order}")
    public String orderEdit(@PathVariable("order") Order order, Model model) {
        model.addAttribute("order", order);
        model.addAttribute("status", Status.values());
        return "order-edit";
    }

    @PostMapping("/admin/order/edit")
    public String orderEdit(@RequestParam("orderId") Order order, @RequestParam("orderStatus") String status) {
        orderService.changeOrderStatus(order, status);
        return "redirect:/admin/ordersPanel";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("orders", user.getOrders());
        return "user-info";
    }

    @GetMapping("/admin/vehicle/{id}")
    public String carriersVehicles(@PathVariable("id") Long id, Model model, Principal principal) {
        model.addAttribute("vehicle", vehicleService.getVehicleById(id));
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "vehicle-info";
    }

}
