package com.example.gruzivizi.controllers;

import com.example.gruzivizi.services.CarrierService;
import com.example.gruzivizi.services.OrderService;
import com.example.gruzivizi.services.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_CARRIER')")
@RequestMapping("/carrier")
public class CarrierController {
    private final OrderService orderService;
    private final VehicleService vehicleService;
    private final CarrierService carrierService;

    @GetMapping("/")
    public String carriersPanel(Model model, Principal principal) {
        model.addAttribute("orders", orderService.list());
        model.addAttribute("vehicles", vehicleService.list());
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "carrier/carrier";
    }

    @GetMapping("/vehicle/{id}")
    public String carriersVehicles(@PathVariable("id") Long id, Model model, Principal principal) {
        model.addAttribute("vehicle", vehicleService.getVehicleById(id));
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "carrier/vehicle-info";
    }

    @PostMapping("/vehicle/accept/{id}")
    public String acceptVehicle(@PathVariable("id") Long id, Principal principal) {
        carrierService.takeVehicle(id, principal);
        return "redirect:/carrier";
    }

    @PostMapping("/vehicle/decline/{id}")
    public String declineVehicle(@PathVariable("id") Long id, Principal principal) {
        carrierService.releaseVehicle(id, principal);
        return "redirect:/carrier";
    }

    @PostMapping("/order/accept/{id}")
    public String acceptOrder(@PathVariable("id") Long id, Principal principal) {
        carrierService.acceptOrder(id, principal);
        return "redirect:/carrier";
    }

    @PostMapping("/order/cancel/{id}")
    public String cancelOrder(@PathVariable("id") Long id, Principal principal) {
        carrierService.cancelOrder(id, principal);
        return "redirect:/carrier";
    }

    @PostMapping("/order/process/{id}")
    public String processOrder(@PathVariable("id") Long id) {
        carrierService.processOrder(id);
        return "redirect:/carrier";
    }

    @PostMapping("/order/decline/{id}")
    public String declineOrder(@PathVariable("id") Long id) {
        carrierService.declineOrder(id);
        return "redirect:/carrier";
    }

    @PostMapping("/order/complete/{id}")
    public String completeOrder(@PathVariable("id") Long id) {
        carrierService.completeOrder(id);
        return "redirect:/carrier";
    }

}
