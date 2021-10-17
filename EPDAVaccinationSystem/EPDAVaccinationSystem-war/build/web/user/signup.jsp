<%-- 
    Document   : signup
    Created on : Oct 3, 2021, 11:10:19 AM
    Author     : Yap Zhen Yie
--%>

<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<%@page import="utils.EnumState"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute(ConstantSession.UserCredentialRole) != null) {
        response.sendRedirect("../dashboard.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up | EPDA Vaccination System</title>
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
        <script src="../assets/vendors/popper/popper.js"></script>
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
                <div class="v-container-signup-form">
                    <div class="v-signup-form-portlet">
                        <div class="v-signup-form__header">
                            <h2 class="v-signup-form__header-content">
                                Sign Up
                            </h2>
                            <p class="v-signup-form__header-description">Please fill in this form to create an account!</p>
                        </div>
                        <div class="v-signup-form__body">
                            <form action="../SignUp" method="POST" id="signupForm" autocomplete = "off">
                                <input type="hidden" id="newUserRole" name="newUserRole" value>
                                <!-- Begin: Page 1 -->
                                <div id="signupPage1">
                                    <div class="v-role-card-container row">
                                        <div class="v-role-card-wrapper d-flex justify-content-center align-items-center col-12 col-sm-6 mb-3 mb-sm-0">  
                                            <a class="v-role-card-wrapper-link d-flex flex-column justify-content-center align-items-center text-decoration-none" id="clinicStaff" href="javascript:void(0)" tabindex = "1">
                                                <i class="fas fa-user-md fa-5x p-3"></i>
                                                <span class="v-role-card-wrapper-link--text font-weight-bold p-3 text-center">Clinic Staff</span>
                                            </a>
                                        </div>
                                        <div class="v-role-card-wrapper d-flex justify-content-center align-items-center col-12 col-sm-6 mt-3 mt-sm-0">
                                            <a class="v-role-card-wrapper-link d-flex flex-column justify-content-center align-items-center text-decoration-none" id="publicUser" href="javascript:void(0)" tabindex = "2">
                                                <i class="fas fa-users fa-5x p-3"></i>
                                                <span class="v-role-card-wrapper-link--text font-weight-bold p-3 text-center">Public User</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <!-- End: Page 1 -->
                                <!-- Begin: Page 2 -->
                                <div class="z-hide" id="signupPage2">
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="fullName">Full Name</label>
                                            <input class="form-control" name="fullName" type="text" id="fullName" placeholder="Full Name" tabindex = "3"> 
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="nricNo">NRIC No.</label>
                                            <input class="form-control" name="nricNo" type="text" id="nricNo" placeholder="xxxxxx-xx-xxxx" tabindex = "4">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
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
                                        <div class="col-12">
                                            <label class="required" for="dateOfBirth">Date of Birth</label>
                                            <input class="form-control" name="dateOfBirth" type="date" id="dateOfBirth" tabindex = "6"> 
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="contactNo">Contact No.</label>
                                            <input class="form-control" name="contactNo" type="tel" id="contactNo" placeholder="Contact No." tabindex = "7"> 
                                        </div>
                                    </div>
                                    <div class="v-signup-form__body-button-group d-flex justify-content-between pt-2">
                                        <button class="go-back-button btn btn-secondary" id="goBackPage1Btn" type="button" tabindex="9">Go Back</button>
                                        <button class="next-page-button btn btn-primary" id="continuePage3Btn" type="button" tabindex="8">Continue</button>
                                    </div>
                                </div>
                                <!-- End: Page 2 -->
                                <!-- Begin: Page 3 -->
                                <div class="z-hide" id="signupPage3">
                                    <div class="form-group row z-hide" id="clinicNameElement">
                                        <div class="col-12">
                                            <label class="required" for="clinicName">Clinic Name</label>
                                            <input class="form-control" name="clinicName" type="text" id="clinicName" placeholder="Clinic Name" tabindex = "10" value=""> 
                                        </div>
                                    </div>
                                    <div class="form-group row z-hide" id="vaccinationCapacityElement">
                                        <div class="col-12">
                                            <label class="required" for="vaccinationCapacity">Vaccination Capacity (Per day)</label>
                                            <input class="form-control" name="vaccinationCapacity" type="number" id="vaccinationCapacity" tabindex = "11" value=""> 
                                        </div>
                                    </div>
                                    <span class="font-weight-bold" id="addressSpan">Address</span>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="addressStreet">Street</label>
                                            <input class="form-control" name="addressStreet" type="text" id="addressStreet" placeholder="Street" tabindex = "12"> 
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="addressCity">City</label>
                                            <input class="form-control" name="addressCity" type="text" id="addressCity" placeholder="City" tabindex = "13"> 
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="addressState">State</label>
                                            <label class="select-icon">
                                                <select class="form-control" name="addressState" id="addressState" tabindex = "14">
                                                    <option value="">-Please Select-</option>
                                                    <c:set var="states" value="<%=EnumState.values()%>"/>
                                                    <c:forEach items="${states}" var="i">
                                                        <option value="${i.getName()}"><c:out value="${i.getName()}"/></option>
                                                    </c:forEach>
                                                </select>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12 col-sm-6 mb-3 mb-sm-0">
                                            <label class="required" for="addressPostcode">Postcode</label>
                                            <input class="form-control" name="addressPostcode" type="text" id="addressPostcode" placeholder="Postcode" tabindex = "15"> 
                                        </div>
                                        <div class="col-12 col-sm-6">
                                            <label class="required" for="addressCountry">Country</label>
                                            <input class="form-control" name="addressCountry" type="text" id="addressCountry" value="Malaysia" readonly> 
                                        </div>
                                    </div>
                                    <div class="v-signup-form__body-button-group d-flex justify-content-between pt-2">
                                        <button class="go-back-button btn btn-secondary" id="goBackPage2Btn" type="button" tabindex="17">Go Back</button>
                                        <button class="next-page-button btn btn-primary" id="continuePage4Btn" type="button" tabindex="16">Continue</button>
                                    </div>
                                </div>
                                <!-- End: Page 3 -->
                                <!-- Begin: Page 4 -->
                                <div class="z-hide" id="signupPage4">
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="emailAddress">Email Address</label>
                                            <div class="input-group">
                                                <input class="form-control" name="emailAddress" type="email" id="emailAddress" placeholder="example@mail.com" tabindex = "18" style="padding-right: 2rem;"> 
                                                <div class="d-flex position-absolute justify-content-center align-items-center" id="emailValidity_status" style="right: 8px; height: 38px;z-index: 100;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="password">Password</label>
                                            <input class="form-control" name="password" type="password" id="password" placeholder="Password" tabindex = "19">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-12">
                                            <label class="required" for="confirmPassword">Confirm Password</label>
                                            <input class="form-control" name="confirmPassword" type="password" id="confirmPassword" placeholder="Confirm Password" tabindex = "20">
                                        </div>
                                    </div>
                                    <div class="v-signup-form__body-button-group d-flex justify-content-between pt-2">
                                        <button class="go-back-button btn btn-secondary" id="goBackPage3Btn" type="button" tabindex="22">Go Back</button>
                                        <button class="submit-button btn btn-primary" id="submitBtn" type="submit" tabindex="21" disabled>Sign Up</button>
                                    </div>
                                </div>
                                <!-- End: Page 4 -->
                            </form>
                        </div>
                        <div class="v-signup-form__footer">
                            <div class="d-flex row">
                                <span class="v-signup-form__footer-description col-12">Already have an account?</span>
                                <div class="col-12">
                                    <a class="font-weight-bold" href="login.jsp">LOG IN</a>
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
                $(window).keydown(function (event) {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                        if ($("#signupPage2").is(":visible")) {
                            $('#continuePage3Btn').trigger('click');
                        } else if ($("#signupPage3").is(":visible")) {
                            $('#continuePage4Btn').trigger('click');
                        } else if ($("#signupPage4").is(":visible")) {
                            $("#submitBtn").trigger('click');
                        }
                    }
                });

                $.validator.addMethod("nric", function (value, element) {
                    return this.optional(element) || /^\d{6}-\d{2}-\d{4}$/i.test(value);
                }, "Invalid NRIC No.");
                $.validator.addMethod("contact", function (value, element) {
                    return this.optional(element) || /^\d{0,14}$/i.test(value);
                }, "Please key in a valid Contact No.");
                $.validator.addMethod("postcode", function (value, element) {
                    return this.optional(element) || /^\d{5}$/i.test(value);
                }, "Please key in a valid Postcode");
                $("#signupForm").validate({
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

            $('#clinicStaff').on('click', function (event) {
                $('#newUserRole').val("ClinicStaff");
                $('#signupPage1').hide();
                $('#signupPage2').show();
                $('#clinicNameElement, #vaccinationCapacityElement').show();
                $('#clinicName').rules('add', 'required');
                $('#vaccinationCapacity').rules('add', 'required');
                $('#addressSpan').html("Clinic Address");
                $('#fullName').focus();
            });

            $('#publicUser').on('click', function (event) {
                $('#newUserRole').val("PublicUser");
                $('#signupPage1').hide();
                $('#signupPage2').show();
                $('#clinicNameElement, #vaccinationCapacityElement').hide();
                $('#clinicName').rules('remove', 'required');
                $('#vaccinationCapacity').rules('remove', 'required');
                $('#addressSpan').html("Home Address");
                $('#fullName').focus();
            });

            $('#continuePage3Btn').on('click', function (event) {
                event.preventDefault();

                $("#signupForm").data("validator").settings.ignore = "";
                if (!$("#signupForm input:visible, select:visible").valid()) {
                    var validator = $("form").validate();
                    errorElement = validator.errorList[0].element;
                    $(errorElement).focus();
                    return;
                }
                $('#signupPage2').hide();
                $('#signupPage3').show();
                if ($('#newUserRole').val() === 'ClinicStaff') {
                    $('#clinicName').focus();
                } else if ($('#newUserRole').val() === 'PublicUser') {
                    $('#addressStreet').focus();
                }
                window.scrollTo(0, 0);
            });

            $('#continuePage4Btn').on('click', function (event) {
                event.preventDefault();

                $("#signupForm").data("validator").settings.ignore = "";
                if (!$("#signupForm input:visible, select:visible").valid()) {
                    var validator = $("form").validate();
                    errorElement = validator.errorList[0].element;
                    $(errorElement).focus();
                    return;
                }
                $('#signupPage3').hide();
                $('#signupPage4').show();
                $('#emailAddress').focus();
                window.scrollTo(0, 0);
            });

            $('#goBackPage1Btn').on('click', function (e) {
                $('#newUserRole').val(null);
                $('#clinicNameElement, #vaccinationCapacityElement').hide();
                $('#signupPage2').hide();
                $('#signupPage1').show();
                window.scrollTo(0, 0);
            });

            $('#goBackPage2Btn').on('click', function (e) {
                $('#signupPage3').hide();
                $('#signupPage2').show();
                window.scrollTo(0, 0);
            });

            $('#goBackPage3Btn').on('click', function (e) {
                $('#signupPage4').hide();
                $('#signupPage3').show();
                window.scrollTo(0, 0);
            });

            $("#signupForm").submit(function () {
                if ($('#signupForm').valid()) {
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
                }).then((result) => {
                    window.location.href = 'login.jsp';
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
