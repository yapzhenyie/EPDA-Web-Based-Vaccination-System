<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<div class="modal fade" id="deleteAppointmentModal" tabindex="-1" aria-labelledby="deleteAppointmentLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteAppointmentLabel">Delete Appointment Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../DeleteAppointment" method="POST" id="deleteAppointmentForm">
                    <input type="hidden" id="deleteAppointmentId" name="deleteAppointmentId" value>
                    <input type="hidden" id="deleteAppointmentRedirectUrl" name="deleteAppointmentRedirectUrl" value>
                    <p>Are you sure you want to delete this appointment? It will be permanently deleted from the database.</p>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-danger" form="deleteAppointmentForm" id="deleteAppointmentBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showDeleteAppointmentModal(id, redirectUrl) {
        $('#deleteAppointmentModal').modal('show');
        $('#deleteAppointmentId').val(id);
        $('#deleteAppointmentRedirectUrl').val(redirectUrl);
    }

    $("#deleteAppointmentForm").submit(function () {
        if ($('#deleteAppointmentForm').valid()) {
            $("#deleteAppointmentBtn").prop("disabled", true);
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
