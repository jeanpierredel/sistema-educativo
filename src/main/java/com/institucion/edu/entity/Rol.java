package com.institucion.edu.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "roles") // Conecta con tu tabla 'roles'
public class Rol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_role") // Coincide con la columna id_role de tu BD
    private int idRole;

    @Column(name = "nombre", nullable = false, length = 50) // Coincide con la columna nombre
    private String nombre;

    // --- CONSTRUCTORES ---
    public Rol() {
    }

    public Rol(int idRole, String nombre) {
        this.idRole = idRole;
        this.nombre = nombre;
    }

    // --- GETTERS Y SETTERS ---
    public int getIdRole() {
        return idRole;
    }

    public void setIdRole(int idRole) {
        this.idRole = idRole;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}