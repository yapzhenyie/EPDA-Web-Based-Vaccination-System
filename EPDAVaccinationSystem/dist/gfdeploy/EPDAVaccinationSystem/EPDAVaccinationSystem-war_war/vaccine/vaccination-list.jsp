<%-- 
    Document   : vaccination-list
    Created on : Oct 19, 2021, 11:55:41 AM
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
        <title>Vaccination List | EPDA Vaccination System</title>
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
                        <h2 class="font-weight-bold col-12">Vaccination List</h2>
                    </div>
                    <div>
                        <div>
                            <button class="btn btn-primary" type="button" id="selectAllButton">
                                <i class="fas fa-clipboard-list"></i>
                                <span>View All</span>
                            </button>
                            <button class="btn btn-secondary" type="button" id="filterByButton">
                                <i class="fas fa-sort-amount-down-alt"></i>
                                <span>Filter by Vaccination Date</span>
                            </button>
                        </div>
                        <div class="form-group row z-hide" id="filterGroup">
                            <div class="col-12 col-sm-8 col-md-4">
                                <label class="col-form-label required" for="vaccinationDateInput">Vaccination Date</label>
                                <input class="form-control" name="vaccinationDateInput" type="date" id="vaccinationDateInput" data-rule-required="true" data-msg-required="The Vaccination Date field is required.">
                            </div>
                        </div>
                        <div class="mt-2" style="overflow: hidden;">
                            <table class="table-striped" id="table" 
                                   data-toggle="table" data-search="true" data-show-columns="true" 
                                   data-show-columns-toggle-all="true" data-show-refresh="true" data-pagination="true" 
                                   data-height="660" data-sort-name="vaccinationDate" data-sort-order="asc" 
                                   data-buttons-class="primary"
                                   data-ajax="ajaxRequest">
                                <thead>
                                    <tr>
                                        <th data-field="vaccinatorName"data-valign="middle" data-sortable="true">Name of Vaccinator</th>
                                        <th data-field="vaccinatorNricNo" data-valign="middle" data-sortable="true">NRIC No.</th>
                                        <th data-field="vaccinatorAccountId" data-valign="middle" data-sortable="true" data-visible="false">Vaccinator Account</th>
                                        <th data-field="clinicName" data-valign="middle" data-sortable="true" data-visible="false">Clinic Name</th>
                                        <th data-field="doseNo" data-valign="middle" data-sortable="true" data-align="center">Dose No.</th>
                                        <th data-field="vaccinationDate" data-valign="middle" data-sortable="true" data-align="center">Vaccination Date</th>
                                        <th data-field="vaccinationTime" data-valign="middle" data-sortable="true" data-align="center">Vaccination Time</th>
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
    </body>
    <script>
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
            $("#vaccinationDateInput").val(todayDate);
            refreshTable();
        });

        $('#vaccinationDateInput').on('input', function () {
            refreshTable();
        });

        function refreshTable() {
            $table.bootstrapTable('refresh');
        }

        function ajaxRequest(params) {
            var url = '../APIListVaccination';
            if (useFilterOption) {
                url = url + '?vaccinationDate=' + $("#vaccinationDateInput").val();
            }
            $.get(url).then(function (res) {
                params.success(res);
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

