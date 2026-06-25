<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Sistema Educativo - Iniciar Sesión</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#eef2ff,#dbeafe);
    font-family:'Segoe UI',sans-serif;
}

.login-card{
    width:900px;
    border:none;
    border-radius:25px;
    overflow:hidden;
    box-shadow:0 15px 40px rgba(0,0,0,.15);
}

.left-panel{
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:white;
    padding:40px;
    text-align:center;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.left-panel h2{
    font-weight:bold;
    margin-top:15px;
}

.left-panel p{
    opacity:.9;
}

.left-panel .icon{
    font-size:70px;
}

.right-panel{
    background:white;
    padding:50px;
}

.right-panel h1{
    font-weight:700;
    color:#1e293b;
}

.right-panel p{
    color:#64748b;
}

.form-control{
    height:50px;
    border-radius:12px;
}

.form-control:focus{
    border-color:#2563eb;
    box-shadow:none;
}

.btn-login{
    height:50px;
    border-radius:12px;
    font-weight:600;
    font-size:17px;
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    border:none;
}

.btn-login:hover{
    transform:translateY(-2px);
    transition:.3s;
}

.footer-text{
    text-align:center;
    margin-top:20px;
    color:#94a3b8;
}

</style>

</head>
<body>

<div class="card login-card">

    <div class="row g-0">

        <!-- PANEL IZQUIERDO -->
        <div class="col-md-5 left-panel">

            <div class="icon">🎓</div>

            <h2>Sistema Educativo</h2>

            <hr>

            <p>Control de Alumnos y Notas</p>

            <div class="mt-4">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png"
                     width="180"
                     class="img-fluid">
            </div>

        </div>

        <!-- PANEL DERECHO -->
        <div class="col-md-7 right-panel">

            <h1>Bienvenido</h1>

            <p>Ingresa tus credenciales para continuar</p>

            <form action="${pageContext.request.contextPath}/login" method="POST">

                <div class="mb-3">
                    <label class="form-label">Usuario</label>
                    <input type="text"
                           class="form-control"
                           id="username"
                           name="username"
                           placeholder="Ej: admin"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Contraseña</label>
                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="••••••••"
                           required>
                </div>

                <button type="submit" class="btn btn-primary btn-login w-100">
                    Ingresar al Sistema
                </button>

            </form>

            <div class="footer-text">
                🔒 Acceso seguro
            </div>

        </div>

    </div>

</div>

</body>
</html>