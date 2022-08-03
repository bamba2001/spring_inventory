

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion de Stock</title>
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
        <c:if test="${user_id == null}">
            <% response.sendRedirect("http://localhost:8080/spring_inventory_jdbc/home");%>
        </c:if>

        <div class="container">

            <div class="col-md-12 header">
                <h1 align="center"><a href="<%= request.getContextPath()%>/">Gestion de Stock</a></h1>
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
                                <li><a href="<%= request.getContextPath()%>/product"><i class="fa fa-paypal"></i> Ajouter Produit</a></li>
                                <li class="active"><a href="<%= request.getContextPath()%>/customer"><i class="fa fa-user-plus"></i> Ajouter Client</a></li> 
                                <li><a href="<%= request.getContextPath()%>/order_details"><i class="fa fa-area-chart"></i> Détails Commandes</a></li> 
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
                        <strong>Réussie!</strong> ${sm}
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
                        <h3 align="center"><i class="fa fa-user-plus"></i>Inscription Client</h3>
                    </div>
                    <div class="panel-body">
                        <c:if test="${customer.cid != null}">
                            <form action="<%= request.getContextPath()%>/updateCustomer" method="post">
                            </c:if>
                            <c:if test="${customer.cid == null}">
                                <form action="<%= request.getContextPath()%>/addCustomer" method="post">
                                </c:if>
                                <div class="form-group">
                                    <label for="cid">ID Client: </label>
                                    <input value="${customer.cid}" name="cid" type="text" class="form-control" id="cid" <c:if test="${customer.cid == null}">disabled="1"</c:if>" readonly="1">
                                    </div>

                                    <div class="form-group">
                                        <label for="cname">Nom:</label>
                                        <input value="${customer.cname}" name="cname" type="text" class="form-control" id="cname">
                                </div>

                                <div class="form-group">
                                    <label for="phone">Phone:</label>
                                    <input value="${customer.phone}" name="phone" type="text" class="form-control" id="phone">
                                </div>

                                <c:if test="${customer.cid != null}">
                                    <button type="submit" class="btn btn-warning"><i class="fa fa-edit"></i> Mettre à jour</button>
                                    <a href="<%= request.getContextPath()%>/customer" class="btn btn-primary pull-right"><i class="fa fa-user-plus"></i> New</a>
                                </c:if>

                                <c:if test="${customer.cid == null}">
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
                            <th colspan="5" style="text-align: center;"><h2><i class="fa fa-users"></i> Liste des clients</h2></th>
                        </tr>
                        <tr>
                            <th>Id</th>
                            <th>Nom</th>
                            <th>Tél</th>
                            <th colspan="2">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="row" items="${customers}">
                            <tr>
                                <td>${row.cid}</td>
                                <td>${row.cname}</td>
                                <td>${row.phone}</td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/editCustomer/${row.cid}" class="btn btn-warning"><i class="fa fa-edit"></i> Modifier</a>
                                </td>
                                <td>
                                    <a onclick="return confirm('Voulez-vous supprimer cet élément ?')" href="<%= request.getContextPath()%>/deleteCustomer/${row.cid}" class="btn btn-danger"><i class="fa fa-trash"></i> Supprimer</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="col-md-12" style="text-align: center;">
                &copy; Athj_tech
            </div>

        </div>

    </body>
</html>
