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
    <title>Mantenimiento de Cursos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-success" href="${pageContext.request.contextPath}/dashboard">Sistema Educativo</a>
            <div class="navbar-nav">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/dashboard">Inicio</a>
                <a class="nav-link active fw-bold text-info" href="${pageContext.request.contextPath}/cursos">Cursos</a>
                <a class="nav-link text-white-50" href="#">Alumnos</a>
                <a class="nav-link text-danger ms-auto" href="${pageContext.request.contextPath}/logout">Salir</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row">
        <% if(esAdmin) { %>
            <div class="col-md-4">
                <div class="card shadow-sm p-4 border-0 mb-4">
                    <h4 class="text-primary mb-3">${curso.idCurso == 0 ? 'Registrar Curso' : 'Modificar Curso'}</h4>
                    
                    <form action="${pageContext.request.contextPath}/cursos/guardar" method="POST">
                        <input type="hidden" name="idCurso" value="${curso.idCurso}">

                        <div class="mb-3">
                            <label class="form-label">Código del Curso</label>
                            <input type="text" class="form-control" name="codigoCurso" value="${curso.codigoCurso}" placeholder="Ej: CUR-001" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Nombre del Curso</label>
                            <input type="text" class="form-control" name="nombreCurso" value="${curso.nombreCurso}" placeholder="Ej: Programación II" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Créditos</label>
                            <input type="number" class="form-control" name="creditos" value="${curso.creditos}" min="1" max="10" placeholder="Ej: 4" required>
                        </div>

                        <button type="submit" class="btn ${curso.idCurso == 0 ? 'btn-success' : 'btn-warning'} w-100">
                            ${curso.idCurso == 0 ? 'Guardar Nuevo' : 'Actualizar Cambios'}
                        </button>
                        <c:if test="${curso.idCurso != 0}">
                            <a href="${pageContext.request.contextPath}/cursos" class="btn btn-secondary w-100 mt-2">Cancelar</a>
                        </c:if>
                    </form>
                </div>
            </div>
<% } %>
            <div class="<%= esAdmin ? "col-md-8" : "col-md-12" %>">
                <div class="card shadow-sm p-4 border-0">
                    <h4 class="text-muted mb-3">Listado de Cursos Registrados</h4>
                    <table class="table table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Créditos</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${listaCursos}">
                                <tr>
                                    <td>${c.idCurso}</td>
                                    <td><span class="badge bg-secondary">${c.codigoCurso}</span></td>
                                    <td class="fw-semibold">${c.nombreCurso}</td>
                                    <td>${c.creditos}</td>
                                   <td class="text-center">

    <% if(esAdmin) { %>

        <a href="${pageContext.request.contextPath}/cursos/editar/${c.idCurso}"
           class="btn btn-sm btn-outline-warning me-1">
            Editar
        </a>

        <button class="btn btn-danger btn-sm"
		onclick="confirmarEliminar(
		'${pageContext.request.contextPath}/cursos/eliminar/${c.idCurso}',
		'${c.nombreCurso}'
		)">
		Eliminar
		</button>

    <% } else { %>

        <span class="text-muted">Solo lectura</span>

    <% } %>

</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listaCursos}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-3">No hay cursos registrados en el sistema.</td>
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