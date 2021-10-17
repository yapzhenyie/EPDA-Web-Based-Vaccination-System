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
import java.io.PrintWriter;
import java.sql.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.MinistryStaff;
import model.MinistryStaffFacade;
import model.UserAccount;
import model.UserAccountFacade;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "NewMinistryStaff", urlPatterns = {"/NewMinistryStaff"})
public class NewMinistryStaff extends HttpServlet {

    @EJB
    private UserAccountFacade userAccountFacade;

    @EJB
    private MinistryStaffFacade ministryStaffFacade;

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
        String addressStreet = request.getParameter("addressStreet");
        String addressCity = request.getParameter("addressCity");
        String addressState = request.getParameter("addressState");
        String addressPostcode = request.getParameter("addressPostcode");
        String addressCountry = request.getParameter("addressCountry");
        String emailAddress = request.getParameter("emailAddress");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
            // Begin: Validation
            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);
            session.setAttribute(ConstantSession.Success, null);
            session.setAttribute(ConstantSession.SuccessMessage, null);

            if(emailAddress == null || emailAddress.isEmpty()) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.EmailCannotBeEmpty);
                response.sendRedirect("manage-account/ministry-staff.jsp");
                return;
            }
            
            UserAccount isAccountExist = userAccountFacade.find(emailAddress);
            if (isAccountExist != null) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.EmailAddressAlreadyExist);
                response.sendRedirect("manage-account/ministry-staff.jsp");
                return;
            }

            if (!password.equals(confirmPassword)) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.PasswordConfirmPasswordNotMatch);
                response.sendRedirect("manage-account/ministry-staff.jsp");
                return;
            }

            try {
                UserAccount userAccount = new UserAccount(emailAddress, UserRole.Ministry_Staff, confirmPassword);
                userAccountFacade.create(userAccount);

                MinistryStaff publicUser = new MinistryStaff(fullName, nricNo, gender, dateOfBirth, contactNo,
                        addressStreet, addressCity, addressState, addressPostcode, addressCountry, userAccount);
                ministryStaffFacade.create(publicUser);

                session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulCreateNewMinistryStaffAccount);
                response.sendRedirect("manage-account/ministry-staff.jsp");
            } catch (Exception e) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect("manage-account/ministry-staff.jsp");
                e.printStackTrace();
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
