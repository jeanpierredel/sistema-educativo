package com.institucion.edu.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.institucion.edu.entity.Docente;
import com.institucion.edu.service.DocenteService; // Asegúrate de crear o tener este servicio implementado de igual forma
import jakarta.servlet.http.HttpSession;
import com.institucion.edu.entity.Usuario;

@Controller
@RequestMapping("/docentes")
public class DocenteController {

    @Autowired
    private DocenteService docenteService;

    @GetMapping
    public String listarDocentes(Model model, HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("DOCENTE"))) {

            return "redirect:/dashboard";
        }

        List<Docente> lista = docenteService.listarTodos();

        model.addAttribute("listaDocentes", lista);
        model.addAttribute("docente", new Docente());

        return "docentes";
    }

    @PostMapping("/guardar")
    public String guardarDocente(
            @ModelAttribute("docente") Docente docente,
            HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!u.tieneRol("ADMIN")) {
            return "redirect:/dashboard";
        }

        docenteService.guardar(docente);

        return "redirect:/docentes";
    }

    @GetMapping("/editar/{id}")
    public String editarDocente(@PathVariable("id") int id,
                                Model model,
                                HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!u.tieneRol("ADMIN")) {
            return "redirect:/dashboard";
        }
        
        Docente docente = docenteService.buscarPorId(id);
        List<Docente> lista = docenteService.listarTodos();
        
        model.addAttribute("listaDocentes", lista);
        model.addAttribute("docente", docente);
        return "docentes";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarDocente(@PathVariable("id") int id,
                                  HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!u.tieneRol("ADMIN")) {
            return "redirect:/dashboard";
        }

        docenteService.eliminar(id);

        return "redirect:/docentes";
    }
}