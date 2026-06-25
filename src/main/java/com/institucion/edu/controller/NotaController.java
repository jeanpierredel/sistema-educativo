package com.institucion.edu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.institucion.edu.entity.Usuario;
import com.institucion.edu.entity.Nota;
import com.institucion.edu.service.NotaService;
import com.institucion.edu.service.AlumnoService;
import com.institucion.edu.service.CursoService;
import com.institucion.edu.service.DocenteService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notas")
public class NotaController {

    @Autowired
    private NotaService notaService;

    @Autowired
    private AlumnoService alumnoService;

    @Autowired
    private CursoService cursoService;

    @Autowired
    private DocenteService docenteService;

    // 1. Cargar la pantalla principal de gestión de notas
    @GetMapping
    public String listarNotas(Model model, HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("DOCENTE")
        	 	|| u.tieneRol("ALUMNO"))){

            return "redirect:/dashboard";
        }

        // Enviamos los catálogos para llenar los selectores dinámicos (ComboBoxes)
        model.addAttribute("listaAlumnos", alumnoService.listarTodos());
        model.addAttribute("listaCursos", cursoService.listarTodos());
        model.addAttribute("listaDocentes", docenteService.listarTodos());
        
        // Enviamos el historial de calificaciones registradas
        model.addAttribute("listaNotas", notaService.listarTodas());
        
        // Enviamos un objeto vacío como plantilla para el formulario de registro
        model.addAttribute("nota", new Nota());

        return "notas"; // Apunta a views/notas.jsp
    }

    // 2. Procesar el formulario de guardado
    @PostMapping("/guardar")
    public String guardarNota(
            @ModelAttribute("nota") Nota nota,
            HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("DOCENTE"))) {

            return "redirect:/dashboard";
        }
        try {
            // El servicio invocará automáticamente la fórmula matemática del promedio antes de persistir
            notaService.guardar(nota);
        } catch (Exception e) {
            System.out.println("❌ ERROR AL GUARDAR CALIFICACIÓN: " + e.getMessage());
            e.printStackTrace();
        }
        return "redirect:/notas";
    }

    // 3. Eliminar una calificación por su ID
    @GetMapping("/eliminar/{id}")
    public String eliminarNota(@PathVariable("id") int id,
                               HttpSession session) {

        Usuario u = (Usuario) session.getAttribute("usuarioSession");

        if (u == null) {
            return "redirect:/login";
        }

        if (!(u.tieneRol("ADMIN")
                || u.tieneRol("DOCENTE"))) {

            return "redirect:/dashboard";
        }
        try {
            notaService.eliminar(id);
        } catch (Exception e) {
            System.out.println("❌ ERROR AL ELIMINAR NOTA: " + e.getMessage());
        }
        return "redirect:/notas";
    }
}