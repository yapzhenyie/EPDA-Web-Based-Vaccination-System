<%-- 
    Document   : login
    Created on : Oct 2, 2021, 5:14:00 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) != null) {
        response.sendRedirect("../dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Log In | EPDA Vaccination System</title>
        <link rel="icon" href="../assets/media/APU-Logo.png" type="image/x-icon">
        <!-- Mandatory CSS Library -->
        <link href="../assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="../assets/vendors/fontawesome-free/css/all.css" rel="stylesheet" />
        <link href="../assets/css/style-bundle.css" rel="stylesheet">
        <link href="../assets/css/site-login.css" rel="stylesheet">

        <!-- Font Family -->
        <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700" rel="stylesheet">

        <!-- Optional CSS Library -->
        <link href="../assets/vendors/SweetAlert2/sweetalert2.min.css" rel="stylesheet">

        <!-- Mandatory JavaScript Library -->
        <script src="../assets/vendors/jquery/jquery.min.js"></script>
        <script src="../assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendors/jQuery-Validation/dist/jquery.validate.js"></script>

        <!-- Optional JavaScript Library -->
        <script src="../assets/vendors/SweetAlert2/sweetalert2.all.min.js"></script>
    </head>
    <body>
        <div class="v-container">
            <header>
                <div class="v-header d-flex justify-content-center text-center p-5">
                    <a class="v-header--brand" href="../">
                        <h1>EPDA Vaccination System</h1>
                    </a>
                </div>
            </header>
            <section class="v-main-content">
                <div class="v-container-login-form">
                    <div class="v-login-form-portlet">
                        <div class="v-login-form__header">
                            <h2 class="v-login-form__header-content">
                                Log In
                            </h2>
                        </div>
                        <div class="v-login-form__body">
                            <form action="../Login" method="POST" id="loginForm" autocomplete = "off">
                                <div class="form-group row">
                                    <div class="col-12">
                                        <label class="required" for="email">Email</label>
                                        <input class="form-control" name="email" type="email" id="email" placeholder="Email" autofocus="autofocus" tabindex = "1" data-rule-required="true" data-msg-required="The Email field is required."> 
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12">
                                        <label class="required" for="password">Password</label>
                                        <input class="form-control" name="password" type="password" id="password" placeholder="Password" tabindex = "2" data-rule-required="true" data-msg-required="The Password field is required.">
                                    </div>
                                </div>
                                <div class="float-right pb-1">
                                    <a href="forgot-password.jsp">Forgot Password?</a>
                                </div>
                                <button class="btn btn-primary w-100 font-weight-bold" id="submitBtn" type="submit" tabindex="3">LOG IN</button>
                            </form>
                        </div>
                        <div class="v-login-form__footer">
                            <div class="d-flex row">
                                <span class="v-login-form__footer-description col-12">Don't have an account?</span>
                                <div class="col-12">
                                    <a class="font-weight-bold" href="signup.jsp">SIGN UP NOW</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Begin: Footer -->
            <jsp:include page="layout/footer.jsp" />
            <!-- End: Footer -->
        </div>

        <script>
            $(document).ready(function () {
                $("#loginForm").validate();
            });

            $("#loginForm").submit(function () {
                if ($('#loginForm').valid()) {
                    $("#submitBtn").prop("disabled", true);
                    $("#submitBtn").html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>' +
                            ' One moment please...');
                }
            });


            <%
                if (session.getAttribute(ConstantSession.Validate) != null && session.getAttribute(ConstantSession.Validate).equals(ConstantMessage.Error)) {
            %>
            function showErrorMessage() {
                Swal.fire({
                    icon: 'error',
                    title: '<span style="display: flex;padding: .8em 1em 0;justify-content: center;letter-spacing: 2px;"><%= session.getAttribute(ConstantSession.ValidateMessage)%></span>',
                    showConfirmButton: true,
                    confirmButtonText: 'Confirm'
                });
            }
            window.onload = showErrorMessage;
            <%
                    session.setAttribute(ConstantSession.Validate, null);
                    session.setAttribute(ConstantSession.ValidateMessage, null);
                }
            %>
        </script>
    </body>
</html>

