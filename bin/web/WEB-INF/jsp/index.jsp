

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="myApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Stock</title>
        <spring:url value="/resources/css/bootstrap.css" var="bootstrapCSS"/>
        <spring:url value="/resources/css/font-awesome.css" var="fontawesomeCSS"/>
        <spring:url value="/resources/js/jquery.min.js" var="jqueryJS"/>
        <spring:url value="/resources/js/bootstrap.js" var="bootstrapJS"/>
        <spring:url value="/resources/js/angular.min.js" var="angularJS"/>
        <spring:url value="/resources/js/my_app.js" var="myAppJS"/>
        <link rel="stylesheet" type="text/css" href="${bootstrapCSS}"/>
        <link rel="stylesheet" type="text/css" href="${fontawesomeCSS}"/>
        <script src="${jqueryJS}"></script>
        <script src="${bootstrapJS}"></script>
        <script src="${angularJS}"></script>
        <script src="${myAppJS}"></script>
        <style type="text/css">
            .header, .message{
                margin-bottom: 20px;
            }
            th, td{
                text-align: center;
            }
        </style>

    </head>
    <body ng-controller="appCtrl">



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

                                <c:if test="${user_id != null}">
                                    <li class="active"><a href="<%= request.getContextPath()%>/"><i class="fa fa-home"></i> Accueil</a></li>
                                    <li><a href="<%= request.getContextPath()%>/product"><i class="fa fa-paypal"></i> Ajouter un produit</a></li>
                                    <li><a href="<%= request.getContextPath()%>/customer"><i class="fa fa-user-plus"></i> Ajouter un client</a></li> 
                                    <li><a href="<%= request.getContextPath()%>/order_details"><i class="fa fa-area-chart"></i> Détails de commnade</a></li> 
                                    </c:if>

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

            <c:if test="${user_id == null}">    


                <div class="col-md-4 col-md-offset-4">
                    <div style="margin: 0 auto; width: 100%;">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 align='center'><i class="fa fa-sign-in"></i> Se connecter ici</h4>
                            </div>
                            <div class="panel-body">
                                <c:if test="${em != null}">
                                    <div class="alert alert-danger alert-dismissable fade in">
                                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                        <strong>Erreur!</strong> ${em}
                                    </div>
                                </c:if>

                                <form action="<%= request.getContextPath()%>/loginCheck" method="post">
                                    <div class="form-group">
                                        <label for="userName">Nom d'utilisateur):</label>
                                        <input name="userName" class="form-control" id="userName" type="text"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Mot de passe:</label>
                                        <input name="password" class="form-control" id="password" type="password"/>
                                    </div>
                                    <div class="form-group"> 
                                        <button type="submit" class="btn btn-success"><i class="fa fa-sign-in"></i> Connexion</button>
                                    </div>
                                </form>
                            </div>
                            <div class="panel-footer">
                                <p align="center">Vous n'avez pas de compte ? Cliquez ensuite sur <a href="">Inscription</a> </p>
                            </div>
                        </div>
                    </div>
                </div>


            </c:if>

            <c:if test="${user_id != null}">



                <div class="col-md-12">

                    <div class="panel panel-default">
                        <div class="panel-heading">

                        </div>
                        <div class="panel-body">
                            <div class="col-md-4">
                                N° commande: <input name="oid" type="text" class="form-control" ng-model="oid = ${orderNo}" value="${orderNo}"/>
                            </div>
                            <div class="col-md-4">
                                Type de commande: 
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="orderType" ng-model="orderType" value="sell">Vente
                                    </label> &nbsp; &nbsp; &nbsp;
                                    <label>
                                        <input type="radio" name="orderType" ng-model="orderType" value="purchase">Achat
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                Date de commande: <input ng-model="orderDate" name="orderDate" type="date" class="form-control"/>
                            </div>
                        </div>
                    </div>

                </div>





                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-4" style="height: 360px;">
                            <div class="panel panel-primary" style="height: 100%">
                                <div class="panel-heading">
                                    <i class="fa fa-product-hunt"></i> Sélectionner produit
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label for="Product Name">Nom produit:</label>
                                        <select name="pname" class="form-control" ng-model="clickedProduct" ng-options="product.pname for product in products">
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="pid">Id produit: </label>
                                        <input readonly="1" name="pid" type="text" class="form-control" id="pid" value="{{clickedProduct.pid}}">
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Prix: </label>
                                        <input readonly="1" name="price" type="text" class="form-control" id="price" value="{{clickedProduct.price}}">
                                    </div>
                                    <div class="form-group">
                                        <label for="qty">Stock: </label>
                                        <input readonly="1" name="qty" type="text" class="form-control" id="qty" value="{{clickedProduct.qty}}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="height: 360px;">
                            <div class="panel panel-primary" style="height: 100%">
                                <div class="panel-heading">
                                    <i class="fa fa-user-circle"></i> Sélectionner le client
                                </div>
                                <div class="panel-body">
                                    <div class="form-group">
                                        <label for="Customer Name">Nom du client:</label>
                                        <select name="cname" class="form-control" ng-model="clickedCustomer" ng-options="customer.cname for customer in customers">
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="cid">Id client: </label>
                                        <input readonly="1" name="cid" type="text" class="form-control" id="cid" value="{{clickedCustomer.cid}}">
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Tél: </label>
                                        <input readonly="1" name="phone" type="text" class="form-control" id="phone" value="{{clickedCustomer.phone}}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4" style="height: 360px;">
                            <div class="panel panel-primary" style="height: 100%">
                                <div class="panel-heading">
                                    <i class="fa fa-sellsy"></i> Détails du commande
                                </div>
                                <div class="panel-body">
                                    <div class="form-group" ng-show="clickedProduct.pid != null">
                                        <label for="qty">Quantité:</label>
                                        <input readonly="1" name="orderQty" ng-model="qty = 1" type="text" class="form-control" id="qty" placeholder="Enter Quantity">
                                    </div>
                                    <div class="form-group" ng-show="qty != 0 && clickedProduct.pid != null">
                                        <label for="total">Total:</label>
                                        <input readonly="1" name="total" value="{{clickedProduct.price * qty}}" type="text" class="form-control" id="total">
                                    </div>
                                    <div class="form-group" ng-show="clickedProduct.pid != null && clickedCustomer.cid != null"> 
                                        <button ng-click="addToCart()" type="submit" class="btn btn-success"><i class="fa fa-cart-plus"></i>Ajouter au panier</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-12" style="text-align: center; margin-top: 20px;">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h3><i class="fa fa-cart-plus"></i> Panier <button class="btn btn-sm btn-success"> {{cartProduct.length}} </button></h3>
                        </div>
                        <div class="panel-body">
                            <table class="table table-bordered table-striped table-responsive">
                                <thead>
                                    <tr>
                                        <th>S.No</th>
                                        <th>Nom produit</th>
                                        <th>Prix</th>
                                        <th>Quantité</th>
                                        <th>Action</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="product in cartProduct">
                                        <td>{{$index + 1}}</td>
                                        <td>{{product.pname}}</td>
                                        <td>{{product.price}}</td>
                                        <td>
                                            <button type="button" ng-click="decreaseQty(product)" class="btn btn-danger"><i class="fa fa-minus"></i></button>
                                            &nbsp; &nbsp; {{product.cartQty}} &nbsp; &nbsp;
                                            <button type="button" ng-click="increaseQty(product)" class="btn btn-success"><i class="fa fa-plus"></i></button>
                                        </td>
                                        <td><button ng-click="removeProduct(product)" class="btn btn-danger"><i class="fa fa-remove"></i> Retirer</button></td>
                                        <td>{{product.subTotal}}</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr ng-show="cartProduct.length != 0">
                                        <td colspan="5" style="text-align: right">Total final:</td>
                                        <td>{{finalTotal}}</td>
                                    </tr>
                                    <tr ng-show="cartProduct.length != 0">
                                        <td colspan="6" style="text-align: right">
                                            <button data-toggle="modal" data-target="#checkoutModal" type="button" ng-show="cartProduct.length != 0" class="btn btn-success"><i class="fa fa-check"></i> Vérification</button>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>

            </c:if>         

            <div class="col-md-12" style="text-align: center; margin-top: 60px;">
                &copy; Athj_tech
            </div>



            <!-- checkoutModal -->
            <div id="checkoutModal" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" align="center"><i class="fa fa-eye"></i> Vérifier votre commande</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered table-striped">
                                <tr>
                                    <td>Id commande</td>
                                    <td>{{oid}}</td>
                                </tr>
                                <tr>
                                    <td>Type de commande</td>
                                    <td>{{orderType}}</td>
                                </tr>
                                <tr>
                                    <td>Date de commande</td>
                                    <td>{{orderDate| date}}</td>
                                </tr>
                                <tr>
                                    <td>Id client</td>
                                    <td>{{clickedCustomer.cid}}</td>
                                </tr>
                                <tr>
                                    <td>Montant Total</td>
                                    <td>{{finalTotal}}</td>
                                </tr>
                            </table>
                            <br/>
                            <br/>
                            <br/>
                            Détails client: <br/>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>NO</th>
                                        <th>Nom produit</th>
                                        <th>Prix</th>
                                        <th>Qté</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="product in cartProduct">
                                        <td>{{$index + 1}}</td>
                                        <td>{{product.pname}}</td>
                                        <td>{{product.price}}</td>
                                        <td>{{product.cartQty}}</td>
                                        <td>{{product.price * product.qty}}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button  type="button" class="btn btn-warning" ><i class="fa fa-print"></i> Imprimer</button>
                            <button data-toggle="modal" data-target="#messageModal" ng-click="checkOut()" type="button" class="btn btn-success" data-dismiss="modal"><i class="fa fa-check"></i> Confirmer</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Annuler</button>
                        </div>
                    </div>

                </div>
            </div>


            <!-- Modal -->
            <div id="messageModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title" align="center">Félicitation</h4>
                        </div>
                        <div class="modal-body">
                            <h1 style="color: green; text-align: center">
                               Commande terminée avec succès
                            </h1>
                        </div>
                        <div class="modal-footer">
                            <a href="<%= request.getContextPath()%>" class="btn btn-default">Fermer</a>
                        </div>
                    </div>

                </div>
            </div>


        </div>


    </body>
</html>
