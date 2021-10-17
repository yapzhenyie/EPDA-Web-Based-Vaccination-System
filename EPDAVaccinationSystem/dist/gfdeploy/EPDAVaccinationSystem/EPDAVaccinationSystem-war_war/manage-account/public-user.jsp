<%-- 
    Document   : public-user
    Created on : Oct 9, 2021, 4:48:05 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="constants.ConstantMessage"%>
<%@page import="classes.AccountStatus"%>
<%@page import="model.PublicUserFacade"%>
<%@page import="classes.UserRole"%>
<%@page import="constants.ConstantSession"%>
<%@page import="constants.ConstantLink"%>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.Context" %>
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
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Public User | Manage Account | EPDA Vaccination System</title>
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
                        <h2 class="font-weight-bold col-12">Public User</h2>
                    </div>
                    <div class="container-fluid mb-3">
                        <div class="row">
                            <div class="col-12 col-md-6 col-lg-4 v-card color-1">
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
                    <div style="overflow: hidden;">
                        <table class="table-striped" id="table" 
                               data-toggle="table" data-search="true" data-show-columns="true" 
                               data-show-columns-toggle-all="true" data-show-refresh="true" data-pagination="true" 
                               data-height="660" data-sort-name="name" data-sort-order="asc" 
                               data-buttons-class="primary"
                               data-url="../APIListPublicUser">
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
                                    <th data-field="action" rowspan="2" data-align="center" data-valign="middle" data-formatter="actionFormatter" data-events="operateAction" data-width="300">Action</th>
                                </tr>
                                <tr>
                                    <th data-field="addressStreet" data-sortable="true" data-visible="false">Street</th>
                                    <th data-field="addressCity" data-sortable="true" data-visible="false">City</th>
                                    <th data-field="addressState" data-sortable="true" data-visible="false">State</th>
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
        <!-- Begin: View User Details Modal -->
        <jsp:include page="layout/viewUserDetailsModal.jsp" />
        <!-- End: View User Details Modal -->
        <!-- Begin: Edit User Details Modal -->
        <jsp:include page="layout/editUserDetailsModal.jsp" />
        <!-- End: Edit User Details Modal -->
        <!-- Begin: Lock Unlock Account Modal -->
        <jsp:include page="layout/lockUnlockAccountModal.jsp" />
        <!-- End: Lock Unlock Account Modal -->
        <!-- Begin: Reset Password Modal -->
        <jsp:include page="layout/resetPasswordModal.jsp" />
        <!-- End: Reset Password Modal -->
        <!-- Begin: Delete Account Modal -->
        <jsp:include page="layout/deleteAccountModal.jsp" />
        <!-- End: Delete Account Modal -->
    </body>
    <script>
        var $table = $('#table');

        function actionFormatter(value, row, index) {
            var accountStatusBtn = "";

            if (row.status === "<%= AccountStatus.Active%>") {
                accountStatusBtn =
                        '<a class="lock btn btn-secondary btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="Lock Account" role="button" aria-pressed="true">'+
                        '<i class="fas fa-lock pr-2"></i>'+
                        'Lock Account</a>';
            } else if (row.status === "<%= AccountStatus.Locked%>") {
                accountStatusBtn =
                        '<a class="unlock btn btn-secondary btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="Unlock Account" role="button" aria-pressed="true">'+
                        '<i class="fas fa-unlock pr-2"></i>'+
                        'Unlock Account</a>';
            }

            return [
                '<div class="d-flex justify-content-center align-items-center row" style="margin-left: -12px; margin-right: -12px;">',
                '<a class="view btn btn-primary btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="View" role="button" aria-pressed="true">',
                '<i class="far fa-eye pr-2"></i>',
                'View</a>',
                '<a class="edit btn btn-success btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="Edit" role="button" aria-pressed="true">',
                '<i class="far fa-edit pr-2"></i>',
                'Edit</a>',
                accountStatusBtn,
                '<a class="reset btn btn-warning btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="Reset Password" role="button" aria-pressed="true">',
                '<i class="fas fa-undo-alt pr-2"></i>',
                'Reset Password</a>',
                '<a class="delete btn btn-danger btn-sm ml-2 mr-2 mb-2" href="javascript:void(0)" title="Delete Account" role="button" aria-pressed="true">',
                '<i class="far fa-trash-alt pr-2"></i>',
                'Delete Account</a>',
                '</div>'
            ].join('');
        }

        window.operateAction = {
            'click .view': function (e, value, row, index) {
                loadViewUserDetailsModal(row.accountId, "<%= UserRole.Public_User.toString()%>");
            },
            'click .edit': function (e, value, row, index) {
                loadEditUserDetailsModal(row.accountId, "<%= UserRole.Public_User.toString()%>", "<%= ConstantLink.UrlManageAccountPublicUser%>");
            },
            'click .lock': function (e, value, row, index) {
                showLockUnlockAccountModal(true, row.accountId, "<%= ConstantLink.UrlManageAccountPublicUser%>");
            },
            'click .unlock': function (e, value, row, index) {
                showLockUnlockAccountModal(false, row.accountId, "<%= ConstantLink.UrlManageAccountPublicUser%>");
            },
            'click .reset': function (e, value, row, index) {
                showResetPasswordModal(row.accountId, "<%= ConstantLink.UrlManageAccountPublicUser%>");
            },
            'click .delete': function (e, value, row, index) {
                showDeleteAccountModal(row.accountId, "<%= ConstantLink.UrlManageAccountPublicUser%>");
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
