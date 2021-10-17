/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.AccountStatus;
import classes.UserRole;
import constants.ConstantSession;
import java.io.IOException;
import java.io.PrintWriter;
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
import model.ClinicStaff;
import model.ClinicStaffFacade;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import utils.EnumGender;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "APIListClinicStaff", urlPatterns = {"/APIListClinicStaff"})
public class APIListClinicStaff extends HttpServlet {

    @EJB
    private ClinicStaffFacade clinicStaffFacade;

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
            List<ClinicStaff> results = clinicStaffFacade.findAll();
            try {
                JSONArray jArray = new JSONArray();

                String paramStatus = request.getParameter("status");
                if (paramStatus != null && !paramStatus.isEmpty()) {
                    if (paramStatus.equalsIgnoreCase(AccountStatus.Active.toString())) {
                        results = results.stream().filter(r -> r.getAccount().getAccountStatus() == AccountStatus.Active).collect(Collectors.toList());
                    } else if (paramStatus.equalsIgnoreCase(AccountStatus.Locked.toString())) {
                        results = results.stream().filter(r -> r.getAccount().getAccountStatus() == AccountStatus.Locked).collect(Collectors.toList());
                    } else if (paramStatus.equalsIgnoreCase(AccountStatus.Terminated.toString())) {
                        results = results.stream().filter(r -> r.getAccount().getAccountStatus() == AccountStatus.Terminated).collect(Collectors.toList());
                    }
                }
                for (ClinicStaff res : results) {
                    JSONObject jsonResult = new JSONObject();
                    jsonResult.put("name", res.getName());
                    jsonResult.put("accountId", res.getAccount().getId());
                    jsonResult.put("nricNo", res.getNricNo());
                    jsonResult.put("gender", EnumGender.values()[res.getGender()]);
                    jsonResult.put("dateOfBirth", res.getDateOfBirth() != null ? new SimpleDateFormat("dd/MM/yyyy").format(res.getDateOfBirth()) : "");
                    jsonResult.put("contactNo", res.getContactNo());
                    jsonResult.put("addressStreet", res.getAddressStreet());
                    jsonResult.put("addressCity", res.getAddressCity());
                    jsonResult.put("addressState", res.getAddressState());
                    jsonResult.put("addressPostcode", res.getAddressPostcode());
                    jsonResult.put("addressCountry", res.getAddressCountry());
                    jsonResult.put("status", res.getAccount().getAccountStatus());
                    jsonResult.put("clinicName", res.getClinicName());
                    jsonResult.put("vaccinationCapacity", res.getVaccinationCapacity());
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
