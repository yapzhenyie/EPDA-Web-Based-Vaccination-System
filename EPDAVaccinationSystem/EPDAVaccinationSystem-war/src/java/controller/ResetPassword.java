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
import model.UserAccount;
import model.UserAccountFacade;
import utils.PasswordGenerator;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "ResetPassword", urlPatterns = {"/ResetPassword"})
public class ResetPassword extends HttpServlet {

    @EJB
    private UserAccountFacade userAccountFacade;

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

        String emailAddress = request.getParameter("resetPasswordEmailAddress");
        String redirectUrl = request.getParameter("resetPasswordRedirectUrl");
        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {

            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            if (emailAddress == null || emailAddress.isEmpty()) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.EmailCannotBeEmpty);
                response.sendRedirect(redirectUrl);
                return;
            }

            UserAccount account = userAccountFacade.find(emailAddress);
            if (account != null) {
                String newPassword = PasswordGenerator.getRandomPassword();

                account.setPassword(newPassword);
                userAccountFacade.edit(account);

                if (account.getRole() == UserRole.Ministry_Staff) {
                    UserAccount userAccountSelf = (UserAccount) session.getAttribute(ConstantSession.EPDAUserAccount);
                    if (userAccountSelf != null && userAccountSelf.getId().equals(account.getId())) {
                        session.setAttribute(ConstantSession.EPDAUserAccount, account);
                    }
                }

                session.setAttribute(ConstantSession.SuccessResetPassword, ConstantMessage.True);
                session.setAttribute(ConstantSession.EmailAddress, emailAddress);
                session.setAttribute(ConstantSession.NewPassword, newPassword);
                response.sendRedirect(redirectUrl);
            } else {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.PasswordResetFailed);
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
