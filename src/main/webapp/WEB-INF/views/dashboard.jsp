<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.institucion.edu.entity.Usuario" %>
<!DOCTYPE html>
<%
Usuario u = (Usuario) session.getAttribute("usuarioSession");

if (u == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema Educativo - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
body{
    background:#f4f7fc;
    font-family:'Segoe UI',sans-serif;
}

.topbar{
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:white;
    padding:15px 30px;
    border-radius:15px;
    margin-bottom:25px;
}

.dashboard-card{
    border:none;
    border-radius:20px;
    transition:.3s;
    box-shadow:0 4px 12px rgba(0,0,0,.08);
    height:100%;
}

.dashboard-card:hover{
    transform:translateY(-8px);
    box-shadow:0 12px 25px rgba(0,0,0,.15);
}

.icon{
    font-size:55px;
}

.welcome-box{
    background:white;
    border-radius:20px;
    padding:30px;
    margin-bottom:25px;
    box-shadow:0 4px 15px rgba(0,0,0,.08);
}

.logout-btn{
    border-radius:12px;
}
</style>
</head>
<body>

<div class="container mt-4">

    <!-- Barra Superior -->
    <div class="topbar d-flex justify-content-between align-items-center">

        <div>
            <h3 class="mb-0">🎓 Sistema Educativo</h3>
        </div>

        <div>
            Bienvenido: <strong><%= u.getUsername() %></strong>

            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-danger btn-sm ms-3 logout-btn">
                Cerrar Sesión
            </a>
        </div>

    </div>

    <!-- Bienvenida -->
    <div class="welcome-box">

        <h1 class="fw-bold text-success">
            ¡Bienvenido al Sistema Educativo!
        </h1>

        <p class="fs-5 text-muted">
            Gestiona alumnos, docentes, cursos, matrículas y notas
            desde un único panel de control.
        </p>

    </div>

    <div class="row g-4">

        <% if (u.tieneRol("ADMIN")) { %>

        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">📚</div>
                <h4>Cursos</h4>
                <a href="${pageContext.request.contextPath}/cursos"
                   class="btn btn-primary mt-3">
                   Gestionar
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">👨‍🎓</div>
                <h4>Alumnos</h4>
                <a href="${pageContext.request.contextPath}/alumnos"
                   class="btn btn-info text-white mt-3">
                   Gestionar
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">👨‍🏫</div>
                <h4>Docentes</h4>
                <a href="${pageContext.request.contextPath}/docentes"
                   class="btn btn-success mt-3">
                   Gestionar
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">📝</div>
                <h4>Matrículas</h4>
                <a href="${pageContext.request.contextPath}/matriculas"
                   class="btn btn-warning text-white mt-3">
                   Ingresar
                </a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">📊</div>
                <h4>Notas</h4>
                <a href="${pageContext.request.contextPath}/notas"
                   class="btn btn-secondary mt-3">
                   Ingresar
                </a>
            </div>
        </div>
        
        <div class="col-md-4">
   			 <div class="card dashboard-card p-4 text-center">

       		 <div class="icon">👥</div>

       		 <h4>Usuarios</h4>

        		<a href="${pageContext.request.contextPath}/usuarios"
          		 class="btn btn-dark mt-3">

           			 Gestionar

       		 </a>

   		 </div>
		</div>
		
		<div class="col-md-4">
    <div class="card dashboard-card p-4 text-center">

        <div class="icon">📊</div>

        <h4>Dashboard Ejecutivo</h4>

        <a href="${pageContext.request.contextPath}/dashboard-admin"
           class="btn btn-dark mt-3">

            Ver Estadísticas

        </a>

    </div>
</div>

        <% } %>

        <% if (u.tieneRol("DOCENTE")) { %>

        <div class="col-md-6">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">📊</div>
                <h4>Registro de Notas</h4>
                <a href="${pageContext.request.contextPath}/notas"
                   class="btn btn-secondary mt-3">
                   Ingresar
                </a>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card dashboard-card p-4 text-center">
                <div class="icon">📚</div>
                <h4>Cursos Asignados</h4>
                <a href="${pageContext.request.contextPath}/cursos"
                   class="btn btn-primary mt-3">
                   Consultar
                </a>
            </div>
        </div>

        <% } %> 

       <% if (u.tieneRol("MATRICULA")) { %>

<!-- Alumnos -->
<div class="col-md-4">
    <div class="card dashboard-card p-4 text-center">
        <div class="icon">👨‍🎓</div>
        <h4>Alumnos</h4>

        <a href="${pageContext.request.contextPath}/alumnos"
           class="btn btn-info text-white mt-3">
           Consultar
        </a>
    </div>
</div>

<!-- Cursos -->
<div class="col-md-4">
    <div class="card dashboard-card p-4 text-center">
        <div class="icon">📚</div>
        <h4>Cursos</h4>

        <a href="${pageContext.request.contextPath}/cursos"
           class="btn btn-primary mt-3">
           Consultar
        </a>
    </div>
</div>

<!-- Matrículas -->
<div class="col-md-4">
    <div class="card dashboard-card p-4 text-center">
        <div class="icon">📝</div>
        <h4>Matrículas</h4>

        <a href="${pageContext.request.contextPath}/matriculas"
           class="btn btn-warning text-white mt-3">
           Ingresar
        </a>
    </div>
</div>

<% } %>



      <% if (u.tieneRol("SOPORTE")) { %>

<div class="col-md-12">
    <div class="card dashboard-card p-4 text-center">

        <div class="icon">🔐</div>

        <h4>Gestión de Usuarios</h4>

        <p>
            Registrar usuarios y asignar roles del sistema.
        </p>

        <a href="${pageContext.request.contextPath}/usuarios"
           class="btn btn-primary mt-3">
            Administrar Usuarios
        </a>

    </div>
</div>

<% } %>
        
        <% if (u.tieneRol("ALUMNO")) { %>

		<div class="col-md-12">
   		 <div class="card dashboard-card p-4 text-center">

        <div class="icon">🎓</div>

        <h4>Mi Resumen Académico</h4>

        <p>
            Consulta tus cursos matriculados y tus notas.
        </p>

        <a href="${pageContext.request.contextPath}/notas"
           class="btn btn-primary mt-3">
           Ver Mis Notas
        </a>

    </div>
</div>

<% } %>

    </div>

</div>

</body>
</html>