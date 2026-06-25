package com.institucion.edu.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "cursos")
public class Curso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_curso")
    private int idCurso;

    @Column(name = "nombre_curso", length = 100, nullable = false)
    private String nombreCurso;

    @Column(name = "codigo_curso", length = 20, nullable = false, unique = true)
    private String codigoCurso;

    @Column(name = "creditos", nullable = false)
    private int creditos;

    // --- CONSTRUCTORES ---
    public Curso() {
    }

    public Curso(int idCurso, String nombreCurso, String codigoCurso, int creditos) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.codigoCurso = codigoCurso;
        this.creditos = creditos;
    }

    // --- GETTERS Y SETTERS ---
    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getNombreCurso() { return nombreCurso; }
    public void setNombreCurso(String nombreCurso) { this.nombreCurso = nombreCurso; }

    public String getCodigoCurso() { return codigoCurso; }
    public void setCodigoCurso(String codigoCurso) { this.codigoCurso = codigoCurso; }

    public int getCreditos() { return creditos; }
    public void setCreditos(int creditos) { this.creditos = creditos; }
}