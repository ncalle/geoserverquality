<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>

 	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
	
	<title>ABM Usuarios</title> 

	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css">
	<!--  <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap-theme.min.css">-->
	<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> -->
	
	<!-- Custom styles for this template -->
	<link href="./css/users.css" rel="stylesheet">
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
</head>


<body>

    <nav class="navbar navbar-static-top navbar-dark bg-inverse navbar-inverse">
      <a class="navbar-brand" href="#">GeoServiceQuality</a>
      <ul class="nav navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/welcome.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/measurableObjectList.xhtml">Objetos de evaluaci�n</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/profileList.xhtml">Perfiles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/welcome.jsp">Evaluaciones</a>
        </li>
          <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/welcome.jsp">Reportes</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="userServlet">Usuarios<span class="sr-only">(current)</span></a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/welcome.jsp">Acerca</a>
        </li>
         </ul>
      
       <ul class="nav navbar-nav navbar-right">
	      <li><a href="${pageContext.request.contextPath}/logoutServlet"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
	  </ul>
    </nav>


    <div class="container">
    
    	<form class="form-signin" action="" method="post">
	    	<h2 class="form-signin-heading">Datos de Usuarios</h2>
	
	      	<hr>	      	
	      	<div class="panel panel-default">
			  <div class="panel-body">
			    
			    <!-- tabla -->
		      	<div class="table-responsive">
				  <table class="table table-striped">	  
				    <thead>
				      <tr>
				        <th>ID</th>
				        <th>Instituci�n</th>
				        <th>Email</th>
				        <th>Tipo</th>
				        <th>Nombre</th>
				        <th>Apellido</th>
				        <th>Telefono</th>
				      </tr>
				    </thead>
				    <tbody>
					    <c:forEach items="${userList}" var="ulist" varStatus="status">
					    	<tr>
					            <td>${ulist.getUserId()}</td>
					            <td>${ulist.getInstitutionName()}</td>
					            <td>${ulist.getEmail()}</td>
					            <td>${ulist.getUserGroupName()}</td>
					            <td>${ulist.getFirstName()}</td>
					            <td>${ulist.getLastName()}</td>
					            <td>${ulist.getPhoneNumber()}</td>
					        </tr>
					    </c:forEach>
				    </tbody>
				  </table>
				</div>
			 </div>
			</div>
			
			<div class="panel panel-default">
			  <div class="panel-body">
			  
		  		<a class="btn btn-default" href="${pageContext.request.contextPath}/userAdd.xhtml">Agregar
		  		<span class="glyphicon glyphicon-plus" aria-hidden="true" ></span></a>
		  		
		  		<a class="btn btn-default" href="${pageContext.request.contextPath}/welcome.jsp">Editar
		  		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
		  	
		  	
		  		<a class="btn btn-default" href="${pageContext.request.contextPath}/welcome.jsp">Eliminar
		  		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span></a>
			
			  </div>
			</div>
      	
      	 </form>

	  
	</div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js" integrity="sha384-THPy051/pYDQGanwU6poAc/hOdQxjnOEXzbT+OuUAFqNqFjL+4IGLBgCJC3ZOShY" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js" integrity="sha384-Plbmg8JY28KFelvJVai01l8WyZzrYWG825m+cZ0eDDS1f7d/js6ikvy1+X+guPIB" crossorigin="anonymous"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>