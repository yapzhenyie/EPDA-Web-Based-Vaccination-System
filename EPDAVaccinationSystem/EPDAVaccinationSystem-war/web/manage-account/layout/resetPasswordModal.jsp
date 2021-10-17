<%@page import="constants.ConstantMessage"%>
<%@page import="constants.ConstantSession"%>
<div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-labelledby="resetPasswordLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resetPasswordLabel">Password Reset Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../ResetPassword" method="POST" id="resetPasswordForm">
                    <input type="hidden" id="resetPasswordEmailAddress" name="resetPasswordEmailAddress" value>
                    <input type="hidden" id="resetPasswordRedirectUrl" name="resetPasswordRedirectUrl" value>
                    <p>Are you sure you want to reset the password for this account?</p>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="resetPasswordForm" id="resetPasswordBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="newPasswordModal" tabindex="-1" aria-labelledby="newPasswordLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newPasswordLabel">New Password</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-form-label" for="newPasswordEmailAddress">Email Address</label>
                    <input class="form-control user-select-all" name="newPassword" type="text" id="newPasswordEmailAddress" readonly>
                </div>
                <div class="form-group">
                    <label class="col-form-label" for="newPassword">New Password</label>
                    <input class="form-control user-select-all" name="newPassword" type="text" id="newPassword" readonly>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showResetPasswordModal(emailAddress, redirectUrl) {
        $('#resetPasswordModal').modal('show');
        $('#resetPasswordEmailAddress').val(emailAddress);
        $('#resetPasswordRedirectUrl').val(redirectUrl);
    }

    $("#resetPasswordForm").submit(function () {
        if ($('#resetPasswordForm').valid()) {
            $("#resetPasswordBtn").prop("disabled", true);
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
    <%
        if (session.getAttribute(ConstantSession.SuccessResetPassword) != null && session.getAttribute(ConstantSession.SuccessResetPassword).equals(ConstantMessage.True)) {
    %>

    function showNewPasswordModal() {
        $('#newPasswordEmailAddress').val("<%= session.getAttribute(ConstantSession.EmailAddress)%>");
        $('#newPassword').val("<%= session.getAttribute(ConstantSession.NewPassword)%>");
        $('#newPasswordModal').modal('show');
    }
    window.onload = showNewPasswordModal;
    <%
            session.setAttribute(ConstantSession.SuccessResetPassword, null);
            session.setAttribute(ConstantSession.EmailAddress, null);
            session.setAttribute(ConstantSession.NewPassword, null);
        }
    %>
</script>
