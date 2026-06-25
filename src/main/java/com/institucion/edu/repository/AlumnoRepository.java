package com.institucion.edu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.institucion.edu.entity.Alumno;

@Repository
public interface AlumnoRepository extends JpaRepository<Alumno, Integer> {
}