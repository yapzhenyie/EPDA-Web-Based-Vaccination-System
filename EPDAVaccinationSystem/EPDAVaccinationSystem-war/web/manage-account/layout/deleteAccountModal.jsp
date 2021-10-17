<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteAccountLabel">Delete Account Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../DeleteAccount" method="POST" id="deleteAccountForm">
                    <input type="hidden" id="deleteAccountEmailAddress" name="deleteAccountEmailAddress" value>
                    <input type="hidden" id="deleteAccountRedirectUrl" name="deleteAccountRedirectUrl" value>
                    <p>Are you sure you want to delete this account? It will be permanently deleted from the database.</p>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-danger" form="deleteAccountForm" id="deleteAccountBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showDeleteAccountModal(emailAddress, redirectUrl) {
        $('#deleteAccountModal').modal('show');
        $('#deleteAccountEmailAddress').val(emailAddress);
        $('#deleteAccountRedirectUrl').val(redirectUrl);
    }

    $("#deleteAccountForm").submit(function () {
        if ($('#deleteAccountForm').valid()) {
            $("#deleteAccountBtn").prop("disabled", true);
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
