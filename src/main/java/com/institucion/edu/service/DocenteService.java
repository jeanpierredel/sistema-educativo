package com.institucion.edu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.institucion.edu.entity.Docente;
import com.institucion.edu.repository.DocenteRepository;

@Service
public class DocenteService {

    @Autowired
    private DocenteRepository docenteRepository;

    // Obtener la lista completa de profesores registrados
    public List<Docente> listarTodos() {
        return docenteRepository.findAll();
    }

    // Registrar un nuevo docente o actualizar uno existente
    public Docente guardar(Docente docente) {
        return docenteRepository.save(docente);
    }

    // Buscar un docente específico mediante su ID
    public Docente buscarPorId(int id) {
        return docenteRepository.findById(id).orElse(null);
    }

    // Eliminar un registro de la base de datos
    public void eliminar(int id) {
        docenteRepository.deleteById(id);
    }
}