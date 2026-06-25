package com.institucion.edu.entity;

import java.util.HashSet;
import java.util.Set;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.JoinTable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.FetchType;

@Entity
@Table(name = "usuarios") // Conecta con tu tabla 'usuarios'
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private int idUsuario;

    @Column(name = "username", nullable = false, unique = true, length = 50)
    private String username;

    @Column(name = "password", nullable = false, length = 255)
    private String password;
    
    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Column(name = "activo", nullable = false)
    private int estado; // 1 = Activo, 0 = Inactivo

    // Relación Muchos a Muchos con Roles usando la tabla intermedia 'usuario_roles'
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "usuario_roles",
        joinColumns = @JoinColumn(name = "id_usuario"),
        inverseJoinColumns = @JoinColumn(name = "id_role")
    )
    private Set<Rol> roles = new HashSet<>();

    // --- CONSTRUCTORES ---
    public Usuario() {
    }

    public Usuario(int idUsuario, String username, String password, int estado) {
        this.idUsuario = idUsuario;
        this.username = username;
        this.password = password;
        this.estado = estado;
    }
    public boolean tieneRol(String nombreRol) {
        return roles.stream()
                .anyMatch(r -> r.getNombre().equalsIgnoreCase(nombreRol));
    }

    // --- GETTERS Y SETTERS ---
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Set<Rol> getRoles() {
        return roles;
    }

    public void setRoles(Set<Rol> roles) {
        this.roles = roles;
    }
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}