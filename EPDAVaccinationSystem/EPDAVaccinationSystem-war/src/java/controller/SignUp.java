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
import model.ClinicStaff;
import model.ClinicStaffFacade;
import model.PublicUser;
import model.PublicUserFacade;
import model.UserAccount;
import model.UserAccountFacade;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "SignUp", urlPatterns = {"/SignUp"})
public class SignUp extends HttpServlet {

    @EJB
    private UserAccountFacade userAccountFacade;

    @EJB
    private PublicUserFacade publicUserFacade;
    @EJB
    private ClinicStaffFacade clinicStaffFacade;

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

        String newUserRole = request.getParameter("newUserRole");
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
        String addressCountry = request.getParameter("addressCountry");
        String emailAddress = request.getParameter("emailAddress");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();

        try (PrintWriter out = response.getWriter()) {

            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);
            session.setAttribute(ConstantSession.Success, null);
            session.setAttribute(ConstantSession.SuccessMessage, null);

            UserAccount isAccountExist = userAccountFacade.find(emailAddress);
            if (isAccountExist != null) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.EmailAddressAlreadyExist);
                response.sendRedirect("user/signup.jsp");
                return;
            }

            if (!password.equals(confirmPassword)) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.PasswordConfirmPasswordNotMatch);
                response.sendRedirect("user/signup.jsp");
                return;
            }

            UserRole userRole;

            if (newUserRole.equalsIgnoreCase("ClinicStaff")) {
                userRole = UserRole.Clinic_Staff;
            } else if (newUserRole.equalsIgnoreCase("PublicUser")) {
                userRole = UserRole.Public_User;
            } else {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UserRoleNotSelected);
                response.sendRedirect("user/signup.jsp");
                return;
            }

            try {
                UserAccount userAccount = new UserAccount(emailAddress, userRole, confirmPassword);
                userAccountFacade.create(userAccount);

                if (userRole == UserRole.Clinic_Staff) {
                    ClinicStaff clinicStaff = new ClinicStaff(fullName, nricNo, gender, dateOfBirth, contactNo,
                            clinicName, vaccinationCapacity, addressStreet, addressCity, addressState, addressPostcode, addressCountry, userAccount);
                    clinicStaffFacade.create(clinicStaff);
                } else if (userRole == UserRole.Public_User) {
                    PublicUser publicUser = new PublicUser(fullName, nricNo, gender, dateOfBirth, contactNo,
                            addressStreet, addressCity, addressState, addressPostcode, addressCountry, userAccount);
                    publicUserFacade.create(publicUser);
                }

                session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulCreateAccount);
                response.sendRedirect("user/signup.jsp");
            } catch (Exception e) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect("user/signup.jsp");
                e.printStackTrace();
            }
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
