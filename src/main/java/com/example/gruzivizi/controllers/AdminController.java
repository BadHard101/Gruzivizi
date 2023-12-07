package com.example.gruzivizi.controllers;

import com.example.gruzivizi.models.Order;
import com.example.gruzivizi.models.User;
import com.example.gruzivizi.models.enums.Role;
import com.example.gruzivizi.models.enums.Status;
import com.example.gruzivizi.services.AdminService;
import com.example.gruzivizi.services.OrderService;
import com.example.gruzivizi.services.UserService;
import com.example.gruzivizi.services.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
@RequestMapping("/admin")
public class AdminController {
    private final UserService userService;
    private final OrderService orderService;
    private final VehicleService vehicleService;
    private final AdminService adminService;

    @GetMapping("/")
    public String admin(Model model) {
        return "admin/admin";
    }

    @GetMapping("/usersPanel")
    public String usersPanel(@RequestParam(name = "tel", required = false) String tel, Model model) {
        model.addAttribute("users", userService.listUsers(tel));
        return "admin/panels/usersPanel";
    }

    @GetMapping("/ordersPanel")
    public String ordersPanel(@RequestParam(name = "id", required = false) Long id, Model model) {
        model.addAttribute("orders", orderService.listOrders(id));
        return "admin/panels/ordersPanel";
    }

    @GetMapping("/vehiclesPanel")
    public String vehiclesPanel(@RequestParam(name = "registrationNumber", required = false) String registrationNumber, Model model) {
        model.addAttribute("vehicles", vehicleService.listVehicles(registrationNumber));
        return "admin/panels/vehiclesPanel";
    }

    @PostMapping("/order/delete/{id}")
    public String orderDelete(@PathVariable("id") Long id) {
        adminService.deleteOrder(id);
        return "redirect:/admin/ordersPanel";
    }

    @PostMapping("/vehicle/delete/{id}")
    public String vehicleDelete(@PathVariable("id") Long id) {
        adminService.deleteVehicle(id);
        return "redirect:/admin/vehiclesPanel";
    }

    @PostMapping("/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        adminService.banUser(id);
        return "redirect:/admin/usersPanel";
    }

    @GetMapping("/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "admin/users/user-edit";
    }

    @PostMapping("/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam("userRole") String role) {
        adminService.changeUserRole(user, role);
        return "redirect:/admin/usersPanel";
    }

    @GetMapping("/order/edit/{order}")
    public String orderEdit(@PathVariable("order") Order order, Model model) {
        model.addAttribute("order", order);
        model.addAttribute("status", Status.values());
        return "admin/orders/order-edit";
    }

    @PostMapping("/order/edit")
    public String orderEdit(@RequestParam("orderId") Order order, @RequestParam("orderStatus") String status) {
        adminService.changeOrderStatus(order, status);
        return "redirect:/admin/ordersPanel";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
        model.addAttribute("user", user);
        model.addAttribute("orders", user.getOrders());
        model.addAttribute("admin", orderService.getUserByPrincipal(principal));
        return "user/user-info";
    }

    @GetMapping("/vehicle/{id}")
    public String carriersVehicles(@PathVariable("id") Long id, Model model, Principal principal) {
        model.addAttribute("vehicle", vehicleService.getVehicleById(id));
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "carrier/vehicle-info";
    }

    @PostMapping("/user/photo/update/{id}")
    public String photoUpdate(@RequestParam("file1") MultipartFile file1,
                              @PathVariable("id") Long id,
                              Model model, Principal principal) throws IOException {
        User user = adminService.photoUpdate(id, file1);
        return userInfo(user, model, principal);
    }
}
