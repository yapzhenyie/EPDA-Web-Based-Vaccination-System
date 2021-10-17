<%-- 
    Document   : forgot-password
    Created on : Oct 4, 2021, 12:10:28 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password | EPDA Vaccination System</title>
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
                <div class="v-container-forgot-password-form">
                    <div class="v-forgot-password-form-portlet">
                        <div class="v-forgot-password-form__header">
                            <h2 class="v-forgot-password-form__header-content">
                                Forgot Password?
                            </h2>
                        </div>
                        <div class="v-forgot-password-form__body">
                            <%
                                if (session.getAttribute(ConstantSession.Success) != null && session.getAttribute(ConstantSession.Success).equals(ConstantMessage.True)) {
                            %>
                            <h3 class="p-2 font-weight-bold text-center text-white" style="background-color: #28a745;border-radius: 8px;">
                                Password Reset Successfully
                            </h3>
                            <div class="form-group row">
                                <div class="col-12">
                                    <label for="emailAddress">Email Address</label>
                                    <input class="form-control" name="emailAddress" type="text" id="emailAddress" autofocus="autofocus" tabindex = "1" readonly value="<%=session.getAttribute(ConstantSession.EmailAddress)%>"> 
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <label for="newPassword">New Password</label>
                                    <div class="input-group">
                                        <input class="form-control" name="newPassword" type="text" id="newPassword" tabindex = "2" readonly value="<%=session.getAttribute(ConstantSession.NewPassword)%>"> 
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-primary" type="button" id="copyBtn">
                                                <i class="far fa-clone" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a class="btn btn-outline-primary w-100 font-weight-bold text-center" href="login.jsp" role="button">BACK TO LOG IN PAGE</a>
                            <%
                                session.setAttribute(ConstantSession.Success, null);
                                session.setAttribute(ConstantSession.EmailAddress, null);
                                session.setAttribute(ConstantSession.NewPassword, null);
                            } else {
                            %>
                            <form action="../ForgotPassword" method="POST" id="forgotPasswordForm" autocomplete = "off">
                                <div class="form-group row">
                                    <div class="col-12">
                                        <label class="required" for="emailAddress">Email Address</label>
                                        <input class="form-control" name="emailAddress" type="email" id="emailAddress" placeholder="Email Address" autofocus="autofocus" tabindex = "1" data-rule-required="true" data-msg-required="The Email Address field is required."> 
                                    </div>
                                </div>
                                <button class="btn btn-primary w-100" id="submitBtn" type="submit" tabindex="2">Reset Password</button>
                            </form>
                            <%
                                }
                            %>
                        </div>
                        <div class="v-forgot-password-form__footer">
                            <div class="d-flex row">
                                <span class="v-forgot-password-form__footer-description col-12">Other Options</span>
                                <div class="d-flex col-12 justify-content-center w-100 pt-2">
                                    <div class="col-6">
                                        <a class="font-weight-bold" href="login.jsp">LOG IN</a>
                                    </div>
                                    <span>|</span>
                                    <div class="col-6">
                                        <a class="font-weight-bold" href="signup.jsp">SIGN UP</a>
                                    </div>
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
                $("#forgotPasswordForm").validate();
            });

            $("#forgotPasswordForm").submit(function () {
                if ($('#forgotPasswordForm').valid()) {
                    $("#submitBtn").prop("disabled", true);
                    $("#submitBtn").html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>' +
                            ' One moment please...');
                }
            });

            $('#copyBtn').click(function () {
                copyElement($('#newPassword'));
            });

            function copyElement(element) {
                var inp = document.createElement('input');
                document.body.appendChild(inp);
                inp.value = $(element).val();
                inp.select();
                document.execCommand('copy', false);
                inp.remove();
            }

            <%
                if (session.getAttribute(ConstantSession.Validate)
                        != null && session.getAttribute(ConstantSession.Validate).equals(ConstantMessage.Error)) {
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
