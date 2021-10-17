/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.AccountStatus;
import constants.ConstantMessage;
import constants.ConstantSession;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        try (PrintWriter out = response.getWriter()) {

            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            if ((email == null || email.isEmpty())
                    || (password == null || password.isEmpty())) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UsernamePasswordCannotBeEmpty);
                response.sendRedirect("user/login.jsp");
                return;
            }

            UserAccount account = userAccountFacade.find(email);
            if (account != null
                    && account.getPassword().equals(password)
                    && account.getAccountStatus() == AccountStatus.Active) {
                if (null != account.getRole()) {
                    switch (account.getRole()) {
                        case Ministry_Staff:
                            MinistryStaff ministryStaff = ministryStaffFacade.findByUserAccount(account);
                            if (ministryStaff == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect("user/login.jsp");
                                return;
                            }
                            session.setAttribute(ConstantSession.EPDAUserAccount, account);
                            session.setAttribute(ConstantSession.UserCredentialRole, account.getRole().toString());
                            session.setAttribute(ConstantSession.User, ministryStaff);
                            response.sendRedirect("dashboard.jsp");
                            break;
                        case Clinic_Staff:
                            ClinicStaff clinicStaff = clinicStaffFacade.findByUserAccount(account);
                            if (clinicStaff == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect("user/login.jsp");
                                return;
                            }
                            session.setAttribute(ConstantSession.EPDAUserAccount, account);
                            session.setAttribute(ConstantSession.UserCredentialRole, account.getRole().toString());
                            session.setAttribute(ConstantSession.User, clinicStaff);
                            response.sendRedirect("dashboard.jsp");
                            break;
                        case Public_User:
                            PublicUser publicUser = publicUserFacade.findByUserAccount(account);
                            if (publicUser == null) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                                response.sendRedirect("user/login.jsp");
                                return;
                            }
                            session.setAttribute(ConstantSession.EPDAUserAccount, account);
                            session.setAttribute(ConstantSession.UserCredentialRole, account.getRole().toString());
                            session.setAttribute(ConstantSession.User, publicUser);
                            response.sendRedirect("dashboard.jsp");
                            break;
                        default:
                            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.WrongUsernamePassword);
                            response.sendRedirect("user/login.jsp");
                            break;
                    }
                }
            } else {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.WrongUsernamePassword);
                response.sendRedirect("user/login.jsp");
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
