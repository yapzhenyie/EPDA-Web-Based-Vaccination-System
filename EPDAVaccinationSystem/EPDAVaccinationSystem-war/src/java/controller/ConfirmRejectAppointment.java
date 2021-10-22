/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.AppointmentStatus;
import classes.UserRole;
import constants.ConstantMessage;
import constants.ConstantSession;
import helper.DateTimeHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Appointment;
import model.AppointmentFacade;
import model.ClinicStaff;
import model.ClinicStaffFacade;
import model.PublicUser;
import model.PublicUserFacade;
import model.Vaccination;
import model.VaccinationFacade;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "ConfirmRejectAppointment", urlPatterns = {"/ConfirmRejectAppointment"})
public class ConfirmRejectAppointment extends HttpServlet {

    @EJB
    private AppointmentFacade appointmentFacade;

    @EJB
    private VaccinationFacade vaccinationFacade;

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

        HttpSession session = request.getSession();

        AppointmentStatus appointmentStatus = null;
        Long appointmentId = null;
        try {
            appointmentStatus = AppointmentStatus.values()[Integer.parseInt(request.getParameter("appointmentStatus"))];
            appointmentId = Long.parseLong(request.getParameter("appointmentId"));
        } catch (NumberFormatException | IndexOutOfBoundsException e) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
            response.sendRedirect("appointment/appointment.jsp");
            return;
        }

        System.out.println(appointmentStatus);
        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Public_User.toString())) {
            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            Appointment appointment = appointmentFacade.find(appointmentId);
            if (appointment != null) {

                Vaccination similarVaccination = vaccinationFacade.filterByDoseAndVaccinator(appointment.getVaccinator(), 1);
                if (similarVaccination != null) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.FailedToUpdateAppointmentStatusDueToVaccinationIsCompleted);
                    response.sendRedirect("appointment/appointment.jsp");
                    return;
                }
                try {
                    switch (appointmentStatus) {
                        case Rejected:
                            appointment.setAppointmentStatus(appointmentStatus);
                            appointmentFacade.edit(appointment);

                            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.RejectedAppointment);
                            response.sendRedirect("appointment/appointment.jsp");
                            break;
                        case Confirmed:
                            if (appointment.getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0) {
                                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.AppointmentIsExpired);
                                response.sendRedirect("appointment/appointment.jsp");
                                return;
                            }

                            appointment.setAppointmentStatus(appointmentStatus);
                            appointmentFacade.edit(appointment);

                            session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                            session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.ConfirmedAppointment);
                            response.sendRedirect("appointment/appointment.jsp");
                            break;
                        default:
                    }
                } catch (Exception e) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("appointment/appointment.jsp");
                    e.printStackTrace();
                }
            } else {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect("appointment/appointment.jsp");
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
