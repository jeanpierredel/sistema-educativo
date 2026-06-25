package com.institucion.edu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.institucion.edu.entity.Matricula;
import com.institucion.edu.repository.MatriculaRepository;

@Service
public class MatriculaService {

    @Autowired
    private MatriculaRepository matriculaRepository;

    public List<Matricula> listarTodas() {
        return matriculaRepository.findAll();
    }

    public Matricula guardar(Matricula matricula) {
        return matriculaRepository.save(matricula);
    }

    public void eliminar(int id) {
        matriculaRepository.deleteById(id);
    }
}