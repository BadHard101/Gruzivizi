package com.example.gruzivizi.services;

import com.example.gruzivizi.models.Image;
import com.example.gruzivizi.models.Vehicle;
import com.example.gruzivizi.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

    /*public void saveVehicle(Principal principal, Vehicle vehicle) throws IOException {
        log.info("Saving new Vehicle. ID: {}", vehicle.getId());
        Vehicle vehicleFromDb = vehicleRepository.save(vehicle);
        vehicleRepository.save(vehicle);
    }*/

    public void saveVehicle(Principal principal, Vehicle vehicle, MultipartFile file1) throws IOException {
        Image image1;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            vehicle.addImageToVehicle(image1);
        }
        log.info("Saving new Vehicle. ID: {}", vehicle.getId());
        Vehicle vehicleFromDb = vehicleRepository.save(vehicle);
        vehicleFromDb.setPreviewImageId(vehicleFromDb.getImages().get(0).getId());
        vehicleRepository.save(vehicle);
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteVehicle(Long id) {
        vehicleRepository.deleteById(id);
    }

    public Vehicle getVehicleById(Long id) {
        return vehicleRepository.findById(id).orElse(null);
    }

}
