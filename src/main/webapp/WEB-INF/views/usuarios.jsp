<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Usuarios</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>

body{
    background:#f4f7fc;
    font-family:'Segoe UI',sans-serif;
}

.card-custom{
    border:none;
    border-radius:20px;
    box-shadow:0 4px 15px rgba(0,0,0,.08);
}

.top-title{
    color:#2563eb;
    font-weight:bold;
}

</style>

</head>
<body>

<div class="container mt-4">

    <div class="card card-custom p-4 mb-4">

        <h2 class="top-title">
            👥 Gestión de Usuarios
        </h2>

        <p class="text-muted">
            Registrar usuarios y asignar roles.
        </p>

    </div>

    <!-- FORMULARIO -->

    <div class="card card-custom p-4 mb-4">

        <h4 class="mb-3">
            Nuevo Usuario
        </h4>

        <form action="${pageContext.request.contextPath}/usuarios/guardar"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Usuario
                </label>

                <input type="text"
                       name="username"
                       class="form-control"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Contraseña
                </label>

                <input type="password"
                       name="password"
                       class="form-control"
                       required>

            </div>
            
            <div class="mb-3">

    <label class="form-label">
        Correo Electrónico
    </label>

    <input type="email"
           name="email"
           class="form-control"
           required>

</div>

            <div class="mb-3">

                <label class="form-label">
                    Rol
                </label>

                <select name="idRol"
                        class="form-select">

                    <c:forEach items="${roles}" var="r">

                        <option value="${r.idRole}">
                            ${r.nombre}
                        </option>

                    </c:forEach>

                </select>

            </div>

            <button type="submit"
                    class="btn btn-success">

                Registrar Usuario

            </button>

            <a href="${pageContext.request.contextPath}/dashboard"
               class="btn btn-secondary">

                Volver

            </a>

        </form>

    </div>

    <!-- TABLA -->

    <div class="card card-custom p-4">

        <h4 class="mb-3">
            Usuarios Registrados
        </h4>

        <table class="table table-striped">

            <thead class="table-dark">

                <tr>
                    <tr>
   							 <th>ID</th>
    						<th>Usuario</th>
   							 <th>Estado</th>
   							 <th>Roles</th>
   							<th>Acciones</th>
						</tr>
               

            </thead>

            <tbody>

                <c:forEach items="${usuarios}" var="u">

                    <tr>

                        <td>${u.idUsuario}</td>

                        <td>${u.username}</td>

                        <td>

                            <c:choose>

                                <c:when test="${u.estado == 1}">
                                    <span class="badge bg-success">
                                        Activo
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge bg-danger">
                                        Inactivo
                                    </span>
                                </c:otherwise>

                            </c:choose>

                        </td>

                        <td>

                            <c:forEach items="${u.roles}" var="rol">

                                <span class="badge bg-primary">

                                    ${rol.nombre}

                                </span>

                            </c:forEach>

                        </td>
   <td>

    <c:if test="${u.idUsuario != 1}">

        <button
    class="btn btn-danger btn-sm"
    onclick="confirmarEliminacion(${u.idUsuario}, '${u.username}')">

    Eliminar

</button>

    </c:if>

    <c:if test="${u.idUsuario == 1}">

        <span class="badge bg-secondary">
            Protegido
        </span>

    </c:if>

</td>

                    </tr>

                </c:forEach>
<script>

function confirmarEliminacion(id, usuario){

    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Se eliminará el usuario: ' + usuario,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#0d6efd',
        cancelButtonColor: '#dc3545',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {

        if(result.isConfirmed){

            window.location.href =
                '${pageContext.request.contextPath}/usuarios/eliminar/' + id;

        }

    });

}

</script>
            </tbody>

        </table>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>