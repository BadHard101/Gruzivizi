package com.example.buysell.controllers;

import com.example.buysell.services.OrderService;
import com.example.buysell.services.UserService;
import com.example.buysell.services.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_CARRIER')")
public class CarrierController {
    private final UserService userService;
    private final OrderService orderService;
    private final VehicleService vehicleService;

    @GetMapping("/carrier")
    public String carriersPanel(Model model) {
        model.addAttribute("orders", orderService.list());
        return "carrier";
    }

}
