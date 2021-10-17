<%@page import="classes.UserRole"%>
<%@page import="constants.ConstantSession"%>
<%@page import="utils.EnumState"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="viewUserDetailsModal" tabindex="-1" aria-labelledby="viewUserDetailsLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewUserDetailsLabel">View User Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group row z-hide" id="clinicStaffFields">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewClinicName">Clinic Name</label>
                        <input class="form-control" name="viewClinicName" type="text" id="viewClinicName" tabindex = "1" readonly> 
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewVaccinationCapacity">Vaccination Capacity (Per day)</label>
                        <input class="form-control" name="viewVaccinationCapacity" type="number" id="viewVaccinationCapacity" tabindex = "2" readonly>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewFullName">Full Name</label>
                        <input class="form-control" name="viewFullName" type="text" id="viewFullName" tabindex = "3" readonly> 
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewEmailAddress">Email Address</label>
                        <input class="form-control" name="viewEmailAddress" type="email" id="viewEmailAddress" tabindex = "4" readonly> 
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewNricNo">NRIC No.</label>
                        <input class="form-control" name="viewNricNo" type="text" id="viewNricNo" tabindex = "5" readonly>
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewGender">Gender</label>
                        <label class="select-icon">
                            <select class="form-control" name="viewGender" id="viewGender" tabindex = "6" readonly disabled>
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
                        <label class="col-form-label" for="viewDateOfBirth">Date of Birth</label>
                        <input class="form-control" name="viewDateOfBirth" type="date" id="viewDateOfBirth" tabindex = "7" readonly> 
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewContactNo">Contact No.</label>
                        <input class="form-control" name="viewContactNo" type="tel" id="viewContactNo" tabindex = "8" readonly> 
                    </div>
                </div>
                <div class="font-weight-bold mt-4">Address</div>
                <div class="form-group row">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewAddressStreet">Street</label>
                        <input class="form-control" name="viewAddressStreet" type="text" id="viewAddressStreet" tabindex = "9" readonly> 
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewAddressCity">City</label>
                        <input class="form-control" name="viewAddressCity" type="text" id="viewAddressCity" tabindex = "10" readonly> 
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewAddressState">State</label>
                        <label class="select-icon">
                            <select class="form-control" name="viewAddressState" id="viewAddressState" tabindex = "11" readonly disabled>
                                <option value="">-Please Select-</option>
                                <c:set var="states" value="<%=EnumState.values()%>"/>
                                <c:forEach items="${states}" var="i">
                                    <option value="${i.getName()}"><c:out value="${i.getName()}"/></option>
                                </c:forEach>
                            </select>
                        </label>
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="col-form-label" for="viewAddressPostcode">Postcode</label>
                        <input class="form-control" name="viewAddressPostcode" type="text" id="viewAddressPostcode" tabindex = "12" readonly> 
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <label class="col-form-label" for="viewAddressCountry">Country</label>
                        <input class="form-control" name="viewAddressCountry" type="text" id="viewAddressCountry" tabindex = "13" readonly> 
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" tabindex = "14">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    function loadViewUserDetailsModal(emailAddress, role) {
        $.ajax({
            type: "GET",
            url: "../APIGetUserDetails?emailAddress=" + emailAddress + "&userRole=" + role,
            dataType: 'json',
            cache: true,
            async: true,
            success: function (result) {
                if (result !== null) {
                    if (role === "<%= UserRole.Clinic_Staff.toString()%>") {
                        if ($('#clinicStaffFields').hasClass('z-hide')) {
                            $('#clinicStaffFields').removeClass("z-hide");
                        }
                        $('#viewClinicName').val(result.clinicName);
                        $('#viewVaccinationCapacity').val(result.vaccinationCapacity);
                    } else {
                        if (!$('#clinicStaffFields').hasClass('z-hide')) {
                            $('#clinicStaffFields').addClass("z-hide");
                        }
                    }
                    $('#viewFullName').val(result.name);
                    $('#viewEmailAddress').val(result.accountId);
                    $('#viewNricNo').val(result.nricNo);
                    $('#viewGender').val(result.gender);
                    $('#viewDateOfBirth').val(result.dateOfBirth);
                    $('#viewContactNo').val(result.contactNo);
                    $('#viewAddressStreet').val(result.addressStreet);
                    $('#viewAddressCity').val(result.addressCity);
                    $('#viewAddressState').val(result.addressState);
                    $('#viewAddressPostcode').val(result.addressPostcode);
                    $('#viewAddressCountry').val(result.addressCountry);
                    $('#viewUserDetailsModal').modal('show');
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    }
</script>
