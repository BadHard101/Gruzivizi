package com.example.buysell.services;

import com.example.buysell.models.Vehicle;
import com.example.buysell.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class VehicleService {
    private final VehicleRepository vehicleRepository;

    public List<Vehicle> list() {
        return vehicleRepository.findAll();
    }

    public List<Vehicle> listVehicles(Long id) {
        if (id != null) return vehicleRepository.findVehicleById(id);
        return vehicleRepository.findAll();
    }

    public void saveVehicle(Principal principal, Vehicle vehicle) throws IOException {
        log.info("Saving new Vehicle. ID: {}", vehicle.getId());
        Vehicle vehicleFromDb = vehicleRepository.save(vehicle);
        vehicleRepository.save(vehicle);
    }

    /*private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }*/

    public void deleteVehicle(Long id) {
        vehicleRepository.deleteById(id);
    }

    public Vehicle getVehicleById(Long id) {
        return vehicleRepository.findById(id).orElse(null);
    }

}
