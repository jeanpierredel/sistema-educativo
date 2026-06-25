package com.institucion.edu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.institucion.edu.entity.Docente;

@Repository
public interface DocenteRepository extends JpaRepository<Docente, Integer> {
}