package com.example.gruzivizi.controllers;

import com.example.gruzivizi.models.Vehicle;
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
@RequestMapping("/vehicle")
public class VehicleController {
    private final VehicleService vehicleService;

    @GetMapping("/{id}")
    public String vehicleInfo(@PathVariable Long id, Model model) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        model.addAttribute("vehicle", vehicle);
        return "carrier/vehicle-info";
    }

    @GetMapping("/getVehicleAddingPage")
    public String getVehicleAddingPage() {
        return "admin/panels/addVehicleForm";
    }

    @PostMapping("/create")
    public String createVehicle(@RequestParam("file1") MultipartFile file1, Vehicle vehicle, Principal principal) throws IOException {
        vehicleService.saveVehicle(principal, vehicle, file1);
        return "redirect:/admin/vehiclesPanel";
    }
}
