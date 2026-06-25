package com.institucion.edu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.institucion.edu.entity.Matricula;

@Repository
public interface MatriculaRepository extends JpaRepository<Matricula, Integer> {

    List<Matricula> findTop5ByOrderByIdMatriculaDesc();

}