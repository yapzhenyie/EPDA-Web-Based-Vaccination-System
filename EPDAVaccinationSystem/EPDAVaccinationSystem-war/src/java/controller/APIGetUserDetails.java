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
import java.text.SimpleDateFormat;
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
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "APIGetUserDetails", urlPatterns = {"/APIGetUserDetails"})
public class APIGetUserDetails extends HttpServlet {

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
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession();
        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {

            String email = request.getParameter("emailAddress");
            String role = request.getParameter("userRole");

            if ((email == null || email.isEmpty()) || (role == null || role.isEmpty())) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }

            UserAccount userAccount = userAccountFacade.find(email);

            if (userAccount == null) {
                response.sendError(HttpServletResponse.SC_NO_CONTENT);
                return;
            }

            try {
                switch (role) {
                    case "Ministry_Staff":
                        MinistryStaff ministryStaff = ministryStaffFacade.findByUserAccount(userAccount);
                        JSONObject jsonResult1 = new JSONObject();
                        jsonResult1.put("name", ministryStaff.getName());
                        jsonResult1.put("accountId", ministryStaff.getAccount().getId());
                        jsonResult1.put("nricNo", ministryStaff.getNricNo());
                        jsonResult1.put("gender", ministryStaff.getGender());
                        jsonResult1.put("dateOfBirth", ministryStaff.getDateOfBirth() != null ? new SimpleDateFormat("yyyy-MM-dd").format(ministryStaff.getDateOfBirth()) : "");
                        jsonResult1.put("contactNo", ministryStaff.getContactNo());
                        jsonResult1.put("addressStreet", ministryStaff.getAddressStreet());
                        jsonResult1.put("addressCity", ministryStaff.getAddressCity());
                        jsonResult1.put("addressState", ministryStaff.getAddressState());
                        jsonResult1.put("addressPostcode", ministryStaff.getAddressPostcode());
                        jsonResult1.put("addressCountry", ministryStaff.getAddressCountry());
                        jsonResult1.put("status", ministryStaff.getAccount().getAccountStatus());
                        try (PrintWriter out = response.getWriter()) {
                            out.println(jsonResult1.toString());
                        }
                        break;
                    case "Clinic_Staff":
                        ClinicStaff clinicStaff = clinicStaffFacade.findByUserAccount(userAccount);
                        JSONObject jsonResult2 = new JSONObject();
                        jsonResult2.put("clinicName", clinicStaff.getClinicName());
                        jsonResult2.put("vaccinationCapacity", clinicStaff.getVaccinationCapacity());
                        jsonResult2.put("name", clinicStaff.getName());
                        jsonResult2.put("accountId", clinicStaff.getAccount().getId());
                        jsonResult2.put("nricNo", clinicStaff.getNricNo());
                        jsonResult2.put("gender", clinicStaff.getGender());
                        jsonResult2.put("dateOfBirth", clinicStaff.getDateOfBirth() != null ? new SimpleDateFormat("yyyy-MM-dd").format(clinicStaff.getDateOfBirth()) : "");
                        jsonResult2.put("contactNo", clinicStaff.getContactNo());
                        jsonResult2.put("addressStreet", clinicStaff.getAddressStreet());
                        jsonResult2.put("addressCity", clinicStaff.getAddressCity());
                        jsonResult2.put("addressState", clinicStaff.getAddressState());
                        jsonResult2.put("addressPostcode", clinicStaff.getAddressPostcode());
                        jsonResult2.put("addressCountry", clinicStaff.getAddressCountry());
                        jsonResult2.put("status", clinicStaff.getAccount().getAccountStatus());
                        try (PrintWriter out = response.getWriter()) {
                            out.println(jsonResult2.toString());
                        }
                        break;
                    case "Public_User":
                        PublicUser publicUser = publicUserFacade.findByUserAccount(userAccount);
                        JSONObject jsonResult3 = new JSONObject();
                        jsonResult3.put("name", publicUser.getName());
                        jsonResult3.put("accountId", publicUser.getAccount().getId());
                        jsonResult3.put("nricNo", publicUser.getNricNo());
                        jsonResult3.put("gender", publicUser.getGender());
                        jsonResult3.put("dateOfBirth", publicUser.getDateOfBirth() != null ? new SimpleDateFormat("yyyy-MM-dd").format(publicUser.getDateOfBirth()) : "");
                        jsonResult3.put("contactNo", publicUser.getContactNo());
                        jsonResult3.put("addressStreet", publicUser.getAddressStreet());
                        jsonResult3.put("addressCity", publicUser.getAddressCity());
                        jsonResult3.put("addressState", publicUser.getAddressState());
                        jsonResult3.put("addressPostcode", publicUser.getAddressPostcode());
                        jsonResult3.put("addressCountry", publicUser.getAddressCountry());
                        jsonResult3.put("status", publicUser.getAccount().getAccountStatus());
                        try (PrintWriter out = response.getWriter()) {
                            out.println(jsonResult3.toString());
                        }
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        break;

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
