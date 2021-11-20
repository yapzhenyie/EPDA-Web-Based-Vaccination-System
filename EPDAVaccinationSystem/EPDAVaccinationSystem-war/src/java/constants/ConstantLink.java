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
public class ConstantLink {
    
    private static String basePath = "http://localhost:8080/EPDAVaccinationSystem-war/";
    
    public static final String BrandLogo = basePath + "assets/media/APU-Logo.png";
    
    
    public static final String UrlIndex = basePath;
    public static final String UrlDashboard = basePath + "dashboard.jsp";
    public static final String UrlAppointmentAppointment = basePath + "appointment/appointment.jsp";
    public static final String UrlAppointmentScheduleAppointment = basePath + "appointment/schedule-appointment.jsp";
    public static final String UrlAppointmentManageAppointment = basePath + "appointment/manage-appointment.jsp";
    public static final String UrlAppointmentViewAppointment = basePath + "appointment/view-appointment.jsp";
    public static final String UrlAppointmentCompleteVaccinationProcess = basePath + "appointment/complete-vaccination-process.jsp";
    public static final String UrlManageAccountMinistryStaff = basePath + "manage-account/ministry-staff.jsp";
    public static final String UrlManageAccountClinicStaff = basePath + "manage-account/clinic-staff.jsp";
    public static final String UrlManageAccountPublicUser = basePath + "manage-account/public-user.jsp";
    public static final String UrlVaccineVaccinationList = basePath + "vaccine/vaccination-list.jsp";
    public static final String UrlReportReports = basePath + "report/reports.jsp";
    public static final String UrlUserProfile = basePath + "user/profile.jsp";
    
    
    public static final String UrlLogin = basePath + "user/login.jsp";
    public static final String UrlLogout = basePath + "user/logout.jsp";
    
    public static final String APIToggleSidebar = basePath + "APIToggleSidebar";
    
}
