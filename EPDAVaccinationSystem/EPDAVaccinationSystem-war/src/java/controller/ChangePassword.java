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

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

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

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        HttpSession session = request.getSession();

        session.setAttribute(ConstantSession.Validate, null);
        session.setAttribute(ConstantSession.ValidateMessage, null);

        if ((oldPassword == null || oldPassword.isEmpty())
                || (newPassword == null || newPassword.isEmpty())
                || (confirmNewPassword == null || confirmNewPassword.isEmpty())) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.PasswordCannotBeEmpty);
            response.sendRedirect("user/profile.jsp");
            return;
        }

        if (!newPassword.equals(confirmNewPassword)) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.NewPasswordAndConfirmNewPasswordNotMatch);
            response.sendRedirect("user/profile.jsp");
            return;
        }

        if (oldPassword.equals(confirmNewPassword)) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.NewPasswordMatchWithOldPassword);
            response.sendRedirect("user/profile.jsp");
            return;
        }

        if (session.getAttribute(ConstantSession.EPDAUserAccount) != null) {
            UserAccount userAccount = (UserAccount) session.getAttribute(ConstantSession.EPDAUserAccount);

            if (!userAccount.getPassword().equals(oldPassword)) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.WrongOldPassword);
                response.sendRedirect("user/profile.jsp");
                return;
            }

            userAccount.setPassword(confirmNewPassword);
            userAccountFacade.edit(userAccount);

            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulUpdatePassword);
            response.sendRedirect("user/profile.jsp");
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
