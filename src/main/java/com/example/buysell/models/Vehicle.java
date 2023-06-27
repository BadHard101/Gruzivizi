package com.example.buysell.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "vehicles")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Vehicle {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "register_number")
    private String registerNumber;
    @Column(name = "max_passengers")
    private int maxPassengers;
    @Column(name = "max_width")
    private double maxWidth;
    @Column(name = "max_height")
    private double maxHeight;
    @Column(name = "max_weight")
    private double maxWeight;
    @Column(name = "hydroboard")
    private boolean hydroboard;
    @Column(name = "thermal_protection")
    private boolean thermalProtection;
}
