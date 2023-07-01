package com.example.gruzivizi.repositories;

import com.example.gruzivizi.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findOrderById(Long id);
}
