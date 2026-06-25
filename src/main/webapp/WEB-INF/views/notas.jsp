<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.institucion.edu.entity.Usuario" %>
<%
Usuario usuario = (Usuario) session.getAttribute("usuarioSession");

boolean puedeGestionarNotas =
        usuario != null &&
        (usuario.tieneRol("ADMIN")
        || usuario.tieneRol("DOCENTE"));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Calificaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/matriculas">Matrículas</a>
                <a class="nav-link active fw-bold text-info" href="${pageContext.request.contextPath}/notas">Notas</a>
                <a class="nav-link text-danger ms-auto" href="${pageContext.request.contextPath}/logout">Salir</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-4">
        <div class="row">
        <% if(puedeGestionarNotas) { %>
            <div class="col-md-4">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="text-primary mb-3">Ingreso de Notas</h4>
                    
                    <form action="${pageContext.request.contextPath}/notas/guardar" method="POST">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Estudiante</label>
                            <select class="form-select" name="alumno.idAlumno" required>
                                <option value="">-- Seleccione Alumno --</option>
                                <c:forEach var="al" items="${listaAlumnos}">
                                    <option value="${al.idAlumno}">${al.apellido}, ${al.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Curso / Asignatura</label>
                            <select class="form-select" name="curso.idCurso" required>
                                <option value="">-- Seleccione Curso --</option>
                                <c:forEach var="cu" items="${listaCursos}">
                                    <option value="${cu.idCurso}">${cu.nombreCurso}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Docente Evaluador</label>
                            <select class="form-select" name="docente.idDocente" required>
                                <option value="">-- Seleccione Docente --</option>
                                <c:forEach var="doc" items="${listaDocentes}">
                                    <option value="${doc.idDocente}">${doc.apellido}, ${doc.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Parcial</label>
                                <input type="number" class="form-control" name="parcial" min="0" max="20" step="0.1" placeholder="0-20" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Final</label>
                                <input type="number" class="form-control" name="nFinal" min="0" max="20" step="0.1" placeholder="0-20" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Labs</label>
                                <input type="number" class="form-control" name="labs" min="0" max="20" step="0.1" placeholder="0-20" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-info text-white w-100 fw-bold mt-2">Registrar Calificaciones</button>
                    </form>
                </div>
            </div>
<% } %>
           <div class="<%= puedeGestionarNotas ? "col-md-8" : "col-md-12" %>">
                <div class="card shadow-sm p-4 border-0">
                    <h4 class="text-muted mb-3">Registro de Calificaciones Actuales</h4>
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Alumno</th>
                                <th>Curso</th>
                                <th>Docente</th>
                                <th class="text-center">Parcial</th>
                                <th class="text-center">Final</th>
                                <th class="text-center">Labs</th>
                                <th class="text-center">Nota Final</th>
                                <th class="text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="n" items="${listaNotas}">
                                <tr>
                                    <td>${n.idNota}</td>
                                    <td class="fw-semibold">${n.alumno.apellido}, ${n.alumno.nombre}</td>
                                    <td><span class="badge bg-secondary">${n.curso.nombreCurso}</span></td>
                                    <td><small class="text-muted">${n.docente.apellido}, ${n.docente.nombre}</small></td>
                                    <td class="text-center">${n.parcial}</td>
                                    <td class="text-center">${n.getnFinal()}</td>
                                    <td class="text-center">${n.labs}</td>
                                    <td class="text-center">
                                        <span class="badge ${n.notaFinal >= 10.5 ? 'bg-primary' : 'bg-danger'} fs-6 px-3">
                                            ${n.notaFinal}
                                        </span>
                                    </td>
                                    <td class="text-center">

    <% if(puedeGestionarNotas) { %>

        <button class="btn btn-danger btn-sm"
		onclick="confirmarEliminar(
		'${pageContext.request.contextPath}/notas/eliminar/${n.idNota}',
		'Nota #' + '${n.idNota}'
		)">
		Eliminar
		</button>

    <% } else { %>

        <span class="text-muted">Sin permiso</span>

    <% } %>

</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaNotas}">
                                <tr>
                                    <td colspan="9" class="text-center text-muted py-3">No hay calificaciones registradas en este periodo académico.</td>
                                </tr>
                            </c:if>
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