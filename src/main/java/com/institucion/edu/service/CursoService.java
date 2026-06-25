package com.institucion.edu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.institucion.edu.entity.Curso;
import com.institucion.edu.repository.CursoRepository;

@Service
public class CursoService {

    @Autowired
    private CursoRepository cursoRepository;

    public List<Curso> listarTodos() {
        return cursoRepository.findAll();
    }

    public Curso guardar(Curso curso) {
        return cursoRepository.save(curso);
    }

    public Curso buscarPorId(int id) {
        return cursoRepository.findById(id).orElse(null);
    }

    public void eliminar(int id) {
        cursoRepository.deleteById(id);
    }
}