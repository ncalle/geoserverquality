<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>

   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    
    <title>Registro </title> 
	
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css">
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	 <!-- Custom styles for this template -->
    <link href="./css/signin.css" rel="stylesheet">

	
	
</head>
<body>
	<div class="container">

      <form class="form-signin" action="registroServlet" method="post">
        <h2 class="form-signin-heading">Registro</h2>
        
        <label for="inputName" class="sr-only">Nombre</label>
        <input type="text" id="inputName" class="form-control" placeholder="Nombre" name="name" required autofocus>
        
        <label for="inputLastName" class="sr-only">Apellido</label>
        <input type="text" id="inputLastName" class="form-control" placeholder="Apellido" name="lastname" required>
        
        <label for="inputPhone" class="sr-only">Teléfono</label>
        <input type="number" id="inputPhone" class="form-control" placeholder="Teléfono" name="phone" required>
        
        <label for="inputEmail" class="sr-only">Email</label>
        <input type="text" id="inputEmail" class="form-control" placeholder="Email" name="username" required>
        
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="userpass" required>
        
		<!--  <div class="dropdown">
		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
		    Tipo de Administrador
		    <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu" role = "menu" aria-labelledby="dropdownMenu1">
		      <li><a href="#">Administrador IDE</a></li>
		      <li><a href="#">Administrador Técnico</a></li>
		      <li><a href="#">Administrador Institucional</a></li>
		      <li><a href="#">Administrador General</a></li>
		  </ul>
		</div>-->

		<select class="selectpicker" name="Seleccione el tipo de usuario" >
			<option value="test0">Administrador IDE</option>
			<option value="test1">Administrador Técnico</option>
			<option value="test2">Administrador Institucional</option>
			<option value="test3" select>Administrador General</option>
		</select>
		  
		<br><br>
        <button class="btn btn-lg btn-primary btn-block" type="submit" value="Aceptar">Aceptar</button>
       
      </form>
      
    </div>  

</body>
</html>