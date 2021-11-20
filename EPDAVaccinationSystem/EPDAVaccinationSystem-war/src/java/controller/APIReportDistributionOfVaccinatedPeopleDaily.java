/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.UserRole;
import constants.ConstantSession;
import helper.DateTimeHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Vaccination;
import model.VaccinationFacade;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "APIReportDistributionOfVaccinatedPeopleDaily", urlPatterns = {"/APIReportDistributionOfVaccinatedPeopleDaily"})
public class APIReportDistributionOfVaccinatedPeopleDaily extends HttpServlet {

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
                List<Vaccination> distinctDates = vaccinationFacade.findByActiveAccount().stream().filter(distinctByKey(p -> p.getAppointmentDate()))
                        .sorted(Comparator.comparing(Vaccination::getAppointmentDate)).collect(Collectors.toList());
                for (Vaccination record : distinctDates) {
                    jsonLabels.put(DateTimeHelper.getCurrentDateFormat1(record.getAppointmentDate()));
                }
                jsonResult.put("labels", jsonLabels);

                JSONArray jsonVaccinated = new JSONArray();
                List<Vaccination> vaccinatedRecords = vaccinationFacade.findByActiveAccount();
                for (Vaccination distinctDate : distinctDates) {
                    jsonVaccinated.put(vaccinatedRecords.stream().filter(p -> p.getAppointmentDate() != null
                            && p.getAppointmentDate().equals(distinctDate.getAppointmentDate())).count());
                }
                jsonResult.put("vaccinated", jsonVaccinated);

                try (PrintWriter out = response.getWriter()) {
                    out.println(jsonResult.toString());
                }
            } catch (JSONException jse) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jse.printStackTrace();
            } catch (ParseException ex) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                ex.printStackTrace();
            }
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
    
//    public static Date addDays(Date date, int days) {
//        Calendar c = Calendar.getInstance();
//        c.setTime(date);
//        c.add(Calendar.DATE, days);
//        return new Date(c.getTimeInMillis());
//    }

    /**
     * Source: https://www.baeldung.com/java-streams-distinct-by
     *
     * @param <T>
     * @param keyExtractor
     * @return
     */
    public static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Map<Object, Boolean> seen = new ConcurrentHashMap<>();
        return t -> seen.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
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
