<%-- 
    Document   : index
    Created on : Oct 4, 2021, 10:11:02 PM
    Author     : Yap Zhen Yie
--%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="classes.AccountStatus"%>
<%@page import="model.PublicUserFacade"%>
<%@page import="constants.ConstantLink"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%!
    Context context;
    PublicUserFacade publicUserFacade;
%>
<%
    try {
        context = new InitialContext();
        publicUserFacade = (PublicUserFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/PublicUserFacade!model.PublicUserFacade");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en" theme-mode="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>EPDA Vaccination System</title>
        <link rel="icon" href="assets/media/APU-Logo.png" type="image/x-icon">
        <!-- Mandatory CSS Library -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendors/fontawesome-free/css/all.css" rel="stylesheet">
        <link href="assets/css/style-bundle.css" rel="stylesheet">
        <link href="assets/css/style-index.css" rel="stylesheet">

        <!-- Font Family -->
        <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700&family=Poppins:300,400,500,600,700" rel="stylesheet">

        <!-- Optional CSS Library -->

        <!-- Mandatory JavaScript Library -->
        <script src="assets/vendors/jquery/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Optional JavaScript Library -->
    </head>
    <body style="background-color: #f3f4f6;">
        <noscript>
        <div class="v-noscript">
            This site requires JavaScript. You will not be able to continue if Javascript is disabled.
        </div>
        </noscript>
        <div class="v-container">
            <nav class="container-navbar">
                <div class="container-xl d-block d-md-flex">
                    <div class="brand">
                        <div class="brand-logo">
                            <a href="<%= ConstantLink.UrlIndex%>">
                                <img src="<%= ConstantLink.BrandLogo%>" alt="EPDA" width="56px" height="56px"></img>
                                <h1>EPDA Vaccination System</h1>
                            </a>
                        </div>
                    </div>
                    <div class="navigation-menu">
                        <ul class="d-flex justify-content-center align-items-center list-unstyled mb-0">
                            <li>
                                <a href="<%= ConstantLink.UrlIndex%>">Home</a>
                            </li>
                            <li>
                                <a href="<%= ConstantLink.UrlDashboard%>">Dashboard</a>
                            </li>
                        </ul>
                    </div>
                    <div class="tools">
                        <a class="tool-btn mr-1 btn btn-primary" href="user/login.jsp" role="button" aria-pressed="true">Login</a>
                        <a class="tool-btn ml-1 btn btn-outline-primary" href="user/signup.jsp" role="button" aria-pressed="true">Sign up</a>
                    </div>
                </div>
            </nav>
            <div class="container-home container-xl mt-4 mb-4">
                <div class="row">
                    <div class="col-12">
                        <div class="home-banner-top d-flex align-items-center shadow">
                            <div class="home-banner-top__description p-5">
                                <div class="banner-header font-weight-bold mt-3">
                                    TIME TO VACCINATE
                                </div>
                                <div class="banner-subheader font-weight-bold mt-5">
                                    <span><%= publicUserFacade.findByActiveAccount().size()%> People Registered</span>
                                </div>
                                <a class="register-btn mt-5 btn btn-success font-weight-bold btn-lg" href="user/signup.jsp" role="button" aria-pressed="true">REGISTER NOW</a>
                            </div>
                            <div class="home-banner-top__image"></div>
                        </div>
                    </div>
                </div>
                <div>Main section</div>
            </div>
            <footer style="background-color: white;">
                <div class="container-xl">
                    <div class="text-center p-5">
                        <% pageContext.setAttribute("currentYear", java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));%>
                        Copyright &copy; <c:out value="${currentYear}" /> Yap Zhen Yie (TP054300) - APU EPDA
                    </div>
                </div>
            </footer>
        </div>
    </body>
</html>
