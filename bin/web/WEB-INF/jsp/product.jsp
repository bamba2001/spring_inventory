

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de stock</title>
        <spring:url value="/resources/css/bootstrap.css" var="bootstrapCSS"/>
        <spring:url value="/resources/css/font-awesome.css" var="fontawesomeCSS"/>
        <spring:url value="/resources/js/jquery.min.js" var="jqueryJS"/>
        <spring:url value="/resources/js/bootstrap.js" var="bootstrapJS"/>
        <link rel="stylesheet" type="text/css" href="${bootstrapCSS}"/>
        <link rel="stylesheet" type="text/css" href="${fontawesomeCSS}"/>
        <script src="${jqueryJS}"></script>
        <script src="${bootstrapJS}"></script>
        <style type="text/css">
            .header, .message{
                margin-bottom: 20px;
            }
            th, td{
                text-align: center;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <c:if test="${user_id == null}">
                <% response.sendRedirect("http://localhost:8084/spring_inventory_jdbc/home");%>
            </c:if>
            <div class="col-md-12 header">
                <h1 align="center"><a href="<%= request.getContextPath()%>/">Gestion de stock</a></h1>
            </div>

            <div class="col-md-12 menu">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span> 
                            </button>
                        </div>
                        <div class="collapse navbar-collapse" id="myNavbar">
                            <ul class="nav navbar-nav">
                                <li><a href="<%= request.getContextPath()%>/"><i class="fa fa-home"></i> Accueil</a></li>
                                <li class="active"><a href="<%= request.getContextPath()%>/product"><i class="fa fa-paypal"></i> Ajouter un produit</a></li>
                                <li><a href="<%= request.getContextPath()%>/customer"><i class="fa fa-user-plus"></i> Ajouter un client</a></li> 
                                <li><a href="<%= request.getContextPath()%>/order_details"><i class="fa fa-area-chart"></i>Détails de commande</a></li> 
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <c:if test="${user_id == null}">
                                    <li><a href="#"><span class="glyphicon glyphicon-user"></span> Inscription</a></li>
                                    <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Connexion</a></li>
                                    </c:if>
                                    <c:if test="${user_id != null}">
                                    <li><a href="<%= request.getContextPath()%>/logout"><span class="glyphicon glyphicon-log-out"></span> Déconnexion</a></li>
                                    </c:if>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>

            <div class="col-md-12 message">
                <c:if test="${sm != null}">
                    <div class="alert alert-success alert-dismissable fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Success!</strong> ${sm}
                    </div>

                </c:if>
                <c:if test="${em != null}">
                    <div class="alert alert-danger alert-dismissable fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <strong>Erreur!</strong> ${em}
                    </div>
                </c:if>


            </div>

            <div class="student_form col-md-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 align="center"><i class="fa fa-product-hunt"></i>Ajouter un produit</h3>
                    </div>
                    <div class="panel-body">
                        <c:if test="${product.pid != null}">
                            <form action="<%= request.getContextPath()%>/updateProduct" method="post">
                            </c:if>
                            <c:if test="${product.pid == null}">
                                <form action="<%= request.getContextPath()%>/addProduct" method="post">
                                </c:if>
                                <div class="form-group">
                                    <label for="pid">Id produit: </label>
                                    <input value="${product.pid}" name="pid" type="text" class="form-control" id="pid" <c:if test="${product.pid == null}">disabled="1"</c:if>" readonly="1">
                                    </div>

                                    <div class="form-group">
                                        <label for="pname">Nom du produit:</label>
                                        <input value="${product.pname}" name="pname" type="text" class="form-control" id="pname">
                                </div>

                                <div class="form-group">
                                    <label for="price">Prix:</label>
                                    <input value="${product.price}" name="price" type="text" class="form-control" id="price">
                                </div>
                                <div class="form-group">
                                    <label for="age">Quantité:</label>
                                    <input value="${product.qty}" name="qty" type="text" class="form-control" id="qty">
                                </div>

                                <c:if test="${product.pid != null}">
                                    <button type="submit" class="btn btn-warning"><i class="fa fa-edit"></i> Mettre à jour</button>
                                    <a href="<%= request.getContextPath()%>/product" class="btn btn-primary pull-right"><i class="fa fa-user-plus"></i> Nouveau</a>
                                </c:if>

                                <c:if test="${product.pid == null}">
                                    <button type="submit" class="btn btn-success"><i class="fa fa-send"></i> Soumettre</button>
                                </c:if>


                            </form>

                    </div>
                    <div class="panel-footer">

                    </div>
                </div>
            </div>

            <div class="header col-md-8">
                <table class="table table-bordered table-responsive table-striped">
                    <thead>
                        <tr>
                            <th colspan="6" style="text-align: center;"><h2><i class="fa fa-product-hunt"></i> Liste de produits</h2></th>
                        </tr>
                        <tr>
                            <th>Id</th>
                            <th>Nom produit</th>
                            <th>Prix</th>
                            <th>Quantité</th>
                            <th colspan="2">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${products}">
                            <tr>
                                <td>${row.pid}</td>
                                <td>${row.pname}</td>
                                <td>${row.price}</td>
                                <td>${row.qty}</td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/editProduct/${row.pid}" class="btn btn-warning"><i class="fa fa-edit"></i> Modifier</a>
                                </td>
                                <td>
                                    <a onclick="return confirm('Souhaitez-vous supprimer cet élément?')" href="<%= request.getContextPath()%>/deleteProduct/${row.pid}" class="btn btn-danger"><i class="fa fa-trash"></i> Supprimer</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

    </body>
</html>
