<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.institucion.edu.entity.Usuario" %>
<%
Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
boolean puedeMatricular =
        usuario != null &&
        (usuario.tieneRol("ADMIN")
        || usuario.tieneRol("MATRICULA"));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Matrículas</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-success" href="${pageContext.request.contextPath}/dashboard">Sistema Educativo</a>
            <div class="navbar-nav">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/dashboard">Inicio</a>
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/cursos">Cursos</a>
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/alumnos">Alumnos</a>
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/docentes">Docentes</a>
                <a class="nav-link active fw-bold text-info" href="${pageContext.request.contextPath}/matriculas">Matrículas</a>
                <a class="nav-link text-danger ms-auto" href="${pageContext.request.contextPath}/logout">Salir</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
        <% if(puedeMatricular) { %>
            <div class="col-md-4">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="text-primary mb-3">Nueva Matrícula</h4>
                    
                    <form action="${pageContext.request.contextPath}/matriculas/guardar" method="POST">
                        
                        <div class="mb-3">
                            <label class="form-label">Seleccione Alumno</label>
                            <select class="form-select" name="alumno.idAlumno" required>
                                <option value="">-- Seleccione estudiante --</option>
                                <c:forEach var="al" items="${listaAlumnos}">
                                    <option value="${al.idAlumno}">${al.apellido}, ${al.nombre} (DNI: ${al.dni})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Seleccione Curso</label>
                            <select class="form-select" name="curso.idCurso" required>
                                <option value="">-- Seleccione asignatura --</option>
                                <c:forEach var="cu" items="${listaCursos}">
                                    <option value="${cu.idCurso}">${cu.nombreCurso} [Créditos: ${cu.creditos}]</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Fecha de Matrícula</label>
                            <input type="date" class="form-control" name="fechaMatricula" value="${matricula.fechaMatricula}" required>
                        </div>
						
						<div class="mb-3">
						    <label for="cicloAcademico" class="form-label">Ciclo Académico</label>
						    <input type="text" class="form-control" id="cicloAcademico" name="cicloAcademico" placeholder="Ej: 2026-II" required="required" />
						</div>

                        <button type="submit" class="btn btn-primary w-100 fw-bold">Confirmar e Inscribir</button>
                    </form>
                </div>
            </div>
<% } %>
           <div class="<%= puedeMatricular ? "col-md-8" : "col-md-12" %>">
                <div class="card shadow-sm p-4 border-0">
                    <h4 class="text-muted mb-3">Historial de Matrículas Activas</h4>
                    <table class="table table-hover align-middle">
						<thead class="table-dark">
						    <tr>
						        <th>N° Operación</th>
						        <th>Alumno</th>
						        <th>Curso Matriculado</th>
						        <th>Fecha Registro</th>
						        <th>Ciclo</th> <th>Estado</th>
						        <th class="text-center">Acción</th>
						    </tr>
						</thead>
						<tbody>
						    <c:forEach var="m" items="${listaMatriculas}">
						        <tr>
						            <td>${m.idMatricula}</td>
						            <td class="fw-semibold">${m.alumno.apellido}, ${m.alumno.nombre}</td>
						            <td><span class="badge bg-info text-dark">${m.curso.nombreCurso}</span></td>
						            <td>${m.fechaMatricula}</td>
						            
						            <td><span class="badge bg-light text-dark border">${m.cicloAcademico}</span></td> <td><span class="badge bg-success">${m.estado}</span></td>
						           <td class="text-center">

   <% if(puedeMatricular) { %>

    <button
        class="btn btn-sm btn-outline-danger"
        onclick="confirmarEliminar(
        '${pageContext.request.contextPath}/matriculas/eliminar/${m.idMatricula}',
        'Matrícula N° ${m.idMatricula}'
        )">

        Retirar

    </button>

<% } else { %>

    <span class="text-muted">Sin permiso</span>

<% } %>

</td>
						        </tr>
						    </c:forEach>
						    </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

function confirmarEliminar(url,nombre){

    Swal.fire({
        title: '¿ESTÁS SEGURO DE ELIMINAR ESTE REGISTRO?',
        html: '<b>'+nombre+'</b><br>No podrás revertir esta acción',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#dc3545',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result)=>{

        if(result.isConfirmed){
            window.location.href = url;
        }

    });

}

</script>
</body>
</html>