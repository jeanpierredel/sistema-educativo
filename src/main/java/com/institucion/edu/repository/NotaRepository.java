package com.institucion.edu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.institucion.edu.entity.Nota;

@Repository
public interface NotaRepository extends JpaRepository<Nota, Integer> {

    @Query("SELECT COUNT(n) FROM Nota n WHERE n.notaFinal >= 11")
    Long contarAprobados();

    @Query("SELECT COUNT(n) FROM Nota n WHERE n.notaFinal < 11")
    Long contarDesaprobados();
}