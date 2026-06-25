package com.institucion.edu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.institucion.edu.entity.Curso;

@Repository
public interface CursoRepository extends JpaRepository<Curso, Integer> {
}