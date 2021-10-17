/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.UserRole;
import constants.ConstantMessage;
import constants.ConstantSession;
import java.io.IOException;
import java.sql.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ClinicStaff;
import model.ClinicStaffFacade;
import model.MinistryStaff;
import model.MinistryStaffFacade;
import model.PublicUser;
import model.PublicUserFacade;
import model.UserAccount;
import model.UserAccountFacade;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "UpdateUserDetails", urlPatterns = {"/UpdateUserDetails"})
public class UpdateUserDetails extends HttpServlet {

    @EJB
    private UserAccountFacade userAccountFacade;

    @EJB
    private MinistryStaffFacade ministryStaffFacade;
    @EJB
    private ClinicStaffFacade clinicStaffFacade;
    @EJB
    private PublicUserFacade publicUserFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String redirectUrl = request.getParameter("editUserDetailsRedirectUrl");
        String emailAddress = request.getParameter("editEmailAddress");
        String role = request.getParameter("editRole");
        String fullName = request.getParameter("editFullName");
        String nricNo = request.getParameter("editNricNo");
        int gender = 2;
        try {
            gender = Integer.parseInt(request.getParameter("editGender"));
        } catch (NumberFormatException e) {

        }
        Date dateOfBirth = null;
        try {
            dateOfBirth = Date.valueOf(request.getParameter("editDateOfBirth"));
        } catch (IllegalArgumentException e) {

        }
        String contactNo = request.getParameter("editContactNo");
        String clinicName = request.getParameter("editClinicName");
        int vaccinationCapacity = 0;
        try {
            vaccinationCapacity = Integer.parseInt(request.getParameter("editVaccinationCapacity"));
        } catch (NumberFormatException e) {

        }
        String addressStreet = request.getParameter("editAddressStreet");
        String addressCity = request.getParameter("editAddressCity");
        String addressState = request.getParameter("editAddressState");
        String addressPostcode = request.getParameter("editAddressPostcode");
        //String addressCountry = request.getParameter("editAddressCountry");

        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            UserAccount userAccount = userAccountFacade.find(emailAddress);
            if (userAccount != null) {
                switch (role) {
                    case "Ministry_Staff":
                        MinistryStaff ministryStaff = (MinistryStaff) ministryStaffFacade.findByUserAccount(userAccount);
                        if (ministryStaff == null) {
                            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                            response.sendRedirect(redirectUrl);
                            return;
                        }
                        ministryStaff.setName(fullName);
                        ministryStaff.setNricNo(nricNo);
                        ministryStaff.setGender(gender);
                        ministryStaff.setDateOfBirth(dateOfBirth);
                        ministryStaff.setContactNo(contactNo);
                        ministryStaff.setAddressStreet(addressStreet);
                        ministryStaff.setAddressCity(addressCity);
                        ministryStaff.setAddressState(addressState);
                        ministryStaff.setAddressPostcode(addressPostcode);
                        //ministryStaff.setAddressCountry(addressCountry);
                        ministryStaffFacade.edit(ministryStaff);

                        MinistryStaff ministryStaffSelf = (MinistryStaff) session.getAttribute(ConstantSession.User);
                        if (ministryStaffSelf != null && ministryStaffSelf.getAccount().getId().equals(userAccount.getId())) {
                            session.setAttribute(ConstantSession.User, ministryStaff);
                        }

                        session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                        session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateOtherUserDetails);
                        response.sendRedirect(redirectUrl);
                        break;
                    case "Clinic_Staff":
                        ClinicStaff clinicStaff = (ClinicStaff) clinicStaffFacade.findByUserAccount(userAccount);
                        if (clinicStaff == null) {
                            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                            response.sendRedirect(redirectUrl);
                            return;
                        }
                        clinicStaff.setClinicName(clinicName);
                        clinicStaff.setVaccinationCapacity(vaccinationCapacity);
                        clinicStaff.setName(fullName);
                        clinicStaff.setNricNo(nricNo);
                        clinicStaff.setGender(gender);
                        clinicStaff.setDateOfBirth(dateOfBirth);
                        clinicStaff.setContactNo(contactNo);
                        clinicStaff.setAddressStreet(addressStreet);
                        clinicStaff.setAddressCity(addressCity);
                        clinicStaff.setAddressState(addressState);
                        clinicStaff.setAddressPostcode(addressPostcode);
                        //clinicStaff.setAddressCountry(addressCountry);
                        clinicStaffFacade.edit(clinicStaff);

                        session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                        session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateOtherUserDetails);
                        response.sendRedirect(redirectUrl);
                        break;
                    case "Public_User":
                        PublicUser publicUser = (PublicUser) publicUserFacade.findByUserAccount(userAccount);
                        if (publicUser == null) {
                            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                            response.sendRedirect(redirectUrl);
                            return;
                        }
                        publicUser.setName(fullName);
                        publicUser.setNricNo(nricNo);
                        publicUser.setGender(gender);
                        publicUser.setDateOfBirth(dateOfBirth);
                        publicUser.setContactNo(contactNo);
                        publicUser.setAddressStreet(addressStreet);
                        publicUser.setAddressCity(addressCity);
                        publicUser.setAddressState(addressState);
                        publicUser.setAddressPostcode(addressPostcode);
                        //publicUser.setAddressCountry(addressCountry);
                        publicUserFacade.edit(publicUser);

                        session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                        session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateOtherUserDetails);
                        response.sendRedirect(redirectUrl);
                        break;
                    default:
                        session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                        session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                        response.sendRedirect(redirectUrl);
                        break;
                }
            } else {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect(redirectUrl);
            }
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
