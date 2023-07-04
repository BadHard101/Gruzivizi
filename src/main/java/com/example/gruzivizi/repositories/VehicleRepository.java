package com.example.gruzivizi.repositories;

import com.example.gruzivizi.models.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {
    List<Vehicle> findVehicleByRegisterNumber(String registerNumber);
}
