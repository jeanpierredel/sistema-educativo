package com.institucion.edu.controller;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.institucion.edu.entity.Rol;
import com.institucion.edu.entity.Usuario;
import com.institucion.edu.repository.RolRepository;
import com.institucion.edu.service.UsuarioService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private RolRepository rolRepository;

    @GetMapping
    public String listarUsuarios(Model model,
                                 HttpSession session) {

        Usuario u =
            (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("SOPORTE"))) {

            return "redirect:/dashboard";
        }

        model.addAttribute(
                "usuarios",
                usuarioService.listarTodos());

        model.addAttribute(
                "roles",
                rolRepository.findAll());

        return "usuarios";
    }

    @PostMapping("/guardar")
    public String guardarUsuario(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String email,
            @RequestParam Integer idRol,
            HttpSession session) {

        Usuario u =
            (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("SOPORTE"))) {

            return "redirect:/dashboard";
        }

        Usuario nuevo = new Usuario();

        nuevo.setUsername(username);
        nuevo.setPassword(password);
        nuevo.setEmail(email);
        nuevo.setEstado(1);

        Rol rol = rolRepository.findById(idRol)
                .orElse(null);

        Set<Rol> roles = new HashSet<>();

        if (rol != null) {
            roles.add(rol);
        }

        nuevo.setRoles(roles);

        usuarioService.guardar(nuevo);

        return "redirect:/usuarios";
    }
    
    @GetMapping("/eliminar/{id}")
    public String eliminarUsuario(@PathVariable("id") int id,
                                  HttpSession session) {

        Usuario u =
            (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("SOPORTE"))) {

            return "redirect:/dashboard";
        }

        usuarioService.eliminar(id);

        return "redirect:/usuarios";
    }
}