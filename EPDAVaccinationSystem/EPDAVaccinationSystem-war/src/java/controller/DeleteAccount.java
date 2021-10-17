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
@WebServlet(name = "DeleteAccount", urlPatterns = {"/DeleteAccount"})
public class DeleteAccount extends HttpServlet {

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

        String emailAddress = request.getParameter("deleteAccountEmailAddress");
        String redirectUrl = request.getParameter("deleteAccountRedirectUrl");
        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            if (emailAddress == null || emailAddress.isEmpty()) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect(redirectUrl);
                return;
            }

            UserAccount account = userAccountFacade.find(emailAddress);
            if (account != null) {
                try {
                    switch (account.getRole()) {
                        case Ministry_Staff:
                            UserAccount userAccountSelf = (UserAccount) session.getAttribute(ConstantSession.EPDAUserAccount);
                            if (userAccountSelf != null && userAccountSelf.getId().equals(account.getId())) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.CannotDeleteSelfAccount);
                                response.sendRedirect(redirectUrl);
                                return;
                            }

                            MinistryStaff ministryStaff = ministryStaffFacade.findByUserAccount(account);
                            if (ministryStaff == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect(redirectUrl);
                                return;
                            }
                            ministryStaffFacade.remove(ministryStaff);
                            userAccountFacade.remove(account);

                            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulDeleteAccount);
                            response.sendRedirect(redirectUrl);
                            break;
                        case Clinic_Staff:
                            ClinicStaff clinicStaff = clinicStaffFacade.findByUserAccount(account);
                            if (clinicStaff == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect(redirectUrl);
                                return;
                            }
                            clinicStaffFacade.remove(clinicStaff);
                            userAccountFacade.remove(account);

                            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulDeleteAccount);
                            response.sendRedirect(redirectUrl);
                            break;
                        case Public_User:
                            PublicUser publicUser = publicUserFacade.findByUserAccount(account);
                            if (publicUser == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect(redirectUrl);
                                return;
                            }
                            publicUserFacade.remove(publicUser);
                            userAccountFacade.remove(account);

                            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulDeleteAccount);
                            response.sendRedirect(redirectUrl);
                            break;
                        default:
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            break;

                    }
                } catch (Exception e) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect(redirectUrl);
                    e.printStackTrace();
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
