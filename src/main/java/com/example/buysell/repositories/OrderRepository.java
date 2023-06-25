package com.example.buysell.repositories;

import com.example.buysell.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findOrderById(Long id);
}
