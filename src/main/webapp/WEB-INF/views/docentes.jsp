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
    <title>Mantenimiento de Docentes</title>
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
                <a class="nav-link active fw-bold text-info" href="${pageContext.request.contextPath}/docentes">Docentes</a>
                <a class="nav-link text-danger ms-auto" href="${pageContext.request.contextPath}/logout">Salir</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
        <% if(esAdmin) { %>
            <div class="col-md-4">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="text-primary mb-3">${docente.idDocente == 0 ? 'Registrar Docente' : 'Modificar Docente'}</h4>
                    
                    <form action="${pageContext.request.contextPath}/docentes/guardar" method="POST">
                        <input type="hidden" name="idDocente" value="${docente.idDocente}">

                        <div class="mb-3">
                            <label class="form-label">DNI</label>
                            <input type="text" class="form-control" name="dni" value="${docente.dni}" maxlength="8" placeholder="8 dígitos" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <input type="text" class="form-control" name="nombre" value="${docente.nombre}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Apellido</label>
                            <input type="text" class="form-control" name="apellido" value="${docente.apellido}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Especialidad</label>
                            <input type="text" class="form-control" name="especialidad" value="${docente.especialidad}" placeholder="Ej: Ingeniería de Software" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Teléfono</label>
                            <input type="text" class="form-control" name="telefono" value="${docente.telefono}">
                        </div>

                        <button type="submit" class="btn ${docente.idDocente == 0 ? 'btn-success' : 'btn-warning'} w-100">
                            ${docente.idDocente == 0 ? 'Guardar Nuevo' : 'Actualizar Cambios'}
                        </button>
                        <c:if test="${docente.idDocente != 0}">
                            <a href="${pageContext.request.contextPath}/docentes" class="btn btn-secondary w-100 mt-2">Cancelar</a>
                        </c:if>
                    </form>
                </div>
            </div>
<% } %>
           <div class="<%= esAdmin ? "col-md-8" : "col-md-12" %>">
                <div class="card shadow-sm p-4 border-0">
                    <h4 class="text-muted mb-3">Listado de Docentes</h4>
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>DNI</th>
                                <th>Profesor</th>
                                <th>Especialidad</th>
                                <th>Teléfono</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="d" items="${listaDocentes}">
                                <tr>
                                    <td>${d.idDocente}</td>
                                    <td><span class="badge bg-secondary">${d.dni}</span></td>
                                    <td class="fw-semibold">${d.apellido}, ${d.nombre}</td>
                                    <td><span class="text-primary">${d.especialidad}</span></td>
                                    <td>${d.telefono != null ? d.telefono : '-'}</td>
                                  <td class="text-center">

    <% if(esAdmin) { %>

        <a href="${pageContext.request.contextPath}/docentes/editar/${d.idDocente}"
           class="btn btn-sm btn-outline-warning me-1">
            Editar
        </a>

        <button class="btn btn-danger btn-sm"
		onclick="confirmarEliminar(
		'${pageContext.request.contextPath}/docentes/eliminar/${d.idDocente}',
		'${d.nombre} ${d.apellido}'
		)">
		Eliminar
		</button>

    <% } else { %>

        <span class="text-muted">Solo lectura</span>

    <% } %>

</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaDocentes}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-3">No hay docentes registrados en la institución.</td>
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