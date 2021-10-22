/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package constants;

/**
 *
 * @author Yap Zhen Yie
 */
public class ConstantMessage {
    
    public static String Error = "error";
    public static String True = "true";
    
    public static String UnexpectedErrorOccurred = "An error occurred while performing this operation! Please try again.";
    
    public static String EmailCannotBeEmpty = "Email address cannot be empty.";
    public static String PasswordCannotBeEmpty = "Password fields cannot be empty.";
    public static String UsernamePasswordCannotBeEmpty = "Email and password cannot be empty.";
    public static String WrongUsernamePassword = "Your email or password is incorrect.";
    public static String UserRoleNotSelected = "Please select a role for the new account.";
    
    public static String SuccessfulUpdateUserProfile = "Successful updated your user profile.";
    public static String SuccessfulUpdateOtherUserDetails = "The user details has been successfully updated.";
    public static String FailedToUpdateUserProfile = "Failed to update your user profile, please try again.";
    
    public static String EmailAddressAlreadyExist = "This email address already exists. Please try another email.";
    public static String EmailAddressIsApproved = "You may proceed with this email address to create account.";
    
    public static String PasswordConfirmPasswordNotMatch = "The password and confirmation password do not match.";
    public static String NewPasswordMatchWithOldPassword = "New password cannot be same as old password.";
    public static String NewPasswordAndConfirmNewPasswordNotMatch = "The new password and confirm new password do not match.";
    public static String WrongOldPassword = "Old password is incorrect. Please try again.";
    public static String PasswordResetFailed = "Password reset failed, please try again.";
    public static String CannotDeleteSelfAccount = "You cannot delete this account from the same account.";
    
    public static String NoVaccinatorsFound = "Failed to schedule appointment. No vaccinators with the selected options were found.";
    public static String NoAvailableClinicFound = "Failed to schedule appointment. All clinics are full or no available clinics can be found.";
    
    public static String AppointmentIsRejectedByVaccinator = "The appointment is rejected by the vaccinator. Vaccination completion is not allowed.";
    public static String AppointmentAlreadyCompleted = "The vaccination process is already completed and cannot be operated again.";
    public static String SuccessfulCompleteVaccinationProcess = "Successfully complete the vaccination process.";
    
    public static String ConfirmedAppointment = "Your appointment is marked as Confirmed.";
    public static String RejectedAppointment = "Your appointment is marked as Rejected.";
    public static String AppointmentIsExpired = "The appointment has expired. Please reject the appointment and wait for next appointment.";
    public static String FailedToUpdateAppointmentStatusDueToVaccinationIsCompleted = "The appointment status cannot be updated as the vaccination process is completed.";
    
    public static String SuccessfulCreateAccount = "Your account has been successfully created.";
    public static String SuccessfulCreateNewMinistryStaffAccount = "New ministry staff account has been successfully created.";
    public static String SuccessfulUpdatePassword = "Your password has been successfully updated.";
    public static String SuccessfulLockAccount = "This account has been successfully locked.";
    public static String SuccessfulUnlockAccount = "This account has been successfully unlocked.";
    public static String SuccessfulDeleteAccount = "This account has been successfully deleted.";
    public static String SuccessfulDeleteAppointment = "This appointment has been successfully deleted.";
}
