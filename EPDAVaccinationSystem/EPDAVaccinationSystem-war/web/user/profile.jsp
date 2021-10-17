<%-- 
    Document   : profile
    Created on : Oct 8, 2021, 10:11:13 PM
    Author     : Yap Zhen Yie
--%>
<%@page import="constants.ConstantMessage"%>
<%@page import="classes.UserRole"%>
<%@page import="utils.EnumState"%>
<%@page import="constants.ConstantLink"%>
<%@page import="constants.ConstantSession"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) == null
            || session.getAttribute(ConstantSession.User) == null) {
        response.sendRedirect(ConstantLink.UrlLogin);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile | EPDA Vaccination System</title>
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

        <!-- Mandatory JavaScript Library -->
        <script src="../assets/vendors/jquery/jquery.min.js"></script>
        <script src="../assets/vendors/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/vendors/jQuery-Validation/dist/jquery.validate.js"></script>
        <script src="../assets/js/script-bundle.js"></script>

        <!-- Optional JavaScript Library -->
        <script src="../assets/vendors/SweetAlert2/sweetalert2.all.min.js"></script>
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
                        <h2 class="font-weight-bold col-12">Profile</h2>
                    </div>
                    <div class="v-profile d-flex">
                        <div class="v-profile-navbar container">
                            <ul class="list-unstyled">
                                <li>
                                    <a class="active" id="profileBtn" href="javascript:void(0)">Profile Details</a>
                                </li>
                                <li>
                                    <a id="changePasswordBtn" href="javascript:void(0)">Change Password</a>
                                </li>
                            </ul>
                        </div>
                        <div class="v-profile-content">
                            <form class="container z-hide" id="profileDetailsForm" action="../UpdateProfile" method="POST">
                                <div>
                                    <h3 class="font-weight-bold mb-4">Profile Details</h3>
                                </div>
                                <%
                                    if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
                                %>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="clinicName">Clinic Name</label>
                                        <input class="form-control" name="clinicName" type="text" id="clinicName" placeholder="Clinic Name" tabindex = "1"> 
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required" for="vaccinationCapacity">Vaccination Capacity (Per day)</label>
                                        <input class="form-control" name="vaccinationCapacity" type="number" id="vaccinationCapacity" tabindex = "2">
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="fullName">Full Name</label>
                                        <input class="form-control" name="fullName" type="text" id="fullName" placeholder="Full Name" tabindex = "3"> 
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="" for="emailAddress">Email Address</label>
                                        <input class="form-control" name="emailAddress" type="text" id="emailAddress" readonly>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="nricNo">NRIC No.</label>
                                        <input class="form-control" name="nricNo" type="text" id="nricNo" placeholder="xxxxxx-xx-xxxx" tabindex = "4">
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required" for="gender">Gender</label>
                                        <label class="select-icon">
                                            <select class="form-control" name="gender" id="gender" tabindex = "5">
                                                <option value="">-Please Select-</option>
                                                <option value="0">Male</option>
                                                <option value="1">Female</option>
                                                <option value="2">Unspecified</option>
                                            </select>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="dateOfBirth">Date of Birth</label>
                                        <input class="form-control" name="dateOfBirth" type="date" id="dateOfBirth" tabindex = "6"> 
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required" for="contactNo">Contact No.</label>
                                        <input class="form-control" name="contactNo" type="tel" id="contactNo" placeholder="Contact No." tabindex = "7"> 
                                    </div>
                                </div>
                                <%
                                    if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
                                %>
                                <div class="font-weight-bold mt-4 mb-2">Clinic Address</div>
                                <%
                                } else {
                                %>
                                <div class="font-weight-bold mt-4 mb-2">Address</div>
                                <%
                                    }
                                %>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="addressStreet">Street</label>
                                        <input class="form-control" name="addressStreet" type="text" id="addressStreet" placeholder="Street" tabindex = "8"> 
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required" for="addressCity">City</label>
                                        <input class="form-control" name="addressCity" type="text" id="addressCity" placeholder="City" tabindex = "9"> 
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="required" for="addressState">State</label>
                                        <label class="select-icon">
                                            <select class="form-control" name="addressState" id="addressState" tabindex = "10">
                                                <option value="">-Please Select-</option>
                                                <c:set var="states" value="<%=EnumState.values()%>"/>
                                                <c:forEach items="${states}" var="i">
                                                    <option value="${i.getName()}"><c:out value="${i.getName()}"/></option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required" for="addressPostcode">Postcode</label>
                                        <input class="form-control" name="addressPostcode" type="text" id="addressPostcode" placeholder="Postcode" tabindex = "11"> 
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                                        <label class="" for="addressCountry">Country</label>
                                        <input class="form-control" name="addressCountry" type="text" id="addressCountry" placeholder="Country" tabindex = "12" readonly> 
                                    </div>
                                </div>
                                <button class="submit-button btn btn-primary font-weight-bold" id="submitProfileDetailsBtn" type="submit" tabindex="13" style="padding-left: 60.5px;padding-right: 60.5px;">Save</button>
                            </form>
                            <form class="container z-hide" id="changePasswordForm" action="../ChangePassword" method="POST">       
                                <div>
                                    <h3 class="font-weight-bold mb-4">Change Password</h3>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-lg-6">
                                        <label class="required" for="oldPassword">Old Password</label>
                                        <input class="form-control" name="oldPassword" type="password" id="oldPassword" tabindex = "1"> 
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-lg-6">
                                        <label class="required" for="newPassword">New Password</label>
                                        <input class="form-control" name="newPassword" type="password" id="newPassword" tabindex = "2">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-12 col-lg-6">
                                        <label class="required" for="confirmNewPassword">Confirm New Password</label>
                                        <input class="form-control" name="confirmNewPassword" type="password" id="confirmNewPassword" tabindex = "3">
                                    </div>
                                </div>
                                <button class="submit-button btn btn-primary font-weight-bold" id="submitChangePasswordBtn" type="submit" tabindex="4">Change Password</button>
                            </form>
                        </div>
                    </div>
                    <!-- Begin: Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- End: Footer -->
                </div>
            </div>
        </div>
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
                $.validator.addMethod("notEqual", function (value, element, param) {
                    return this.optional(element) || value !== $(param).val();
                }, "New password cannot be the same as the old password.");
                $("#profileDetailsForm").validate({
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
                        clinicName: {
                            required: true
                        },
                        vaccinationCapacity: {
                            required: true,
                            min: 1
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
                        clinicName: {
                            required: "The Clinic Name field is required."
                        },
                        vaccinationCapacity: {
                            required: "The Vaccincation Capacity field is required."
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
                        }
                    }
                });
                $("#changePasswordForm").validate({
                    rules: {
                        oldPassword: {
                            required: true,
                            minlength: 5
                        },
                        newPassword: {
                            required: true,
                            minlength: 5,
                            notEqual: "#oldPassword"
                        },
                        confirmNewPassword: {
                            required: true,
                            minlength: 5,
                            equalTo: "#newPassword",
                            notEqual: "#oldPassword"
                        }
                    },
                    messages: {
                        oldPassword: {
                            required: "The Old Password field is required.",
                            minlength: "Password length cannot be less than 5 characters."
                        },
                        newPassword: {
                            required: "The New Password field is required.",
                            minlength: "Password length cannot be less than 5 characters."
                        },
                        confirmNewPassword: {
                            required: "The Confirm New Password field is required.",
                            minlength: "Password length cannot be less than 5 characters.",
                            equalTo: "The new password information does not match."
                        }
                    }
                });
            });

            $(function () {
                loadProfileDetails();
            });

            $('#profileBtn').on('click', function (event) {
                if ($(this).hasClass("active")) {
                    return false;
                }

                $('#changePasswordForm').hide();
                loadProfileDetails();
                $(this).toggleClass("active");
                $('#changePasswordBtn').toggleClass("active");
            });

            $('#changePasswordBtn').on('click', function (event) {
                if ($(this).hasClass("active")) {
                    return false;
                }

                $('#profileDetailsForm').hide();
                $('#loading').remove();
                clearChangePasswordForm();
                $('#changePasswordForm').show();
                $(this).toggleClass("active");
                $('#profileBtn').toggleClass("active");
                $('#oldPassword').focus();
            });

            $("#profileDetailsForm").submit(function () {
                if ($('#profileDetailsForm').valid()) {
                    $("#submitProfileDetailsBtn").prop("disabled", true);
                    Swal.fire({
                        title: 'Saving your profile...',
                        allowEscapeKey: false,
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });
                }
            });

            $("#changePasswordForm").submit(function () {
                if ($('#changePasswordForm').valid()) {
                    $("#changePasswordBtn").prop("disabled", true);
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
            });

            $('#contactNo').on('input', function (e) {
                $(this).val(function () {
                    return $(this).val().replace(/[\D\s\._\-]+/g, '');
                });
            });

            function clearChangePasswordForm() {
                $('#oldPassword').val(null);
                $('#newPassword').val(null);
                $('#confirmNewPassword').val(null);
            }

            function loadProfileDetails() {
                $.ajax({
                    type: "GET",
                    url: "../APIGetProfileDetails",
                    cache: true,
                    async: true,
                    beforeSend: function () {
                        $('#loading').remove();
                        $('<div class="w-100" id="loading" style="height: 635px;background: #fafafa;">' +
                                '<div class="d-flex h-100 m-auto bg-transparent">' +
                                '<div class="spinner-border text-primary" role="status" style="margin:auto;">' +
                                '<span class="sr-only">Loading...</span></div></div></div>').prependTo(".v-profile-content");
                    },
                    success: function (result) {
                        if (result !== null) {
            <%
                if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
            %>
                            $('#clinicName').val(result.clinicName);
                            $('#vaccinationCapacity').val(result.vaccinationCapacity);
            <%
                }
            %>
                            $('#fullName').val(result.name);
                            $('#emailAddress').val(result.accountId);
                            $('#nricNo').val(result.nricNo);
                            $('#gender').val(result.gender);
                            $('#dateOfBirth').val(result.dateOfBirth);
                            $('#contactNo').val(result.contactNo);
                            $('#addressStreet').val(result.addressStreet);
                            $('#addressCity').val(result.addressCity);
                            $('#addressState').val(result.addressState);
                            $('#addressPostcode').val(result.addressPostcode);
                            $('#addressCountry').val(result.addressCountry);
                            $('#loading').remove();
                            $('#profileDetailsForm').show();
                            $('#changePasswordForm').hide();
                        }
                    },
                    error: function (error) {
                        $('#loading').remove();
                        $('<div class="w-100" id="loading"style="height: 635px;background: #fafafa;">' +
                                '<div class="d-flex h-100 m-auto bg-transparent justify-content-center align-items-center">Error loading data</div></div>').prependTo(".v-profile-content");
                    }
                });
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
    </body>
</html>
