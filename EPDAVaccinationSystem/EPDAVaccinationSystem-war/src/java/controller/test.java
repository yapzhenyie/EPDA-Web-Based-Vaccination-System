/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.AccountStatus;
import helper.DateTimeHelper;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Appointment;
import model.ClinicStaff;
import model.ClinicStaffFacade;
import model.PublicUser;
import model.PublicUserFacade;
import utils.EnumGender;
import utils.EnumState;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "test", urlPatterns = {"/test"})
public class test extends HttpServlet {

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

//        List<PublicUser> users = publicUserFacade.findAll();
//        System.out.println("Num of Users: " + users.size());
//        ClinicStaff clinicStaff = clinicStaffFacade.find(1); //Test id
//        
//        for(PublicUser user : users) {
//            Appointment app = new Appointment(new Date(System.currentTimeMillis()), 1, clinicStaff, user);
//            user.getAppointments().add(app);
//            publicUserFacade.edit(user);
//        }


        List<PublicUser> users = publicUserFacade.findAll()
                .stream().filter(p -> p.getAccount().getAccountStatus() == AccountStatus.Active).collect(Collectors.toList());

        for (PublicUser user : users) {
            user.getAppointments().forEach(c -> {
                try {
                    if (c.getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0) {
                        System.out.println(c.getAppointmentDate() + ":" + DateTimeHelper.getCurrentDate());
                    }
                } catch (ParseException ex) {
                    Logger.getLogger(test.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.out.println(user.getId() + ":" + c.getAppointmentDate().getTime());
            });
        }
        System.out.println(users.size());

        try {
            System.out.println(DateTimeHelper.getDate(1));
            System.out.println(DateTimeHelper.getDate(2));
        } catch (Exception ex) {
            Logger.getLogger(test.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static int getAge(LocalDate dateOfBirth) {
        Period period = Period.between(dateOfBirth, LocalDate.now());
        return period.getYears();
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
