package com.institucion.edu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.institucion.edu.entity.Usuario;
import com.institucion.edu.service.UsuarioService;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/")
    public String raiz() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    // Procesa los datos cuando se presiona el botón "Ingresar"
    @PostMapping("/login")
    public String procesarLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {
        
        Usuario usuarioLogueado = usuarioService.login(username, password);
        
        if (usuarioLogueado != null) {
            // Guardamos el usuario en la sesión del navegador para saber quién entró
            session.setAttribute("usuarioSession", usuarioLogueado);
            return "redirect:/dashboard"; // Te mandará al menú principal si es correcto
        } else {
            // Si las credenciales fallan, mandamos un mensaje de error a la vista
            model.addAttribute("error", "Usuario o contraseña incorrectos, o cuenta inactiva.");
            return "login";
        }
    }

    // Ruta provisional para el Dashboard (Menú Principal)
    @GetMapping("/dashboard")
    public String mostrarDashboard(HttpSession session) {
        if (session.getAttribute("usuarioSession") == null) {
            return "redirect:/login"; // Bloqueo de seguridad elemental si no se ha logueado
        }
        return "dashboard"; // Buscará dashboard.jsp
    }

    // Cierre de sesión
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Destruye la sesión
        return "redirect:/login";
    }
}