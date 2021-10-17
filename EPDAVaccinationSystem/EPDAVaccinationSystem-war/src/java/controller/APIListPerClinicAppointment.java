/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.UserRole;
import constants.ConstantSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;
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
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import utils.EnumGender;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "APIListPerClinicAppointment", urlPatterns = {"/APIListPerClinicAppointment"})
public class APIListPerClinicAppointment extends HttpServlet {

    @EJB
    private AppointmentFacade appointmentFacade;

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
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
            List<Appointment> results = appointmentFacade.findAll();
            try {
                JSONArray jArray = new JSONArray();

                ClinicStaff clinicStaff = (ClinicStaff) session.getAttribute(ConstantSession.User);
                results = results.stream().filter(p -> clinicStaff.getId() == p.getClinic().getId()).collect(Collectors.toList());

                Date appointmentDate = null;
                try {
                    appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
                } catch (IllegalArgumentException e) {

                }
                if (appointmentDate != null) {
                    final Date finalDate = appointmentDate;
                    results = results.stream().filter(r -> r.getAppointmentDate().equals(finalDate)).collect(Collectors.toList());
                }
                for (Appointment res : results) {
                    JSONObject jsonResult = new JSONObject();
                    jsonResult.put("id", res.getId());
                    jsonResult.put("vaccinatorName", res.getVaccinator().getName());
                    jsonResult.put("vaccinatorNricNo", res.getVaccinator().getNricNo());
                    jsonResult.put("vaccinatorGender", EnumGender.values()[res.getVaccinator().getGender()]);
                    jsonResult.put("vaccinatorDateOfBirth", res.getVaccinator().getDateOfBirth() != null ? new SimpleDateFormat("dd/MM/yyyy").format(res.getVaccinator().getDateOfBirth()) : "");
                    jsonResult.put("vaccinatorContactNo", res.getVaccinator().getContactNo());
                    jsonResult.put("vaccinatorAddressStreet", res.getVaccinator().getAddressStreet());
                    jsonResult.put("vaccinatorAddressCity", res.getVaccinator().getAddressCity());
                    jsonResult.put("vaccinatorAddressState", res.getVaccinator().getAddressState());
                    jsonResult.put("vaccinatorAddressPostcode", res.getVaccinator().getAddressPostcode());
                    jsonResult.put("vaccinatorAddressCountry", res.getVaccinator().getAddressCountry());
                    jsonResult.put("clinicName", res.getClinic().getClinicName());
                    jsonResult.put("doseNo", res.getDose());
                    jsonResult.put("appointmentStatus", res.getAppointmentStatus().toString());
                    jsonResult.put("appointmentDate", res.getAppointmentDate() != null ? new SimpleDateFormat("dd/MM/yyyy").format(res.getAppointmentDate()) : "");
                    jArray.put(jsonResult);
                }
                try (PrintWriter out = response.getWriter()) {
                    out.println(jArray.toString());
                }
            } catch (JSONException jse) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jse.printStackTrace();
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
