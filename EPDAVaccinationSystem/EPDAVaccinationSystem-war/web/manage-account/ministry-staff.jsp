<%-- 
    Document   : ministry-staff
    Created on : Oct 8, 2021, 10:56:39 PM
    Author     : Yap Zhen Yie
--%>
<%@page import="classes.AccountStatus"%>
<%@page import="constants.ConstantMessage"%>
<%@page import="utils.EnumState"%>
<%@page import="model.MinistryStaffFacade"%>
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
    MinistryStaffFacade ministryStaffFacade;
%>
<%
    try {
        context = new InitialContext();
        ministryStaffFacade = (MinistryStaffFacade) context
                .lookup("java:global/EPDAVaccinationSystem/EPDAVaccinationSystem-ejb/MinistryStaffFacade!model.MinistryStaffFacade");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ministry Staff | Manage Account | EPDA Vaccination System</title>
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
                        <h2 class="font-weight-bold col-12 col-md-6">Ministry Staff</h2>
                        <div class="tools d-flex justify-content-end ml-auto col-12 col-md-6">
                            <button class="btn btn-outline-primary" type="button" data-toggle="modal" data-target="#newMinistryStaffModal">
                                <i class="fas fa-plus-circle"></i>
                                <span>New Ministry Staff</span>
                            </button>
                        </div>
                    </div>
                    <div class="container-fluid mb-3">
                        <div class="row">
                            <div class="col-12 col-md-6 col-lg-4 v-card color-2">
                                <i class="far fa-address-card"></i>
                                <div class="v-card-details">
                                    <span class="v-card-description">Ministry Staff</span>
                                    <div class="v-card-value">
                                        <span><%= ministryStaffFacade.count()%></span>
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
                               data-url="../APIListMinistryStaff">
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
        <!-- Begin: New Ministry Staff Modal -->
        <div class="modal fade" id="newMinistryStaffModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="newMinistryStaffLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newMinistryStaffLabel">New Ministry Staff</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="../NewMinistryStaff" method="POST" id="newMinistryStaffForm" autocomplete = "off">
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="fullName">Full Name</label>
                                    <input class="form-control" name="fullName" type="text" id="fullName" placeholder="Full Name" tabindex = "1"> 
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="col-form-label required" for="nricNo">NRIC No.</label>
                                    <input class="form-control" name="nricNo" type="text" id="nricNo" placeholder="xxxxxx-xx-xxxx" tabindex = "2">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="gender">Gender</label>
                                    <label class="select-icon">
                                        <select class="form-control" name="gender" id="gender" tabindex = "3">
                                            <option value="">-Please Select-</option>
                                            <option value="0">Male</option>
                                            <option value="1">Female</option>
                                            <option value="2">Unspecified</option>
                                        </select>
                                    </label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="col-form-label required" for="dateOfBirth">Date of Birth</label>
                                    <input class="form-control" name="dateOfBirth" type="date" id="dateOfBirth" tabindex = "4"> 
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="contactNo">Contact No.</label>
                                    <input class="form-control" name="contactNo" type="tel" id="contactNo" placeholder="Contact No." tabindex = "5"> 
                                </div>
                            </div>
                            <div class="font-weight-bold mt-4">Address</div>
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="addressStreet">Street</label>
                                    <input class="form-control" name="addressStreet" type="text" id="addressStreet" placeholder="Street" tabindex = "6"> 
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="col-form-label required" for="addressCity">City</label>
                                    <input class="form-control" name="addressCity" type="text" id="addressCity" placeholder="City" tabindex = "7"> 
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="addressState">State</label>
                                    <label class="select-icon">
                                        <select class="form-control" name="addressState" id="addressState" tabindex = "8">
                                            <option value="">-Please Select-</option>
                                            <c:set var="states" value="<%=EnumState.values()%>"/>
                                            <c:forEach items="${states}" var="i">
                                                <option value="${i.getName()}"><c:out value="${i.getName()}"/></option>
                                            </c:forEach>
                                        </select>
                                    </label>
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="col-form-label required" for="addressPostcode">Postcode</label>
                                    <input class="form-control" name="addressPostcode" type="text" id="addressPostcode" placeholder="Postcode" tabindex = "9"> 
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12 col-md-6 mb-3 mb-md-0">
                                    <label class="col-form-label required" for="addressCountry">Country</label>
                                    <input class="form-control" name="addressCountry" type="text" id="addressCountry" value="Malaysia" readonly> 
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <label class="col-form-label required" for="emailAddress">Email Address</label>
                                    <div class="input-group">
                                        <input class="form-control" name="emailAddress" type="email" id="emailAddress" placeholder="example@mail.com" tabindex = "10" autocomplete="off" style="padding-right: 2rem;"> 
                                        <div class="d-flex position-absolute justify-content-center align-items-center" id="emailValidity_status" style="right: 8px; height: 38px;z-index: 100;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <label class="col-form-label required" for="password">Password</label>
                                    <input class="form-control" name="password" type="password" id="password" placeholder="Password" tabindex = "11">
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-12">
                                    <label class="col-form-label required" for="confirmPassword">Confirm Password</label>
                                    <input class="form-control" name="confirmPassword" type="password" id="confirmPassword" placeholder="Confirm Password" tabindex = "12">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" tabindex = "14">Cancel</button>
                        <button type="submit" class="btn btn-primary" form="newMinistryStaffForm" id="submitBtn" tabindex = "13" disabled>Create Account</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- End: New Ministry Staff Modal -->
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
        $(document).ready(function () {
            $.validator.addMethod("nric", function (value, element) {
                return this.optional(element) || /^\d{6}-\d{2}-\d{4}$/i.test(value);
            }, "Invalid NRIC No.");
            $.validator.addMethod("contact", function (value, element) {
                return this.optional(element) || /^\d{0,14}$/i.test(value);
            }, "Please key in a valid Contact No.");
            $.validator.addMethod("postcode", function (value, element) {
                return this.optional(element) || /^\d{5}$/i.test(value);
            }, "Please key in a valid Postcode");
            $("#newMinistryStaffForm").validate({
                rules: {
                    fullName: {
                        required: true
                    },
                    nricNo: {
                        required: true,
                        nric: true
                    },
                    gender: {
                        required: true
                    },
                    dateOfBirth: {
                        required: true,
                        date: true
                    },
                    contactNo: {
                        required: true,
                        contact: true
                    },
                    addressStreet: "required",
                    addressCity: "required",
                    addressState: "required",
                    addressPostcode: {
                        required: true,
                        postcode: true
                    },
                    addressCountry: "required",
                    emailAddress: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        minlength: 5
                    },
                    confirmPassword: {
                        required: true,
                        minlength: 5,
                        equalTo: "#password"
                    }
                },
                messages: {
                    fullName: {
                        required: "The Full Name field is required."
                    },
                    nricNo: {
                        required: "The NRIC No. field is required."
                    },
                    gender: {
                        required: "The Gender field is required."
                    },
                    dateOfBirth: {
                        required: "The Date of Birth field is required.",
                        date: "The field Date of Birth must be a date."
                    },
                    contactNo: {
                        required: "The Contact No. field is required."
                    },
                    addressStreet: "The Street field is required.",
                    addressCity: "The City field is required.",
                    addressState: "The State field is required.",
                    addressPostcode: {
                        required: "The Postcode field is required."
                    },
                    addressCountry: "The Country field is required.",
                    emailAddress: {
                        required: "The Email Address field is required.",
                        email: "Please key in a valid Email Address."
                    },
                    password: {
                        required: "The Password field is required.",
                        minlength: "Password length cannot be less than 5 characters."
                    },
                    confirmPassword: {
                        required: "The Confirm Password field is required.",
                        minlength: "Password length cannot be less than 5 characters.",
                        equalTo: "The password information does not match."
                    }
                }
            });
        });

        $("#newMinistryStaffForm").submit(function () {
            if ($('#newMinistryStaffForm').valid()) {
                $("#submitBtn").prop("disabled", true);
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

        $('#nricNo').on('input', function (e) {
            $(this).val(function () {
                return ReplaceICFormat($(this).val());
            });

            PopulateDateOfBirth();
        });

        $('#contactNo').on('input', function (e) {
            $(this).val(function () {
                return $(this).val().replace(/[\D\s\._\-]+/g, '');
            });
        });

        var isCheckingEmail = false;

        $(window).keydown(function (event) {
            if (isCheckingEmail && event.keyCode === 13) {
                event.preventDefault();
                return false;
            }
        });

        $('#emailAddress').on('input', function (e) {
            onCheckEmailValidity($(this).val());
        });

        var delayTimer;
        function onCheckEmailValidity(inputText) {
            clearTimeout(delayTimer);
            if (/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(inputText)) {
                delayTimer = setTimeout(function () {
                    $.ajax({
                        url: '../APIIsEmailExist?emailAddress=' + inputText,
                        type: 'GET',
                        dataType: 'json',
                        cache: true,
                        async: true,
                        beforeSend: function () {
                            isCheckingEmail = true;
                            $("#submitBtn").prop("disabled", true);
                            $("#emailValidity_status").html(
                                    '<div class="spinner-border text-primary" role="status" style="width:1.5rem; height:1.5rem;">' +
                                    '<span class="sr-only">Checking...</span>' +
                                    '</div>');
                        },
                        success: function (result) {
                            if (result.valid === true) {
                                isCheckingEmail = false;
                                $("#submitBtn").prop("disabled", false);
                                $("#emailValidity_status").html('<i class="fas fa-check-circle" style="font-size: 1.5rem;color: #00D100;"' +
                                        'data-toggle="tooltip" data-placement="right" title="<%= ConstantMessage.EmailAddressIsApproved%>"></i>');
                            } else {
                                $("#emailValidity_status").html('<i class="fas fa-times-circle" style="font-size: 1.5rem;color: red;"' +
                                        'data-toggle="tooltip" data-placement="right" title="<%= ConstantMessage.EmailAddressAlreadyExist%>"></i>');
                            }
                            $('[data-toggle="tooltip"]').tooltip();
                        },
                        error: function (xhr, status, error) {
                            alert(xhr.responseText);
                        }
                    });
                }, 100);
            }
        }

        function ReplaceICFormat(input) {
            input = input.replace(/[\D\s\._\-]+/g, '');
            if (input.length > 12) {
                input = input.substr(0, 12);
            }

            var split = 6;
            var chunk = [];

            for (var i = 0, len = input.length; i < len; i += split) {
                if (i === 6) {
                    split = 2;
                } else if (i === 8) {
                    split = 4;
                }
                chunk.push(input.substr(i, split));
            }

            return chunk.join("-");
        }

        function PopulateDateOfBirth() {
            var dob = $('#nricNo').val().replace(/[\-]+/g, "");
            if (dob.length !== 12) {
                return;
            }

            var yearOfBirth = dob.substring(0, 2);
            var monthOfBirth = dob.substring(2, 4);
            var dayOfBirth = dob.substring(4, 6);
            var yearNow = new Date().getFullYear();
            var dateString = undefined;

            if (Number(yearOfBirth) > yearNow - 2000) {
                dateString = '19' + yearOfBirth + "-" + monthOfBirth + "-" + dayOfBirth;
            } else {
                dateString = '20' + yearOfBirth + "-" + monthOfBirth + "-" + dayOfBirth;
            }

            if (!isNaN(new Date(dateString))) {
                $('#dateOfBirth').val(dateString);
            } else {
                $('#dateOfBirth').val(null);
            }
        }

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
                loadViewUserDetailsModal(row.accountId, "<%= UserRole.Ministry_Staff.toString()%>");
            },
            'click .edit': function (e, value, row, index) {
                loadEditUserDetailsModal(row.accountId, "<%= UserRole.Ministry_Staff.toString()%>", "<%= ConstantLink.UrlManageAccountMinistryStaff%>");
            },
            'click .lock': function (e, value, row, index) {
                showLockUnlockAccountModal(true, row.accountId, "<%= ConstantLink.UrlManageAccountMinistryStaff%>");
            },
            'click .unlock': function (e, value, row, index) {
                showLockUnlockAccountModal(false, row.accountId, "<%= ConstantLink.UrlManageAccountMinistryStaff%>");
            },
            'click .reset': function (e, value, row, index) {
                showResetPasswordModal(row.accountId, "<%= ConstantLink.UrlManageAccountMinistryStaff%>");
            },
            'click .delete': function (e, value, row, index) {
                showDeleteAccountModal(row.accountId, "<%= ConstantLink.UrlManageAccountMinistryStaff%>");
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
            })
        }
        window.onload = showSuccessMessage;
        <%
                session.setAttribute(ConstantSession.Success, null);
                session.setAttribute(ConstantSession.SuccessMessage, null);
            }
        %>
    </script>
</html>
