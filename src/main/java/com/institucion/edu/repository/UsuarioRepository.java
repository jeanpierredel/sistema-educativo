package com.institucion.edu.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.institucion.edu.entity.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    
    // Método personalizado para buscar un usuario por su 'username' en el Login
    Optional<Usuario> findByUsername(String username);
}