package com.example.buysell.repositories;

import com.example.buysell.models.Order;
import com.example.buysell.models.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
    List<Vehicle> findVehicleById(Long id);
    List<Vehicle> findVehicleByRegisterNumber(String registerNumber);
}
