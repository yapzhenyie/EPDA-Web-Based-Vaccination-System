<%-- 
    Document   : schedule-appointment
    Created on : Oct 11, 2021, 5:34:45 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="utils.EnumState"%>
<%@page import="constants.ConstantSession"%>
<%@page import="constants.ConstantLink"%>
<%@page import="constants.ConstantMessage"%>
<%@page import="classes.AccountStatus"%>
<%@page import="classes.UserRole"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) == null) {
        response.sendRedirect(ConstantLink.UrlLogin);
        return;
    }
    if (!session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
        response.sendRedirect(ConstantLink.UrlDashboard);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Schedule Appointment | Appointment | EPDA Vaccination System</title>
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
        <style>
            .table-striped.table.table-bordered.table-hover {
                width: 100% !important;
            }

            .fixed-table-border {
                min-width: 100% !important;
            }

            .fixed-table-header table {
                display: none;
            }

            .fixed-table-body table {
                margin-top: 0 !important;
            }

            .fixed-table-container.fixed-height {
                overflow: auto;
            }

            .fixed-table-container.fixed-height .fixed-table-body {
                overflow-x: unset;
                overflow-y: unset;
            }
        </style>
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
                        <h2 class="font-weight-bold col-12">Schedule Appointment</h2>
                    </div>
                    <div>
                        <form class="container-fluid" id="scheduleAppointmentForm" action="../ScheduleAppointment" method="POST">
                            <p>
                                Please select the vaccinator's option to make an appointment. 
                                <br>
                                The options selected will affect the people who receive the vaccination appointment.
                            </p>
                            <div class="form-group row">
                                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                    <label class="col-form-label required" for="doseNo">Dose No.</label>
                                    <label class="select-icon">
                                        <select class="form-control" name="doseNo" id="doseNo">
                                            <option value="">-Please Select-</option>
                                            <option value="1">1</option>
                                        </select>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-sm-6">
                                    <fieldset class="v-fieldset-appointment">
                                        <legend class="v-fieldset-legend required">Appointment Date</legend>
                                        <label class="el-radio">
                                            <input type="radio" name="appointmentDate" value="1">
                                            <span class="el-radio-style"></span>
                                            <span>1 Day Later</span>
                                        </label>
                                        <label class="el-radio">
                                            <input type="radio" name="appointmentDate" value="2">
                                            <span class="el-radio-style"></span>
                                            <span>3 Days Later</span>
                                        </label>
                                        <label class="el-radio">
                                            <input type="radio" name="appointmentDate" value="3">
                                            <span class="el-radio-style"></span>
                                            <span>7 Days Later</span>
                                        </label>
                                        <label class="el-radio">
                                            <input type="radio" name="appointmentDate" value="4">
                                            <span class="el-radio-style"></span>
                                            <span>14 Days Later</span>
                                        </label>
                                    </fieldset>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <fieldset class="v-fieldset-appointment" id="genderFieldset">
                                        <legend class="v-fieldset-legend required">Gender</legend>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="genderMale" name="genderMale" value="true" checked>
                                            <label for="genderMale" class="el-checkbox-style"></label>
                                            <span>Male</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="genderFemale" name="genderFemale" value="true" checked>
                                            <label for="genderFemale" class="el-checkbox-style"></label>
                                            <span>Female</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="genderUnspecified" name="genderUnspecified" value="true" checked>
                                            <label for="genderUnspecified" class="el-checkbox-style"></label>
                                            <span>Unspecified</span>
                                        </label>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-sm-6">
                                    <fieldset class="v-fieldset-appointment" id="ageGroupFieldset">
                                        <legend class="v-fieldset-legend required">Age Group</legend>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="ageGroup12To17" name="ageGroup12To17" value="true" checked>
                                            <label for="ageGroup12To17" class="el-checkbox-style"></label>
                                            <span>12 - 17</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="ageGroup18To24" name="ageGroup18To24" value="true" checked>
                                            <label for="ageGroup18To24" class="el-checkbox-style"></label>
                                            <span>18 - 24</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="ageGroup25To34" name="ageGroup25To34" value="true" checked>
                                            <label for="ageGroup25To34" class="el-checkbox-style"></label>
                                            <span>25 - 34</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="ageGroup35To54" name="ageGroup35To54" value="true" checked>
                                            <label for="ageGroup35To54" class="el-checkbox-style"></label>
                                            <span>35 - 54</span>
                                        </label>
                                        <label class="el-checkbox">
                                            <input type="checkbox" id="ageGroup55AndAbove" name="ageGroup55AndAbove" value="true" checked>
                                            <label for="ageGroup55AndAbove" class="el-checkbox-style"></label>
                                            <span>55 and Above</span>
                                        </label>
                                    </fieldset>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <fieldset class="v-fieldset-appointment" id="stateFieldset" style="max-height: 248.5px;overflow-y: scroll;padding-bottom: 31px;">
                                        <legend class="v-fieldset-legend required">State</legend>
                                        <c:set var="states" value="<%=EnumState.values()%>"/>
                                        <c:forEach items="${states}" var="i">
                                            <label class="el-checkbox">
                                                <input type="checkbox" id="state${i.name()}" name="state${i.name()}" value="true" checked>
                                                <label for="state${i.name()}" class="el-checkbox-style"></label>
                                                <span>${i.getName()}</span>
                                            </label>
                                        </c:forEach>
                                    </fieldset>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end pt-3">
                                <button class="btn btn-primary font-weight-bold" id="scheduleAppointmentBtn" type="submit">Schedule Appointment</button>
                            </div>
                        </form>
                    </div>
                    <div class="mt-5" style="overflow: hidden;">
                        <h2 class="font-weight-bold">
                            Registered Vaccinators
                        </h2>
                        <p class="m-0">All users available in the system whose account is active and not vaccinated yet.</p>
                        <p class="m-0">The list may include those who have accepted appointments but have not yet been vaccinated.</p>
                        <table class="table-striped" id="table" 
                               data-toggle="table" data-search="true" data-show-columns="true" 
                               data-show-columns-toggle-all="true" data-show-refresh="true" data-pagination="true" 
                               data-height="460" data-sort-name="name" data-sort-order="asc" 
                               data-buttons-class="primary"
                               data-ajax="ajaxRequest">
                            <thead>
                                <tr>
                                    <th data-field="name" rowspan="2" data-align="center" data-valign="middle" data-sortable="true">Name</th>
                                    <th data-field="accountId" rowspan="2" data-valign="middle" data-sortable="true">Account</th>
                                    <th data-field="nricNo" rowspan="2" data-valign="middle" data-sortable="true">NRIC No.</th>
                                    <th data-field="gender" rowspan="2" data-valign="middle" data-sortable="true"data-visible="false">Gender</th>
                                    <th data-field="dateOfBirth" rowspan="2" data-valign="middle" data-sortable="true"data-visible="false">Date of Birth</th>
                                    <th data-field="contactNo" rowspan="2" data-valign="middle" data-sortable="true"data-visible="false">Contact No.</th>
                                    <th colspan="5" data-align="center">Address</th>
                                    <th data-field="status" rowspan="2" data-align="center" data-valign="middle" data-sortable="true">Status</th>
                                </tr>
                                <tr>
                                    <th data-field="addressStreet" data-sortable="true" data-visible="false">Street</th>
                                    <th data-field="addressCity" data-sortable="true" data-visible="false">City</th>
                                    <th data-field="addressState" data-sortable="true">State</th>
                                    <th data-field="addressPostcode" data-sortable="true" data-visible="false">Postcode</th>
                                    <th data-field="addressCountry" data-sortable="true" data-visible="false">Country</th>
                                </tr>
                            </thead>
                        </table>
                    </div> 
                    <div class="mt-5" style="overflow: hidden;">
                        <h2 class="font-weight-bold">
                            Registered Clinic
                        </h2>
                        <span>All clinic users available in the system whose account is active.</span>
                        <table class="table-striped" id="table2" 
                               data-toggle="table" data-search="true" data-show-columns="true" 
                               data-show-columns-toggle-all="true" data-show-refresh="true" data-pagination="true" 
                               data-height="460" data-sort-name="name" data-sort-order="asc" 
                               data-buttons-class="primary"
                               data-ajax="ajaxRequest1">
                            <thead>
                                <tr>
                                    <th data-field="clinicName" rowspan="2" data-valign="middle" data-sortable="true">Clinic Name</th>
                                    <th data-field="vaccinationCapacity" rowspan="2" data-valign="middle" data-sortable="true">Vaccination Capacity</th>
                                    <th data-field="name" rowspan="2" data-align="center" data-valign="middle" data-sortable="true" data-visible="false">Name</th>
                                    <th data-field="accountId" rowspan="2" data-valign="middle" data-sortable="true">Account</th>
                                    <th data-field="nricNo" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">NRIC No.</th>
                                    <th data-field="gender" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">Gender</th>
                                    <th data-field="dateOfBirth" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">Date of Birth</th>
                                    <th data-field="contactNo" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">Contact No.</th>
                                    <th colspan="5" data-align="center">Address</th>
                                    <th data-field="status" rowspan="2" data-align="center" data-valign="middle" data-sortable="true">Status</th>
                                </tr>
                                <tr>
                                    <th data-field="addressStreet" data-sortable="true" data-visible="false">Street</th>
                                    <th data-field="addressCity" data-sortable="true" data-visible="false">City</th>
                                    <th data-field="addressState" data-sortable="true">State</th>
                                    <th data-field="addressPostcode" data-sortable="true" data-visible="false">Postcode</th>
                                    <th data-field="addressCountry" data-sortable="true" data-visible="false">Country</th>
                                </tr>
                            </thead>
                        </table>
                    </div> 
                    <!-- Begin: Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
    </body>
    <script>
        $(document).ready(function () {
            $("#scheduleAppointmentForm").validate({
                rules: {
                    doseNo: {
                        required: true
                    }
                },
                messages: {
                    doseNo: {
                        required: "The Dose No. field is required."
                    }
                }
            });
        });
        
        function isAppointmentDateSelected() {
            var num = 0;
            $('input[name="appointmentDate"]').each(function(e) {
                if ($(this).prop('checked') === false) {
                    num++;
                }
            });
            if(num === 4) 
                return false;
            return true;
        }
        
        function isGenderSelected() {
            var num = 0;
            
            $('#genderFieldset input[type="checkbox"]').each(function(e) {
                if ($(this).prop('checked') === false) {
                    num++;
                }
            });
            if(num === 3) 
                return false;
            return true;
        }
        
        function isAgeGroupSelected() {
            var num = 0;
            
            $('#ageGroupFieldset input[type="checkbox"]').each(function(e) {
                if ($(this).prop('checked') === false) {
                    num++;
                }
            });
            if(num === 5) 
                return false;
            return true;
        }
        
        function isStateSelected() {
            var num = 0;
            
            $('#stateFieldset input[type="checkbox"]').each(function(e) {
                if ($(this).prop('checked') === false) {
                    num++;
                }
            });
            if(num === 16) 
                return false;
            return true;
        }

        $("#scheduleAppointmentForm").submit(function () {
            if (!isAppointmentDateSelected()) {
                showInputErrorMessage("Please select an appointment date.");
                return false;
            }
            if (!isGenderSelected()) {
                showInputErrorMessage("Gender cannot be empty.");
                return false;
            }
            if (!isAgeGroupSelected()) {
                showInputErrorMessage("Age Group cannot be empty.");
                return false;
            }
            if (!isStateSelected()) {
                showInputErrorMessage("State cannot be empty.");
                return false;
            }
            
            if ($('#scheduleAppointmentForm').valid()) {
                $("#scheduleAppointmentBtn").prop("disabled", true);
                Swal.fire({
                    title: 'One moment please...',
                    allowEscapeKey: false,
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
            }
        });

        function ajaxRequest(params) {
            var url = '../APIListPublicUser?status=active&vaccinatedStatus=false&doseNo=1';
            $.get(url).then(function (res) {
                params.success(res);
            });
        }

        function ajaxRequest1(params) {
            var url = '../APIListClinicStaff?status=active';
            $.get(url + '&' + $.param(params.data)).then(function (res) {
                params.success(res);
            });
        }
        
        function showInputErrorMessage(msg) {
            Swal.fire({
                icon: 'error',
                title: '<span style="display: flex;padding: .8em 1em 0;justify-content: center;letter-spacing: 2px;">' + msg + '</span>',
                showConfirmButton: true,
                confirmButtonText: 'Confirm'
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
