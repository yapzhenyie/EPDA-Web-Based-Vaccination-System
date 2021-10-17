/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

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
@WebServlet(name = "ForgotPassword", urlPatterns = {"/ForgotPassword"})
public class ForgotPassword extends HttpServlet {

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

        String emailAddress = request.getParameter("emailAddress");
        HttpSession session = request.getSession();

        session.setAttribute(ConstantSession.Validate, null);
        session.setAttribute(ConstantSession.ValidateMessage, null);

        if (emailAddress == null || emailAddress.isEmpty()) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.EmailCannotBeEmpty);
            response.sendRedirect("user/forgot-password.jsp");
            return;
        }

        UserAccount account = userAccountFacade.find(emailAddress);
        if (account != null) {
            String newPassword = PasswordGenerator.getRandomPassword();

            account.setPassword(newPassword);
            userAccountFacade.edit(account);

            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
            session.setAttribute(ConstantSession.EmailAddress, emailAddress);
            session.setAttribute(ConstantSession.NewPassword, newPassword);
            response.sendRedirect("user/forgot-password.jsp");
        } else {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.PasswordResetFailed);
            response.sendRedirect("user/forgot-password.jsp");
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
