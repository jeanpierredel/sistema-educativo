package com.institucion.edu.entity;

import java.time.LocalDate;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.JoinColumn;

@Entity
@Table(name = "matriculas")
public class Matricula {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_matricula")
    private int idMatricula;

    @ManyToOne
    @JoinColumn(name = "id_alumno", nullable = false)
    private Alumno alumno;

    @ManyToOne
    @JoinColumn(name = "id_curso", nullable = false)
    private Curso curso;

    @Column(name = "fecha_matricula", nullable = false)
    private LocalDate fechaMatricula;

    @Column(name = "estado", length = 20, nullable = false)
    private String estado;

    // 👈 NUEVO CAMPO OBLIGATORIO DETECTADO EN TU BD
    @Column(name = "ciclo_academico", length = 20, nullable = false)
    private String cicloAcademico;

    // --- CONSTRUCTORES ---
    public Matricula() {
    }

    public Matricula(int idMatricula, Alumno alumno, Curso curso, LocalDate fechaMatricula, String estado, String cicloAcademico) {
        this.idMatricula = idMatricula;
        this.alumno = alumno;
        this.curso = curso;
        this.fechaMatricula = fechaMatricula;
        this.estado = estado;
        this.cicloAcademico = cicloAcademico;
    }

    // --- GETTERS Y SETTERS ---
    public int getIdMatricula() { return idMatricula; }
    public void setIdMatricula(int idMatricula) { this.idMatricula = idMatricula; }

    public Alumno getAlumno() { return alumno; }
    public void setAlumno(Alumno alumno) { this.alumno = alumno; }

    public Curso getCurso() { return curso; }
    public void setCurso(Curso curso) { this.curso = curso; }

    public LocalDate getFechaMatricula() { return fechaMatricula; }
    public void setFechaMatricula(LocalDate fechaMatricula) { this.fechaMatricula = fechaMatricula; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    // 👈 NUEVOS GETTER Y SETTER
    public String getCicloAcademico() { return cicloAcademico; }
    public void setCicloAcademico(String cicloAcademico) { this.cicloAcademico = cicloAcademico; }
}