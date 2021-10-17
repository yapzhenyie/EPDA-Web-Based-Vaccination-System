/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import constants.ConstantMessage;
import constants.ConstantSession;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "UpdateProfile", urlPatterns = {"/UpdateProfile"})
public class UpdateProfile extends HttpServlet {

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

        String fullName = request.getParameter("fullName");
        String nricNo = request.getParameter("nricNo");
        int gender = 2;
        try {
            gender = Integer.parseInt(request.getParameter("gender"));
        } catch (NumberFormatException e) {

        }
        Date dateOfBirth = null;
        try {
            dateOfBirth = Date.valueOf(request.getParameter("dateOfBirth"));
        } catch (IllegalArgumentException e) {

        }
        String contactNo = request.getParameter("contactNo");
        String clinicName = request.getParameter("clinicName");
        int vaccinationCapacity = 0;
        try {
            vaccinationCapacity = Integer.parseInt(request.getParameter("vaccinationCapacity"));
        } catch (NumberFormatException e) {

        }
        String addressStreet = request.getParameter("addressStreet");
        String addressCity = request.getParameter("addressCity");
        String addressState = request.getParameter("addressState");
        String addressPostcode = request.getParameter("addressPostcode");
        //String addressCountry = request.getParameter("addressCountry");

        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.User) != null) {
            switch (session.getAttribute(ConstantSession.UserCredentialRole).toString()) {
                case "Ministry_Staff":
                    MinistryStaff ministryStaff = (MinistryStaff) session.getAttribute(ConstantSession.User);
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

                    session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                    session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateUserProfile);
                    response.sendRedirect("user/profile.jsp");
                    break;
                case "Clinic_Staff":
                    ClinicStaff clinicStaff = (ClinicStaff) session.getAttribute(ConstantSession.User);
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
                    session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateUserProfile);
                    response.sendRedirect("user/profile.jsp");
                    break;
                case "Public_User":
                    PublicUser publicUser = (PublicUser) session.getAttribute(ConstantSession.User);
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
                    session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdateUserProfile);
                    response.sendRedirect("user/profile.jsp");
                    break;
                default:
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("user/profile.jsp");
                    break;

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
