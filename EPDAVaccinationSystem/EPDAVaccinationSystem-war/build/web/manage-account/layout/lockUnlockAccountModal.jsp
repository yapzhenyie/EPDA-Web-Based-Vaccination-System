<div class="modal fade" id="lockAccountModal" tabindex="-1" aria-labelledby="lockAccountLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lockAccountLabel">Lock Account Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../LockUserAccount" method="POST" id="lockUserAccountForm">
                    <input type="hidden" id="lockEmailAddress" name="lockEmailAddress" value>
                    <input type="hidden" id="lockRedirectUrl" name="lockRedirectUrl" value>
                    <p>Are you sure you want to lock this account?</p>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="lockUserAccountForm" id="lockAccountBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="unlockAccountModal" tabindex="-1" aria-labelledby="unlockAccountLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="unlockAccountLabel">Unlock Account Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../UnlockUserAccount" method="POST" id="unlockUserAccountForm">
                    <input type="hidden" id="unlockEmailAddress" name="unlockEmailAddress" value>
                    <input type="hidden" id="unlockRedirectUrl" name="unlockRedirectUrl" value>
                    <p>Are you sure you want to unlock this account?</p>
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary" form="unlockUserAccountForm" id="unlockAccountBtn">Confirm</button>
            </div>
        </div>
    </div>
</div>
<script>
    function showLockUnlockAccountModal(lock, emailAddress, redirectUrl) {
        if (lock === true) {
            $('#lockAccountModal').modal('show');
            $('#lockEmailAddress').val(emailAddress);
            $('#lockRedirectUrl').val(redirectUrl);
        } else {
            $('#unlockAccountModal').modal('show');
            $('#unlockEmailAddress').val(emailAddress);
            $('#unlockRedirectUrl').val(redirectUrl);
        }
    }

    $("#lockUserAccountForm").submit(function () {
        if ($('#lockUserAccountForm').valid()) {
            $("#lockAccountBtn").prop("disabled", true);
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

    $("#unlockUserAccountForm").submit(function () {
        if ($('#unlockUserAccountForm').valid()) {
            $("#unlockAccountBtn").prop("disabled", true);
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
