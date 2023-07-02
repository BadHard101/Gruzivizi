package com.example.gruzivizi.controllers;

import com.example.gruzivizi.models.Vehicle;
import com.example.gruzivizi.services.VehicleService;
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
public class VehicleController {
    private final VehicleService vehicleService;

    /*@GetMapping("/")
    public String vehicles(@RequestParam(name = "id", required = false) Long id, Model model) {
        model.addAttribute("vehicles", vehicleService.listVehicles(id));
        return "vehicles";
    }*/

    @GetMapping("/vehicle/{id}")
    public String vehicleInfo(@PathVariable Long id, Model model) {
        Vehicle vehicle = vehicleService.getVehicleById(id);
        model.addAttribute("vehicle", vehicle);
        return "vehicle-info";
    }

    /*@PostMapping("/vehicle/create")
    public String createVehicle(Vehicle vehicle, Principal principal) throws IOException {
        vehicleService.saveVehicle(principal, vehicle);
        return "redirect:/admin/vehiclesPanel";
    }*/

    @PostMapping("/vehicle/create")
    public String createVehicle(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3, Vehicle vehicle, Principal principal) throws IOException {
        vehicleService.saveVehicle(principal, vehicle, file1, file2, file3);
        return "redirect:/admin/vehiclesPanel";
    }

    @PostMapping("/vehicle/delete/{id}")
    public String deleteVehicle(@PathVariable Long id) {
        vehicleService.deleteVehicle(id);
        return "redirect:/";
    }
}
