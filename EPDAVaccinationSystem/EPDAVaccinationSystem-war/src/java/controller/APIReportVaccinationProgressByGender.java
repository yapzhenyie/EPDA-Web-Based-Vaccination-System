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
import model.PublicUser;
import model.PublicUserFacade;
import model.Vaccination;
import model.VaccinationFacade;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import utils.EnumGender;

/**
 *
 * @author Yap Zhen Yie
 */
    @WebServlet(name = "APIReportVaccinationProgressByGender", urlPatterns = {"/APIReportVaccinationProgressByGender"})
public class APIReportVaccinationProgressByGender extends HttpServlet {

    @EJB
    private PublicUserFacade publicUserFacade;

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
                for (EnumGender gender : EnumGender.values()) {
                    jsonLabels.put(gender);
                }
                jsonResult.put("labels", jsonLabels);

                JSONArray jsonVaccinated = new JSONArray();
                List<Vaccination> vaccinatedRecords = vaccinationFacade.findByActiveAccount();
                for (EnumGender gender : EnumGender.values()) {
                    jsonVaccinated.put(vaccinatedRecords.stream().filter(p -> p.getVaccinator() != null
                            && p.getVaccinator().getGender() == gender.ordinal()).count());
                }
                jsonResult.put("vaccinated", jsonVaccinated);

                JSONArray jsonRegistered = new JSONArray();
                List<PublicUser> registeredUsers = publicUserFacade.findByActiveAccount();
                int i = 0;
                for (EnumGender gender : EnumGender.values()) {
                    jsonRegistered.put(registeredUsers.stream().filter(p -> p.getGender() == gender.ordinal()).count() - jsonVaccinated.getInt(i++));
                }
                jsonResult.put("registered", jsonRegistered);

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
