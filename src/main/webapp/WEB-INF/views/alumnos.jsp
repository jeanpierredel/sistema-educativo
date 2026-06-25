<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.institucion.edu.entity.Usuario" %>

<%
Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
boolean esAdmin = usuario != null && usuario.tieneRol("ADMIN");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mantenimiento de Alumnos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-success" href="${pageContext.request.contextPath}/dashboard">Sistema Educativo</a>
            <div class="navbar-nav">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/dashboard">Inicio</a>
                <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/cursos">Cursos</a>
                <a class="nav-link active fw-bold text-info" href="${pageContext.request.contextPath}/alumnos">Alumnos</a>
                <a class="nav-link text-danger ms-auto" href="${pageContext.request.contextPath}/logout">Salir</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
        <% if(esAdmin) { %>
            <div class="col-md-4">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="text-primary mb-3">${alumno.idAlumno == 0 ? 'Registrar Alumno' : 'Modificar Alumno'}</h4>
                    
                    <form action="${pageContext.request.contextPath}/alumnos/guardar" method="POST">
                        <input type="hidden" name="idAlumno" value="${alumno.idAlumno}">

                        <div class="mb-3">
                            <label class="form-label">DNI</label>
                            <input type="text" class="form-control" name="dni" value="${alumno.dni}" maxlength="8" placeholder="8 dígitos" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <input type="text" class="form-control" name="nombre" value="${alumno.nombre}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido</label>
                            <input type="text" class="form-control" name="apellido" value="${alumno.apellido}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fecha de Nacimiento</label>
                            <input type="date" class="form-control" name="fechaNacimiento" value="${alumno.fechaNacimiento}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Teléfono</label>
                            <input type="text" class="form-control" name="telefono" value="${alumno.telefono}">
                        </div>

                        <button type="submit" class="btn ${alumno.idAlumno == 0 ? 'btn-success' : 'btn-warning'} w-100">
                            ${alumno.idAlumno == 0 ? 'Guardar Nuevo' : 'Actualizar Cambios'}
                        </button>
                        <c:if test="${alumno.idAlumno != 0}">
                            <a href="${pageContext.request.contextPath}/alumnos" class="btn btn-secondary w-100 mt-2">Cancelar</a>
                        </c:if>
                    </form>
                </div>
            </div>
<% } %>
           <div class="<%= esAdmin ? "col-md-8" : "col-md-12" %>">
                <div class="card shadow-sm p-4 border-0">
                    <h4 class="text-muted mb-3">Listado de Alumnos</h4>
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>DNI</th>
                                <th>Datos Completos</th>
                                <th>F. Nacimiento</th>
                                <th>Teléfono</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${listaAlumnos}">
                                <tr>
                                    <td>${a.idAlumno}</td>
                                    <td><span class="badge bg-secondary">${a.dni}</span></td>
                                    <td class="fw-semibold">${a.apellido}, ${a.nombre}</td>
                                    <td>${a.fechaNacimiento}</td>
                                    <td>${a.telefono != null ? a.telefono : '-'}</td>
                                    <td class="text-center">

    <% if(esAdmin) { %>

        <a href="${pageContext.request.contextPath}/alumnos/editar/${a.idAlumno}"
           class="btn btn-sm btn-outline-warning me-1">
            Editar
        </a>

        <button class="btn btn-danger btn-sm"
			onclick="confirmarEliminar(
			'${pageContext.request.contextPath}/alumnos/eliminar/${a.idAlumno}',
			'${a.nombre} ${a.apellido}'
				)">
			Eliminar
			</button>

    <% } else { %>

        <span class="text-muted">Solo lectura</span>

    <% } %>

</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaAlumnos}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-3">No hay alumnos registrados.</td>
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