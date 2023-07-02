package com.example.gruzivizi.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.aspectj.weaver.ast.Or;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
    /*@Column(name = "busy")
    private boolean busy;*/

    @ManyToMany(mappedBy = "validateVehicles")
    private List<Order> orders = new ArrayList<>();
}
