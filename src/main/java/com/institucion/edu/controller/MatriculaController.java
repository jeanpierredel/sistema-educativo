package com.institucion.edu.controller;

import java.time.LocalDate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.institucion.edu.entity.Matricula;
import com.institucion.edu.entity.Usuario;
import com.institucion.edu.service.MatriculaService;
import com.institucion.edu.service.AlumnoService;
import com.institucion.edu.service.CursoService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/matriculas")
public class MatriculaController {

    @Autowired
    private MatriculaService matriculaService;

    @Autowired
    private AlumnoService alumnoService;

    @Autowired
    private CursoService cursoService;

    @GetMapping
    public String listarMatriculas(Model model, HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        // Solo ADMIN y MATRICULA
        if (!(u.tieneRol("ADMIN") || u.tieneRol("MATRICULA"))) {
            return "redirect:/dashboard";
        }

        model.addAttribute("listaAlumnos", alumnoService.listarTodos());
        model.addAttribute("listaCursos", cursoService.listarTodos());
        model.addAttribute("listaMatriculas", matriculaService.listarTodas());

        Matricula mat = new Matricula();
        mat.setFechaMatricula(LocalDate.now());

        model.addAttribute("matricula", mat);

        return "matriculas";
    }

    @PostMapping("/guardar")
    public String guardarMatricula(
            @ModelAttribute("matricula") Matricula matricula,
            HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("MATRICULA"))) {

            return "redirect:/dashboard";
        }

        try {

            if (matricula.getFechaMatricula() == null) {
                matricula.setFechaMatricula(LocalDate.now());
            }

            matricula.setEstado("ACTIVO");

            matriculaService.guardar(matricula);

        } catch (Exception e) {
            System.out.println("❌ ERROR AL GUARDAR MATRÍCULA: " + e.getMessage());
            e.printStackTrace();
        }

        return "redirect:/matriculas";
    }

    @GetMapping("/eliminar/{id}")
    public String debaBajaMatricula(
            @PathVariable("id") int id,
            HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("MATRICULA"))) {

            return "redirect:/dashboard";
        }

        matriculaService.eliminar(id);

        return "redirect:/matriculas";
    }
}