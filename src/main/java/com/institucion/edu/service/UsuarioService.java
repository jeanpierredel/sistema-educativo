package com.institucion.edu.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.institucion.edu.entity.Usuario;
import com.institucion.edu.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // LOGIN
    public Usuario login(String username, String password) {

        Optional<Usuario> oUsuario =
                usuarioRepository.findByUsername(username);

        if (oUsuario.isPresent()) {

            Usuario u = oUsuario.get();

            if (u.getPassword().equals(password)
                    && u.getEstado() == 1) {

                return u;
            }
        }

        return null;
    }

    // LISTAR
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    // GUARDAR
    public Usuario guardar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    // BUSCAR
    public Usuario buscarPorId(int id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    // ELIMINAR
    public void eliminar(int id) {
        usuarioRepository.deleteById(id);
    }
}