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
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
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
@WebServlet(name = "CompleteVaccination", urlPatterns = {"/CompleteVaccination"})
public class CompleteVaccination extends HttpServlet {

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

        Long appointmentId = null;
        String redirectUrl = request.getParameter("completeVaccinationRedirectUrl");
        try {
            appointmentId = Long.parseLong(request.getParameter("completeVaccinationId"));
        } catch (NumberFormatException e) {
            session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
            session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
            response.sendRedirect(redirectUrl);
            return;
        }

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
            session.setAttribute(ConstantSession.Validate, null);
            session.setAttribute(ConstantSession.ValidateMessage, null);

            if (appointmentId == null) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect(redirectUrl);
                return;
            }

            Appointment appointment = appointmentFacade.find(appointmentId);
            if (appointment != null) {
                if (appointment.getAppointmentStatus() == AppointmentStatus.Rejected) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.AppointmentIsRejectedByVaccinator);
                    response.sendRedirect(redirectUrl);
                    return;
                }

                Vaccination similarVaccination = vaccinationFacade.filterByDoseAndVaccinator(appointment.getVaccinator(), 1);
                if(similarVaccination != null) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.AppointmentAlreadyCompleted);
                    response.sendRedirect(redirectUrl);
                    return;
                }
                
                try {
                    ClinicStaff clinicStaff = appointment.getClinic();
                    PublicUser vaccinator = appointment.getVaccinator();

                    if (clinicStaff != null && vaccinator != null) {
                        appointment.setAppointmentStatus(AppointmentStatus.Confirmed);
                        appointmentFacade.edit(appointment);
                        
                        
                        Long timeNow = System.currentTimeMillis();
                        Vaccination vaccination = new Vaccination(appointment.getAppointmentDate(),
                                new Date(timeNow), new Time(timeNow), appointment.getDose(),
                                 clinicStaff, vaccinator);
                        vaccinationFacade.create(vaccination);

                        clinicStaff.getVaccinations().add(vaccination);
                        clinicStaffFacade.edit(clinicStaff);

                        vaccinator.getVaccinations().add(vaccination);
                        publicUserFacade.edit(vaccinator);

                        session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                        session.setAttribute(ConstantSession.SuccessMessage, ConstantMessage.SuccessfulCompleteVaccinationProcess);
                        response.sendRedirect(redirectUrl);
                    } else {
                        session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                        session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                        response.sendRedirect(redirectUrl);
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
