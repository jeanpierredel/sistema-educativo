package com.institucion.edu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.institucion.edu.repository.AlumnoRepository;
import com.institucion.edu.repository.CursoRepository;
import com.institucion.edu.repository.DocenteRepository;
import com.institucion.edu.repository.MatriculaRepository;
import com.institucion.edu.repository.NotaRepository;
import com.institucion.edu.repository.UsuarioRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @Autowired
    private AlumnoRepository alumnoRepository;

    @Autowired
    private DocenteRepository docenteRepository;

    @Autowired
    private CursoRepository cursoRepository;

    @Autowired
    private MatriculaRepository matriculaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @Autowired
    private NotaRepository notaRepository;

    @GetMapping("/dashboard-admin")
    public String dashboardAdmin(
            HttpSession session,
            Model model) {

        if(session.getAttribute("usuarioSession") == null) {
            return "redirect:/login";
        }

        model.addAttribute("totalAlumnos",
                alumnoRepository.count());

        model.addAttribute("totalDocentes",
                docenteRepository.count());

        model.addAttribute("totalCursos",
                cursoRepository.count());

        model.addAttribute("totalMatriculas",
                matriculaRepository.count());

        model.addAttribute("totalUsuarios",
                usuarioRepository.count());
        
        model.addAttribute(
                "aprobados",
                notaRepository.contarAprobados());

        model.addAttribute(
                "desaprobados",
                notaRepository.contarDesaprobados());
        
        model.addAttribute(
                "ultimasMatriculas",
                matriculaRepository.findTop5ByOrderByIdMatriculaDesc());

        return "dashboardAdmin";
    }
}