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
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ClinicStaff;
import model.ClinicStaffFacade;
import model.VaccinationFacade;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import utils.EnumState;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "APIReportClinicCapacity", urlPatterns = {"/APIReportClinicCapacity"})
public class APIReportClinicCapacity extends HttpServlet {

    @EJB
    private ClinicStaffFacade clinicStaffFacade;

    @EJB
    private VaccinationFacade vaccinationFacade;

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
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
            try {
                JSONObject jsonResult = new JSONObject();

                JSONArray jsonLabels = new JSONArray();
                jsonLabels.put("Malaysia");
                for (EnumState state : EnumState.values()) {
                    jsonLabels.put(state.getName());
                }
                jsonResult.put("labels", jsonLabels);
                
                
                JSONArray jsonCapacity = new JSONArray();
                List<ClinicStaff> clinicStaffs = clinicStaffFacade.findByActiveAccount();
                jsonCapacity.put(clinicStaffs.stream().mapToInt(p -> p.getVaccinationCapacity()).sum());
                for (EnumState state : EnumState.values()) {
                    jsonCapacity.put(clinicStaffs.stream().filter(p -> p.getAddressState() != null
                            && p.getAddressState().equals(state.getName())).mapToInt(p -> p.getVaccinationCapacity()).sum());
                }
                jsonResult.put("capacity", jsonCapacity);

                try (PrintWriter out = response.getWriter()) {
                    out.println(jsonResult.toString());
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
