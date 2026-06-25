package com.institucion.edu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.institucion.edu.entity.Nota;
import com.institucion.edu.repository.NotaRepository;

@Service
public class NotaService {

    @Autowired
    private NotaRepository notaRepository;

    // Método para listar todas las notas registradas
    public List<Nota> listarTodas() {
        return notaRepository.findAll();
    }

    // Método principal para guardar o actualizar una nota recalculando el promedio
    public void guardar(Nota nota) {
        // Ejecutamos la fórmula matemática antes de enviar los datos a MySQL
        nota.calcularNotaFinal();
        
        // Guardamos de forma segura en la BD
        notaRepository.save(nota);
    }

    // Método para buscar una nota por su ID (útil si luego deseas editar)
    public Nota buscarPorId(int id) {
        return notaRepository.findById(id).orElse(null);
    }

    // Método para eliminar o dar de baja el registro de una nota
    public void eliminar(int id) {
        notaRepository.deleteById(id);
    }
}