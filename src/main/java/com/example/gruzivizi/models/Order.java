package com.example.gruzivizi.models;

import com.example.gruzivizi.models.enums.Status;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "orders")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @Column(name = "width")
    private double width;

    @Column(name = "height")
    private double height;

    @Column(name = "weight")
    private double weight;

    @Column(name = "point_A")
    private String pointA;

    @Column(name = "point_B")
    private String pointB;

    @Column(name = "passengers")
    private int passengers;

    @Column(name = "hydroboard")
    private boolean hydroboard;

    @Column(name = "thermal_protection")
    private boolean thermalProtection;

    @Column(name = "carrier_id")
    private Long carrierId;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "order_vehicle",
            joinColumns = @JoinColumn(name = "order_id"),
            inverseJoinColumns = @JoinColumn(name = "vehicle_id")
    )
    private List<Vehicle> validateVehicles = new ArrayList<>();

    public void addVehicle(Vehicle vehicle) {
        validateVehicles.add(vehicle);
        vehicle.getOrders().add(this);
    }

    public void removeVehicle(Vehicle vehicle) {
        validateVehicles.remove(vehicle);
        vehicle.getOrders().remove(this);
    }

    @ElementCollection(targetClass = Status.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "order_status",
            joinColumns = @JoinColumn(name = "order_id"))
    @Enumerated(EnumType.STRING)
    private Set<Status> status = new HashSet<>();

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;
    private LocalDateTime dateOfCreated;

    public void setStatus(Status status) {
        this.status.clear();
        this.status.add(status);
    }

    public boolean isCreated() {
        if (status.contains(Status.CREATED)) return true;
        return false;
    }

    public boolean isProcess() {
        if (status.contains(Status.IN_PROCESS)) return true;
        return false;
    }

    public boolean isCompleted() {
        if (status.contains(Status.COMPLETED)) return true;
        return false;
    }

    @PrePersist
    private void init() {
        dateOfCreated = LocalDateTime.now();
        status.add(Status.CREATED);
    }
}
