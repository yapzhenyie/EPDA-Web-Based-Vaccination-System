<%-- 
    Document   : appointment
    Created on : Oct 15, 2021, 3:34:56 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="helper.DateTimeHelper"%>
<%@page import="classes.AppointmentStatus"%>
<%@page import="model.VaccinationFacade"%>
<%@page import="model.Vaccination"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Appointment"%>
<%@page import="model.AppointmentFacade"%>
<%@page import="model.PublicUser"%>
<%@page import="model.PublicUserFacade"%>
<%@page import="constants.ConstantMessage"%>
<%@page import="classes.UserRole"%>
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
    if (!session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Public_User.toString())) {
        response.sendRedirect(ConstantLink.UrlDashboard);
        return;
    }
%>
<%!
    Context context;
    AppointmentFacade appointmentFacade;
    VaccinationFacade vaccinationFacade;
    PublicUser user;
    Appointment appointment1;
    Vaccination vaccination1;
%>
<%
    try {
        context = new InitialContext();
        appointmentFacade = (AppointmentFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/AppointmentFacade!model.AppointmentFacade");
        vaccinationFacade = (VaccinationFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/VaccinationFacade!model.VaccinationFacade");
        user = (PublicUser) session.getAttribute(ConstantSession.User);
        appointment1 = appointmentFacade.getAppointmentByDose(user, 1);
        vaccination1 = vaccinationFacade.filterByDoseAndVaccinator(user, 1);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Appointment | EPDA Vaccination System</title>
        <link rel="icon" href="../assets/media/APU-Logo.png" type="image/x-icon">
        <!-- Mandatory CSS Library -->
        <link href="../assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="../assets/vendors/fontawesome-free/css/all.css" rel="stylesheet">
        <link href="../assets/css/style-bundle.css" rel="stylesheet">
        <link href="../assets/css/style-navbar.css" rel="stylesheet">
        <link href="../assets/css/style-sidebar.css" rel="stylesheet">

        <!-- Font Family -->
        <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700&family=Poppins:300,400,500,600,700" rel="stylesheet">

        <!-- Optional CSS Library -->
        <link href="../assets/vendors/SweetAlert2/sweetalert2.min.css" rel="stylesheet">
        <link href="../assets/vendors/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
        <link href="../assets/vendors/el-checkbox/checkbox.min.css" rel="stylesheet">

        <!-- Mandatory JavaScript Library -->
        <script src="../assets/vendors/jquery/jquery.min.js"></script>
        <script src="../assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendors/jQuery-Validation/dist/jquery.validate.js"></script>
        <script src="../assets/js/script-bundle.js"></script>

        <!-- Optional JavaScript Library -->
        <script src="../assets/vendors/SweetAlert2/sweetalert2.all.min.js"></script>
        <script src="../assets/vendors/bootstrap-table/bootstrap-table.min.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <!-- Begin: Top Navbar -->
            <jsp:include page="../layout/top-navbar.jsp" />
            <!-- End: Top Navbar -->
            <!-- Page Content -->
            <div class="main-content">
                <!-- Begin: Sidebar -->         
                <jsp:include page="../layout/sidebar.jsp" />
                <!-- End: Sidebar -->
                <div class="content">
                    <div class="header d-flex justify-content-between align-items-center mb-4 row">
                        <h2 class="font-weight-bold col-12">Appointment</h2>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-6">
                            <div class="card border-primary mb-3">
                                <h5 class="card-header font-weight-bold" style="color: #28a745;">
                                    #1 
                                    <i class="far fa-check-circle pr-2"></i>
                                    Registered
                                </h5>
                                <div class="card-body">
                                    <h5 class="card-title">You have registered for vaccination.</h5>
                                    <%
                                        if (appointment1 == null) {
                                    %>
                                    <p class="card-text">Your appointment will be scheduled shortly. Please ensure your profile details is correct.</p>
                                    <p class="card-text">Only 12 years old and above are allowed to get vaccination, otherwise it will be deemed as ineligible for vaccination.</p>
                                    <a href="<%= ConstantLink.UrlUserProfile%>" class="btn btn-primary font-weight-bold">Go to profile</a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <%
                                if (appointment1 != null) {
                            %>
                            <div class="card border-primary mb-3">
                                <%
                                    if (appointment1.getAppointmentStatus() == AppointmentStatus.Rejected) {
                                %>
                                <h5 class="card-header font-weight-bold" style="color: red;">
                                    #2 
                                    <i class="far fa-times-circle pr-2"></i>
                                    Appointment (Rejected)
                                </h5>
                                <%
                                } else {
                                %>
                                <h5 class="card-header font-weight-bold" style="color: #28a745;">
                                    #2 
                                    <i class="far fa-check-circle pr-2"></i>
                                    Appointment
                                </h5>
                                <%
                                    }
                                %>
                                <div class="card-body">
                                    <%
                                        if (vaccination1 == null && appointment1.getAppointmentStatus() == AppointmentStatus.Pending) {
                                    %>
                                    <h5 class="card-title">You received an appointment, please confirm or reject.</h5>
                                    <%
                                        }
                                    %>
                                    <div class="<%= vaccination1 == null ? "mb-4" : ""%>">
                                        <span class="font-weight-bold">Clinic Name:</span>
                                        <p><%= appointment1.getClinic().getClinicName()%></p>
                                        <span class="font-weight-bold">Vaccination Location:</span>
                                        <p><%= appointment1.getClinic().getAddressStreet()%>, <%= appointment1.getClinic().getAddressCity()%>, <%= appointment1.getClinic().getAddressState()%>, <%= appointment1.getClinic().getAddressPostcode()%>, <%= appointment1.getClinic().getAddressCountry()%></p>
                                        <span class="font-weight-bold">Appointment Date:</span>
                                        <p><%= appointment1.getAppointmentDate() != null ? new SimpleDateFormat("d MMM yyyy (EEE)").format(appointment1.getAppointmentDate()) : "-"%></p>
                                        <span class="font-weight-bold">Appointment Status:</span>
                                        <p class="m-0"><%= appointment1.getAppointmentStatus()%></p>
                                    </div>
                                    <%
                                        if (vaccination1 == null) {
                                            if (appointment1.getAppointmentStatus() == AppointmentStatus.Rejected) {
                                    %>
                                    <p class="font-weight-bold mb-0" style="color:red;">Your appointment will be rescheduled shortly. Please check your appointment notification frequently.</p>
                                    <%
                                    } else if (appointment1.getAppointmentStatus() == AppointmentStatus.Confirmed) {
                                    %>
                                    <p class="font-weight-bold">Please attend the appointment on time. You may update your appointment status anytime before the appointment date.</p>
                                    <form action="../ConfirmRejectAppointment" method="POST" id="appointmentStatusForm">
                                        <input type="hidden" id="appointmentStatus" name="appointmentStatus" value>
                                        <input type="hidden" id="appointmentId" name="appointmentId" value="<%= appointment1.getId()%>">
                                        <div class="d-flex justify-content-between flex-wrap" style="gap: .5rem;">
                                            <%
                                                if (appointment1.getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0) {
                                            %>
                                            <button class="btn btn-secondary font-weight-bold w-100" id="rejectAppointmentBtn" type="button">Reject</button>
                                            <%
                                            } else {
                                            %>
                                            <button class="btn btn-success font-weight-bold" id="confirmAppointmentBtn" style="width: 100px;" type="button">Confirm</button>
                                            <button class="btn btn-secondary font-weight-bold" id="rejectAppointmentBtn" style="width: 100px;" type="button">Reject</button>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <%
                                        if (appointment1.getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0) {
                                    %>
                                    <p class="font-weight-bold">Your appointment is expired. Please reject the appointment and wait for next appointment.</p>
                                    <%
                                        }
                                    %>
                                    <form action="../ConfirmRejectAppointment" method="POST" id="appointmentStatusForm">
                                        <input type="hidden" id="appointmentStatus" name="appointmentStatus" value>
                                        <input type="hidden" id="appointmentId" name="appointmentId" value="<%= appointment1.getId()%>">
                                        <div class="d-flex justify-content-between flex-wrap" style="gap: .5rem;">
                                            <%
                                                if (appointment1.getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0) {
                                            %>
                                            <button class="btn btn-secondary font-weight-bold w-100" id="rejectAppointmentBtn" type="button">Reject</button>
                                            <%
                                            } else {
                                            %>
                                            <button class="btn btn-success font-weight-bold" id="confirmAppointmentBtn" style="width: 100px;" type="button">Confirm</button>
                                            <button class="btn btn-secondary font-weight-bold" id="rejectAppointmentBtn" style="width: 100px;" type="button">Reject</button>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </form>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="col-12 col-md-6">
                            <%
                                if (vaccination1 != null) {
                            %>
                            <div class="card border-primary mb-3">
                                <h5 class="card-header font-weight-bold" style="color: #28a745;">
                                    #3 
                                    <i class="far fa-check-circle pr-2"></i>
                                    Vaccination Completed
                                </h5>
                                <div class="card-body">
                                    <h5 class="card-title">Thank you for being one of the vaccinators.</h5>
                                    <div>
                                        <span class="font-weight-bold">Vaccination Date:</span>
                                        <p><%= vaccination1.getCompleteVaccinationDate() != null ? new SimpleDateFormat("d MMM yyyy (EEE)").format(vaccination1.getCompleteVaccinationDate()) : "-"%></p>
                                        <span class="font-weight-bold">Vaccination Time:</span>
                                        <p class="m-0"><%= vaccination1.getCompleteVaccinationTime() != null ? new SimpleDateFormat("hh:mm aaa").format(vaccination1.getCompleteVaccinationTime()) : "-"%></p>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <!-- Begin: Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
    </body>
    <script>
        $('#confirmAppointmentBtn').click(function () {
            submitAppointmentStatus(2);
        });

        $('#rejectAppointmentBtn').click(function () {
            submitAppointmentStatus(1);
        });

        function submitAppointmentStatus(status) {
            $("#appointmentStatus").val(status);
            $("#confirmAppointmentBtn").prop("disabled", true);
            $("#rejectAppointmentBtn").prop("disabled", true);
            $("#appointmentStatusForm").submit();
            Swal.fire({
                title: 'One moment please...',
                allowEscapeKey: false,
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
        }
    </script>
    <script>
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
        <%
            if (session.getAttribute(ConstantSession.Success) != null && session.getAttribute(ConstantSession.Success).equals(ConstantMessage.True)) {
        %>
        function showSuccessMessage() {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                    confirmButton: 'btn btn-success'
                },
                buttonsStyling: false
            });
            swalWithBootstrapButtons.fire({
                icon: 'success',
                title: '<span style="display: flex;padding: .8em 1em 0;justify-content: center;letter-spacing: 2px;"><%= session.getAttribute(ConstantSession.SuccessMessage)%></span>',
                showConfirmButton: true,
                confirmButtonText: 'Confirm'
            });
        }
        window.onload = showSuccessMessage;
        <%
                session.setAttribute(ConstantSession.Success, null);
                session.setAttribute(ConstantSession.SuccessMessage, null);
            }
        %>
    </script>
</html>