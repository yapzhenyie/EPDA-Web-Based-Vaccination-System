<%-- 
    Document   : dashboard
    Created on : Oct 2, 2021, 9:38:20 PM
    Author     : Yap Zhen Yie
--%>
<%@page import="model.PublicUserFacade"%>
<%@page import="model.MinistryStaffFacade"%>
<%@page import="model.ClinicStaffFacade"%>
<%@page import="classes.UserRole"%>
<%@page import="model.MinistryStaff"%>
<%@page import="model.PublicUser"%>
<%@page import="model.ClinicStaff"%>
<%@page import="constants.ConstantLink"%>
<%@page import="constants.ConstantSession"%>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) == null) {
        response.sendRedirect(ConstantLink.UrlLogin);
        return;
    }
%>
<%!
    String name = "";
    Context context;
    MinistryStaffFacade ministryStaffFacade;
    ClinicStaffFacade clinicStaffFacade;
    PublicUserFacade publicUserFacade;
%>
<%
    try {
        String userRole = session.getAttribute(ConstantSession.UserCredentialRole).toString();
        if (userRole.equals(UserRole.Ministry_Staff.toString())) {
            MinistryStaff ministryStaff = (MinistryStaff) session.getAttribute(ConstantSession.User);
            name = ministryStaff.getName();
        } else if (userRole.equals(UserRole.Clinic_Staff.toString())) {
            ClinicStaff clinicStaff = (ClinicStaff) session.getAttribute(ConstantSession.User);
            name = clinicStaff.getName() + " (" + clinicStaff.getClinicName() + ")";
        } else if (userRole.equals(UserRole.Public_User.toString())) {
            PublicUser publicUser = (PublicUser) session.getAttribute(ConstantSession.User);
            name = publicUser.getName();
        }

        context = new InitialContext();
        ministryStaffFacade = (MinistryStaffFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/MinistryStaffFacade!model.MinistryStaffFacade");
        clinicStaffFacade = (ClinicStaffFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/ClinicStaffFacade!model.ClinicStaffFacade");
        publicUserFacade = (PublicUserFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/PublicUserFacade!model.PublicUserFacade");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard | EPDA Vaccination System</title>
        <link rel="icon" href="assets/media/APU-Logo.png" type="image/x-icon">
        <!-- Mandatory CSS Library -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendors/fontawesome-free/css/all.css" rel="stylesheet">
        <link href="assets/css/style-bundle.css" rel="stylesheet">
        <link href="assets/css/style-navbar.css" rel="stylesheet">
        <link href="assets/css/style-sidebar.css" rel="stylesheet">

        <!-- Font Family -->
        <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700&family=Poppins:300,400,500,600,700" rel="stylesheet">

        <!-- Optional CSS Library -->
        <link href="assets/vendors/SweetAlert2/sweetalert2.min.css" rel="stylesheet">

        <!-- Mandatory JavaScript Library -->
        <script src="assets/vendors/jquery/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendors/jQuery-Validation/dist/jquery.validate.js"></script>
        <script src="assets/js/script-bundle.js"></script>

        <!-- Optional JavaScript Library -->
        <script src="assets/vendors/SweetAlert2/sweetalert2.all.min.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <!-- Begin: Top Navbar -->
            <jsp:include page="layout/top-navbar.jsp" />
            <!-- End: Top Navbar -->
            <!-- Page Content -->
            <div class="main-content">
                <!-- Begin: Sidebar -->         
                <jsp:include page="layout/sidebar.jsp" />
                <!-- End: Sidebar -->
                <div class="content">
                    <div class="alert alert-primary font-weight-bold" role="alert">
                        Welcome back, <%= name%>
                    </div>
                    <%
                        if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
                    %>
                    <div class="container-fluid mb-3">
                        <div class="row">
                            <div class="col-12 col-md-6 col-xl-4 mb-md-3 mb-xl-0">
                                <div class="v-card color-2">
                                    <i class="far fa-address-card"></i>
                                    <div class="v-card-details">
                                        <span class="v-card-description">Ministry Staff</span>
                                        <div class="v-card-value">
                                            <span><%= ministryStaffFacade.count()%></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-xl-4 mt-3 mt-md-0 mb-md-3 mb-xl-0">
                                <div class="v-card color-3">
                                    <i class="far fa-address-card"></i>
                                    <div class="v-card-details">
                                        <span class="v-card-description">Clinic Staff</span>
                                        <div class="v-card-value">
                                            <span><%= clinicStaffFacade.count()%></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-xl-4 mt-3 mt-md-0">
                                <div class="v-card color-1">
                                    <i class="far fa-address-card"></i>
                                    <div class="v-card-details">
                                        <span class="v-card-description">Public User</span>
                                        <div class="v-card-value">
                                            <span><%= publicUserFacade.count()%></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %> 
                    <%
                        if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
                    %>
                    
                    <%
                        }
                    %>
                    <div>
                        chart per states (vaccinated vs non-vaccinated)
                    </div>
                    <!-- Begin: Footer -->
                    <jsp:include page="layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
        <script>
        </script>
    </body>
</html>
