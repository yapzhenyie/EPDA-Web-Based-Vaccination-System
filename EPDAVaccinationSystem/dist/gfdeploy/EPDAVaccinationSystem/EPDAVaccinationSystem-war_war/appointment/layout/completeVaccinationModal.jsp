<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<div class="modal fade" id="completeVaccinationModal" tabindex="-1" aria-labelledby="completeVaccinationLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completeVaccinationLabel">Complete Vaccination Process</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../CompleteVaccination" method="POST" id="completeVaccinationForm">
                    <p class="font-weight-bold" style="color:red;">Before completing the vaccination process, make sure that the vaccinator information is correct.</p>
                    <input type="hidden" id="completeVaccinationId" name="completeVaccinationId" value>
                    <input type="hidden" id="completeVaccinationRedirectUrl" name="completeVaccinationRedirectUrl" value>             
                    <div class="font-weight-bold">Appointment Details</div>   
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewAppointmentDate">Appointment Date</label>
                            <input class="form-control" name="viewAppointmentDate" type="text" id="viewAppointmentDate" readonly> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewAppointmentStatus">Appointment Status</label>
                            <input class="form-control" name="viewAppointmentStatus" type="text" id="viewAppointmentStatus" readonly> 
                        </div>
                    </div>            
                    <div class="font-weight-bold mt-4">Vaccinator Details</div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewFullName">Vaccinator Name</label>
                            <input class="form-control" name="viewFullName" type="text" id="viewFullName" readonly> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewEmailAddress">Email Address</label>
                            <input class="form-control" name="viewEmailAddress" type="text" id="viewEmailAddress" readonly> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewNricNo">NRIC No.</label>
                            <input class="form-control" name="viewNricNo" type="text" id="viewNricNo" readonly>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewGender">Gender</label>
                            <input class="form-control" name="viewGender" type="text" id="viewGender" readonly> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewDateOfBirth">Date of Birth</label>
                            <input class="form-control" name="viewDateOfBirth" type="text" id="viewDateOfBirth" readonly> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewContactNo">Contact No.</label>
                            <input class="form-control" name="viewContactNo" type="text" id="viewContactNo" readonly> 
                        </div>
                    </div>
                    <div class="font-weight-bold mt-4">Address</div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewAddressStreet">Street</label>
                            <input class="form-control" name="viewAddressStreet" type="text" id="viewAddressStreet" readonly> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewAddressCity">City</label>
                            <input class="form-control" name="viewAddressCity" type="text" id="viewAddressCity" readonly> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewAddressState">State</label>
                            <input class="form-control" name="viewAddressState" type="text" id="viewAddressState" readonly> 
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="col-form-label" for="viewAddressPostcode">Postcode</label>
                            <input class="form-control" name="viewAddressPostcode" type="text" id="viewAddressPostcode" readonly> 
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-12 col-md-6 mb-3 mb-md-0">
                            <label class="col-form-label" for="viewAddressCountry">Country</label>
                            <input class="form-control" name="viewAddressCountry" type="text" id="viewAddressCountry" readonly> 
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-success" form="completeVaccinationForm" id="completeVaccinationBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showCompleteVaccinationModal(row, redirectUrl) {
        $('#completeVaccinationModal').modal('show');
        $('#completeVaccinationId').val(row.id);
        $('#completeVaccinationRedirectUrl').val(redirectUrl);
        $('#viewAppointmentDate').val(row.appointmentDate);
        $('#viewAppointmentStatus').val(row.appointmentStatus);
        $('#viewFullName').val(row.vaccinatorName);
        $('#viewEmailAddress').val(row.vaccinatorEmailAddress);
        $('#viewNricNo').val(row.vaccinatorNricNo);
        $('#viewGender').val(row.vaccinatorGender);
        $('#viewDateOfBirth').val(row.vaccinatorDateOfBirth);
        $('#viewContactNo').val(row.vaccinatorContactNo);
        $('#viewAddressStreet').val(row.vaccinatorAddressStreet);
        $('#viewAddressCity').val(row.vaccinatorAddressCity);
        $('#viewAddressState').val(row.vaccinatorAddressState);
        $('#viewAddressPostcode').val(row.vaccinatorAddressPostcode);
        $('#viewAddressCountry').val(row.vaccinatorAddressCountry);
    }

    $("#completeVaccinationForm").submit(function () {
        if ($('#completeVaccinationForm').valid()) {
            $("#completeVaccinationBtn").prop("disabled", true);
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
</script>
