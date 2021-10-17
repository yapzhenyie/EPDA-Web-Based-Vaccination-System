<%@page import="classes.UserRole"%>
<%@page import="constants.ConstantSession"%>
<%@page import="utils.EnumState"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="editUserDetailsModal" tabindex="-1" aria-labelledby="editUserDetailsLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserDetailsLabel">Edit User Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../UpdateUserDetails" method="POST" id="editUserDetailsForm" autocomplete = "off">
                    <input type="hidden" id="editUserDetailsRedirectUrl" name="editUserDetailsRedirectUrl" value>
                    <input type="hidden" id="editRole" name="editRole" value>
                    <div class="form-group row z-hide" id="editClinicStaffFields">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label required" for="editClinicName">Clinic Name</label>
                            <input class="form-control" name="editClinicName" type="text" id="editClinicName" tabindex = "1"> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="editVaccinationCapacity">Vaccination Capacity (Per day)</label>
                            <input class="form-control" name="editVaccinationCapacity" type="number" id="editVaccinationCapacity" tabindex = "2">
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label required" for="editFullName">Full Name</label>
                            <input class="form-control" name="editFullName" type="text" id="editFullName" tabindex = "3"> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="editEmailAddress">Email Address</label>
                            <input class="form-control" name="editEmailAddress" type="email" id="editEmailAddress" tabindex = "4" readonly> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label required" for="editNricNo">NRIC No.</label>
                            <input class="form-control" name="editNricNo" type="text" id="editNricNo" tabindex = "5">
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="editGender">Gender</label>
                            <label class="select-icon">
                                <select class="form-control" name="editGender" id="editGender" tabindex = "6">
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
                            <label class="col-form-label required" for="editDateOfBirth">Date of Birth</label>
                            <input class="form-control" name="editDateOfBirth" type="date" id="editDateOfBirth" tabindex = "7"> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="editContactNo">Contact No.</label>
                            <input class="form-control" name="editContactNo" type="tel" id="editContactNo" tabindex = "8"> 
                        </div>
                    </div>
                    <div class="font-weight-bold mt-4">Address</div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label required" for="editAddressStreet">Street</label>
                            <input class="form-control" name="editAddressStreet" type="text" id="editAddressStreet" tabindex = "9"> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="editAddressCity">City</label>
                            <input class="form-control" name="editAddressCity" type="text" id="editAddressCity" tabindex = "10"> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label required" for="editAddressState">State</label>
                            <label class="select-icon">
                                <select class="form-control" name="editAddressState" id="editAddressState" tabindex = "11">
                                    <option value="">-Please Select-</option>
                                    <c:set var="states" value="<%=EnumState.values()%>"/>
                                    <c:forEach items="${states}" var="i">
                                        <option value="${i.getName()}"><c:out value="${i.getName()}"/></option>
                                    </c:forEach>
                                </select>
                            </label>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label required" for="editAddressPostcode">Postcode</label>
                            <input class="form-control" name="editAddressPostcode" type="text" id="editAddressPostcode" tabindex = "12"> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="editAddressCountry">Country</label>
                            <input class="form-control" name="editAddressCountry" type="text" id="editAddressCountry" tabindex = "13" readonly> 
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" tabindex = "15">Close</button>
                <button type="submit" class="btn btn-primary" form="editUserDetailsForm" id="editUserDetailsSubmitBtn" tabindex = "14">Save</button>
            </div>
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
        $("#editUserDetailsForm").validate({
            rules: {
                editFullName: {
                    required: true
                },
                editNricNo: {
                    required: true,
                    nric: true
                },
                editGender: {
                    required: true
                },
                editDateOfBirth: {
                    required: true,
                    date: true
                },
                editContactNo: {
                    required: true,
                    contact: true
                },
                editAddressStreet: "required",
                editAddressCity: "required",
                editAddressState: "required",
                editAddressPostcode: {
                    required: true,
                    postcode: true
                },
                editClinicName: {
                    required: true
                },
                editVaccinationCapacity: {
                    required: true,
                    min: 1
                }
            },
            messages: {
                editFullName: {
                    required: "The Full Name field is required."
                },
                editNricNo: {
                    required: "The NRIC No. field is required."
                },
                editGender: {
                    required: "The Gender field is required."
                },
                editDateOfBirth: {
                    required: "The Date of Birth field is required.",
                    date: "The field Date of Birth must be a date."
                },
                editContactNo: {
                    required: "The Contact No. field is required."
                },
                editAddressStreet: "The Street field is required.",
                editAddressCity: "The City field is required.",
                editAddressState: "The State field is required.",
                editAddressPostcode: {
                    required: "The Postcode field is required."
                },
                editClinicName: {
                    required: "The Clinic Name field is required."
                },
                editVaccinationCapacity: {
                    required: "The Vaccincation Capacity field is required."
                }
            }
        });
    });

    $('#editNricNo').on('input', function (e) {
        $(this).val(function () {
            return ReplaceICFormat($(this).val());
        });
    });

    $('#editContactNo').on('input', function (e) {
        $(this).val(function () {
            return $(this).val().replace(/[\D\s\._\-]+/g, '');
        });
    });

    function loadEditUserDetailsModal(emailAddress, role, redirectUrl) {
        $.ajax({
            type: "GET",
            url: "../APIGetUserDetails?emailAddress=" + emailAddress + "&userRole=" + role,
            dataType: 'json',
            cache: true,
            async: true,
            success: function (result) {
                if (result !== null) {
                    $('#editUserDetailsRedirectUrl').val(redirectUrl);
                    $('#editRole').val(role);
                    if (role === "<%= UserRole.Clinic_Staff.toString()%>") {
                        if ($('#editClinicStaffFields').hasClass('z-hide')) {
                            $('#editClinicStaffFields').removeClass("z-hide");
                        }
                        $('#editClinicName').val(result.clinicName);
                        $('#editVaccinationCapacity').val(result.vaccinationCapacity);
                    } else {
                        if (!$('#editClinicStaffFields').hasClass('z-hide')) {
                            $('#editClinicStaffFields').addClass("z-hide");
                        }
                    }
                    $('#editFullName').val(result.name);
                    $('#editEmailAddress').val(result.accountId);
                    $('#editNricNo').val(result.nricNo);
                    $('#editGender').val(result.gender);
                    $('#editDateOfBirth').val(result.dateOfBirth);
                    $('#editContactNo').val(result.contactNo);
                    $('#editAddressStreet').val(result.addressStreet);
                    $('#editAddressCity').val(result.addressCity);
                    $('#editAddressState').val(result.addressState);
                    $('#editAddressPostcode').val(result.addressPostcode);
                    $('#editAddressCountry').val(result.addressCountry);
                    $('#editUserDetailsModal').modal('show');
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    $("#editUserDetailsForm").submit(function () {
        if ($('#editUserDetailsForm').valid()) {
            $("#editUserDetailsSubmitBtn").prop("disabled", true);
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
