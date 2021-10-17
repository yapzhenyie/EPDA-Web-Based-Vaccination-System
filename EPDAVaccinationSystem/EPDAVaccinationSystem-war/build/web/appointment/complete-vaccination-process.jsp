<%-- 
    Document   : complete-vaccination-process
    Created on : Oct 11, 2021, 5:35:00 PM
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
    if (!session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
        response.sendRedirect(ConstantLink.UrlDashboard);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Complete Vaccination Process | Appointment | EPDA Vaccination System</title>
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
<!--        <script src="../assets/vendors/moment/moment.min.js"></script>-->
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
                        <h2 class="font-weight-bold col-12">Complete Vaccination Process</h2>
                    </div>
                    <div>
                        <div>
                            <button class="btn btn-primary" type="button" id="selectAllButton">
                                <i class="fas fa-clipboard-list"></i>
                                <span>View All</span>
                            </button>
                            <button class="btn btn-secondary" type="button" id="filterByButton">
                                <i class="fas fa-sort-amount-down-alt"></i>
                                <span>Filter by Appointment Date</span>
                            </button>
                        </div>
                        <div class="form-group row z-hide" id="filterGroup">
                            <div class="col-12 col-sm-8 col-md-4">
                                <label class="col-form-label required" for="appointmentDateInput">Appointment Date</label>
                                <input class="form-control" name="appointmentDateInput" type="date" id="appointmentDateInput" data-rule-required="true" data-msg-required="The Appointment Date field is required.">
                            </div>
                        </div>
                        <div class="mt-2" style="overflow: hidden;">
                            <table class="table-striped" id="table" 
                                   data-toggle="table" data-search="true" data-show-columns="true" 
                                   data-show-columns-toggle-all="true" data-show-refresh="true" data-pagination="true" 
                                   data-height="660" data-sort-name="appointmentDate" data-sort-order="asc" 
                                   data-buttons-class="primary"
                                   data-ajax="ajaxRequest">
                                <thead>
                                    <tr>
                                        <th data-field="vaccinatorName" rowspan="2" data-valign="middle" data-sortable="true">Name of Vaccinator</th>
                                        <th data-field="vaccinatorNricNo" rowspan="2" data-valign="middle" data-sortable="true">NRIC No.</th>
                                        <th data-field="vaccinatorGender" rowspan="2" data-valign="middle" data-sortable="true">Gender</th>
                                        <th data-field="vaccinatorDateOfBirth" rowspan="2" data-valign="middle" data-sortable="true">Date of Birth</th>
                                        <th data-field="vaccinatorContactNo" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">Contact No.</th>
                                        <th colspan="5" data-align="center">Address</th>
                                        <th data-field="doseNo" rowspan="2" data-valign="middle" data-sortable="true" data-align="center" >Dose No.</th>
                                        <th data-field="clinicName" rowspan="2" data-valign="middle" data-sortable="true" data-visible="false">Clinic Name</th>
                                        <th data-field="appointmentStatus" rowspan="2" data-valign="middle" data-sortable="true" data-align="center" >Appointment Status</th>
                                        <th data-field="appointmentDate" rowspan="2" data-valign="middle" data-sortable="true">Appointment Date</th>
                                        <th data-field="action" data-align="center" data-valign="middle" data-formatter="actionFormatter" data-events="operateAction">Action</th>
                                    </tr>
                                    <tr>
                                        <th data-field="vaccinatorAddressStreet" data-sortable="true" data-visible="false">Street</th>
                                        <th data-field="vaccinatorAddressCity" data-sortable="true" data-visible="false">City</th>
                                        <th data-field="vaccinatorAddressState" data-sortable="true" data-visible="false">State</th>
                                        <th data-field="vaccinatorAddressPostcode" data-sortable="true" data-visible="false">Postcode</th>
                                        <th data-field="vaccinatorAddressCountry" data-sortable="true" data-visible="false">Country</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>            
                    </div>
                    <!-- Begin: Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
        <!-- Begin: Complete Vaccination Modal -->
        <jsp:include page="layout/completeVaccinationModal.jsp" />
        <!-- End: Complete Vaccination Modal -->
    </body>
    <script>
        $(document).ready(function () {
            $('#filterGroup').show();
            useFilterOption = true;
            var todayDate = new Date().toISOString().substring(0, 10);
            $("#appointmentDateInput").val(todayDate);
            refreshTable();
        });

        var $table = $('#table');
        var useFilterOption = false;

        $('#selectAllButton').click(function () {
            $('#filterGroup').hide();
            useFilterOption = false;
            refreshTable();
        });

        $('#filterByButton').click(function () {
            $('#filterGroup').show();
            useFilterOption = true;
            var todayDate = new Date().toISOString().substring(0, 10);
            $("#appointmentDateInput").val(todayDate);
            refreshTable();
        });

        $('#appointmentDateInput').on('input', function () {
            refreshTable();
        });

        function refreshTable() {
            $table.bootstrapTable('refresh');
        }

        function ajaxRequest(params) {
            var url = '../APIListPerClinicAppointment';
            if (useFilterOption) {
                url = url + '?appointmentDate=' + $("#appointmentDateInput").val();
            }
            $.get(url).then(function (res) {
                params.success(res);
            });
        }

        function actionFormatter(value, row, index) {
            var button =
                    '<div class="d-flex justify-content-center align-items-center row" style="margin-left: -12px; margin-right: -12px;">' +
                    '<a class="complete btn btn-success btn-sm ml-2 mr-2" href="javascript:void(0)" title="Complete Vaccination" role="button" aria-pressed="true">' +
                    '<i class="far fa-check-circle pr-2"></i>' +
                    'Complete Vaccination</a>' +
                    '</div>';
//            var date = moment(row.appointmentDate, "DD/MM/YYYY");
//            var todayDate = new Date();
//            todayDate.setHours(0, 0, 0, 0);
//            if (todayDate > date) {
//                button =
//                        '<div class="d-flex justify-content-center align-items-center row" style="margin-left: -12px; margin-right: -12px;">' +
//                        '<a class="btn btn-success btn-sm ml-2 mr-2" href="javascript:void(0)" title="Complete Vaccination" role="button" aria-pressed="true" disabled' +
//                        'data-toggle="tooltip" data-placement="right" title="Expired">' +
//                        '<i class="far fa-check-circle pr-2"></i>' +
//                        'Complete Vaccination</a>' +
//                        '</div>';
//            }
            return [button].join('');
        }

        window.operateAction = {
            'click .complete': function (e, value, row, index) {
                showCompleteVaccinationModal(row, "<%= ConstantLink.UrlAppointmentCompleteVaccinationProcess%>");
            }
        };
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


