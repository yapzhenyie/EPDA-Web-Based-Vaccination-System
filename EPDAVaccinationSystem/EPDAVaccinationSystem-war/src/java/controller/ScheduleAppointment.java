/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import classes.AccountStatus;
import classes.AppointmentStatus;
import classes.UserRole;
import constants.ConstantMessage;
import constants.ConstantSession;
import helper.DateTimeHelper;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Optional;
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
import model.ClinicStaffFacade;
import model.PublicUser;
import model.PublicUserFacade;
import model.Vaccination;
import utils.EnumGender;
import utils.EnumState;

/**
 *
 * @author Yap Zhen Yie
 */
@WebServlet(name = "ScheduleAppointment", urlPatterns = {"/ScheduleAppointment"})
public class ScheduleAppointment extends HttpServlet {

    @EJB
    private ClinicStaffFacade clinicStaffFacade;

    @EJB
    private PublicUserFacade publicUserFacade;

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
        response.setContentType("text/html;charset=UTF-8");

        Integer doseNo = 1;
        try {
            doseNo = Integer.parseInt(request.getParameter("doseNo"));
            if (doseNo > 1) {
                doseNo = 1;
            }
        } catch (NumberFormatException e) {

        }
        int appointmentDate = 1;
        try {
            appointmentDate = Integer.parseInt(request.getParameter("appointmentDate"));
            if (appointmentDate > 4) {
                appointmentDate = 1;
            }
        } catch (NumberFormatException e) {

        }
        // Gender
        boolean genderMale = Boolean.valueOf(request.getParameter("genderMale"));
        boolean genderFemale = Boolean.valueOf(request.getParameter("genderFemale"));
        boolean genderUnspecified = Boolean.valueOf(request.getParameter("genderUnspecified"));

        // Age Group
        boolean ageGroup12To17 = Boolean.valueOf(request.getParameter("ageGroup12To17"));
        boolean ageGroup18To24 = Boolean.valueOf(request.getParameter("ageGroup18To24"));
        boolean ageGroup25To34 = Boolean.valueOf(request.getParameter("ageGroup25To34"));
        boolean ageGroup35To54 = Boolean.valueOf(request.getParameter("ageGroup35To54"));
        boolean ageGroup55AndAbove = Boolean.valueOf(request.getParameter("ageGroup55AndAbove"));

        // State
        boolean statePerlis = Boolean.valueOf(request.getParameter("statePerlis"));
        boolean statePenang = Boolean.valueOf(request.getParameter("statePenang"));
        boolean stateKedah = Boolean.valueOf(request.getParameter("stateKedah"));
        boolean statePerak = Boolean.valueOf(request.getParameter("statePerak"));
        boolean stateKelantan = Boolean.valueOf(request.getParameter("stateKelantan"));
        boolean stateTerengganu = Boolean.valueOf(request.getParameter("stateTerengganu"));
        boolean stateSelangor = Boolean.valueOf(request.getParameter("stateSelangor"));
        boolean statePahang = Boolean.valueOf(request.getParameter("statePahang"));
        boolean stateNegeri_Sembilan = Boolean.valueOf(request.getParameter("stateNegeri_Sembilan"));
        boolean stateMelaka = Boolean.valueOf(request.getParameter("stateMelaka"));
        boolean stateJohor = Boolean.valueOf(request.getParameter("stateJohor"));
        boolean stateSabah = Boolean.valueOf(request.getParameter("stateSabah"));
        boolean stateSarawak = Boolean.valueOf(request.getParameter("stateSarawak"));
        boolean stateKuala_Lumpur = Boolean.valueOf(request.getParameter("stateKuala_Lumpur"));
        boolean statePutrajaya = Boolean.valueOf(request.getParameter("statePutrajaya"));
        boolean stateLabuan = Boolean.valueOf(request.getParameter("stateLabuan"));

        HttpSession session = request.getSession();

        if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
            try {
                if (!genderMale && !genderFemale && !genderUnspecified) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("appointment/schedule-appointment.jsp");
                    return;
                }

                if (!ageGroup12To17 && !ageGroup18To24 && !ageGroup25To34 && !ageGroup35To54 && !ageGroup55AndAbove) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("appointment/schedule-appointment.jsp");
                    return;
                }

                if (!statePerlis && !statePenang && !stateKedah && !statePerak && !stateKelantan && !stateTerengganu
                        && !stateSelangor && !statePahang && !stateNegeri_Sembilan && !stateMelaka && !stateJohor
                        && !stateSabah && !stateSarawak && !stateKuala_Lumpur && !statePutrajaya && !stateLabuan) {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("appointment/schedule-appointment.jsp");
                    return;
                }

                // More checking
                List<PublicUser> users = publicUserFacade.findAll()
                        .stream().filter(p -> p.getAccount().getAccountStatus() == AccountStatus.Active).collect(Collectors.toList());

                // Gender
                if (!genderMale) {
                    users = users.stream().filter(p -> p.getGender() != EnumGender.Male.ordinal()).collect(Collectors.toList());
                }
                if (!genderFemale) {
                    users = users.stream().filter(p -> p.getGender() != EnumGender.Female.ordinal()).collect(Collectors.toList());
                }
                if (!genderUnspecified) {
                    users = users.stream().filter(p -> p.getGender() != EnumGender.Unspecified.ordinal()).collect(Collectors.toList());
                }

                // Age Group
                List<PublicUser> tempUserList = new ArrayList<>();
                if (ageGroup12To17) {
                    tempUserList.addAll(users.stream()
                            .filter(p -> p.getDateOfBirth() != null
                            && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) >= 12 && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) <= 17
                            ).collect(Collectors.toList()));
                }
                if (ageGroup18To24) {
                    tempUserList.addAll(users.stream()
                            .filter(p -> p.getDateOfBirth() != null
                            && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) >= 18 && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) <= 24
                            ).collect(Collectors.toList()));
                }
                if (ageGroup25To34) {
                    tempUserList.addAll(users.stream()
                            .filter(p -> p.getDateOfBirth() != null
                            && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) >= 25 && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) <= 34
                            ).collect(Collectors.toList()));
                }
                if (ageGroup35To54) {
                    tempUserList.addAll(users.stream()
                            .filter(p -> p.getDateOfBirth() != null
                            && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) >= 35 && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) <= 54
                            ).collect(Collectors.toList()));
                }
                if (ageGroup55AndAbove) {
                    tempUserList.addAll(users.stream()
                            .filter(p -> p.getDateOfBirth() != null
                            && DateTimeHelper.getAge(p.getDateOfBirth().toLocalDate()) >= 55).collect(Collectors.toList()));
                }
                users = tempUserList;

                //State
                if (!statePerlis) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Perlis.name())).collect(Collectors.toList());
                }
                if (!statePenang) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Penang.name())).collect(Collectors.toList());
                }
                if (!stateKedah) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Kedah.name())).collect(Collectors.toList());
                }
                if (!statePerak) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Perak.name())).collect(Collectors.toList());
                }
                if (!stateKelantan) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Kelantan.name())).collect(Collectors.toList());
                }
                if (!stateTerengganu) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Terengganu.name())).collect(Collectors.toList());
                }
                if (!stateSelangor) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Selangor.name())).collect(Collectors.toList());
                }
                if (!statePahang) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Pahang.name())).collect(Collectors.toList());
                }
                if (!stateNegeri_Sembilan) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Negeri_Sembilan.name())).collect(Collectors.toList());
                }
                if (!stateMelaka) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Melaka.name())).collect(Collectors.toList());
                }
                if (!stateJohor) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Johor.name())).collect(Collectors.toList());
                }
                if (!stateSabah) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Sabah.name())).collect(Collectors.toList());
                }
                if (!stateSarawak) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Sarawak.name())).collect(Collectors.toList());
                }
                if (!stateKuala_Lumpur) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Kuala_Lumpur.name())).collect(Collectors.toList());
                }
                if (!statePutrajaya) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Putrajaya.name())).collect(Collectors.toList());
                }
                if (!stateLabuan) {
                    users = users.stream().filter(p -> p.getAddressState() != null
                            && !p.getAddressState().equals(EnumState.Labuan.name())).collect(Collectors.toList());
                }
                System.out.println("C1");
                System.out.println("User Size:" + users.size());
                List<ClinicStaff> clinicStaffList = clinicStaffFacade.findAll()
                        .stream().filter(p -> p.getAccount().getAccountStatus() == AccountStatus.Active).collect(Collectors.toList());
                if (doseNo == 1) {
                    //filter user who not vaccinated yet or not receive appointment
                    List<PublicUser> usersNotReceiveAppointment = new ArrayList<>();

                    for (PublicUser user : users) {
                        List<Vaccination> vac = user.getVaccinations();
                        boolean isVaccinated = vac.stream().anyMatch(p -> p.getDose() == 1);

                        if (!isVaccinated) {
                            List<Appointment> appointments = user.getAppointments();

                            if (appointments.isEmpty()) {
                                if (!usersNotReceiveAppointment.contains(user)) {
                                    usersNotReceiveAppointment.add(user);
                                }
                            } else {
                                Optional<Appointment> latestAppointment = appointments.stream().filter(p -> p.getDose() == 1).sorted(Comparator.comparing(Appointment::getAppointmentDate).reversed()).findFirst();

                                if (latestAppointment.isPresent()) {
                                    if (latestAppointment.get().getAppointmentDate().compareTo(DateTimeHelper.getCurrentDate()) < 0
                                            && latestAppointment.get().getAppointmentStatus() == AppointmentStatus.Rejected) {
                                        if (!usersNotReceiveAppointment.contains(user)) {
                                            usersNotReceiveAppointment.add(user);
                                        }
                                    }
                                }
                            }
                        }
                    }

                    System.out.println("C2");
                    System.out.println("User Size:" + usersNotReceiveAppointment.size());

                    if (usersNotReceiveAppointment.isEmpty()) {
                        session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                        session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.NoVaccinatorsFound);
                        response.sendRedirect("appointment/schedule-appointment.jsp");
                        return;
                    }

                    java.util.Date appDate = DateTimeHelper.getDate(1);

                    if (appointmentDate == 2) {
                        appDate = DateTimeHelper.getDate(3);
                    } else if (appointmentDate == 3) {
                        appDate = DateTimeHelper.getDate(7);
                    } else if (appointmentDate == 4) {
                        appDate = DateTimeHelper.getDate(14);
                    }

                    HashMap<ClinicStaff, Integer> availableClinic = new HashMap<>();

                    for (ClinicStaff s : clinicStaffList) {
                        int remainCapacity = s.getVaccinationCapacity();
                        List<Appointment> appointments = s.getAppointments();
                        System.out.println("Checking appointments: " + appointments.size());
                        for (Appointment app : appointments) {
                            if (app.getAppointmentDate().getTime() == appDate.getTime()) {
                                System.out.println("Remove one capacity");
                                remainCapacity--;
                            }
                        }
                        if (remainCapacity > 0) {
                            availableClinic.put(s, remainCapacity);
                        }
                    }

                    if (availableClinic.isEmpty()) {
                        session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                        session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.NoAvailableClinicFound);
                        response.sendRedirect("appointment/schedule-appointment.jsp");
                        return;
                    }

                    System.out.println("Clinic Size: " + availableClinic.size());

                    int total = 0;

                    for (Map.Entry<ClinicStaff, Integer> m : availableClinic.entrySet()) {
                        ClinicStaff staff = m.getKey();
                        int remainCapacity = m.getValue();
                        ListIterator<PublicUser> iter = usersNotReceiveAppointment.listIterator();
                        while (iter.hasNext()) {
                            if (remainCapacity <= 0) {
                                break;
                            }
                            PublicUser u = iter.next();
                            Appointment app = new Appointment(new Date(appDate.getTime()), doseNo, staff, u);
                            appointmentFacade.create(app);

                            u.getAppointments().add(app);
                            publicUserFacade.edit(u);

                            staff.getAppointments().add(app);
                            clinicStaffFacade.edit(staff);

                            System.out.println("Added one appointment");
                            remainCapacity--;
                            total++;
                            iter.remove();
                        }
                    };

                    session.setAttribute(ConstantSession.Success, ConstantMessage.True);
                    session.setAttribute(ConstantSession.SuccessMessage, total + " new vaccination appointments have been created. You can check the details in Manage Appointment Page.");
                    session.setAttribute(ConstantSession.FilterByAppointmentDate, ConstantMessage.True);
                    session.setAttribute(ConstantSession.AppointmentDate, DateTimeHelper.getCurrentDateISOFormat(appDate));
                    response.sendRedirect("appointment/manage-appointment.jsp");
                } else {
                    session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                    session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                    response.sendRedirect("appointment/schedule-appointment.jsp");
                }
            } catch (Exception e) {
                session.setAttribute(ConstantSession.Validate, ConstantMessage.Error);
                session.setAttribute(ConstantSession.ValidateMessage, ConstantMessage.UnexpectedErrorOccurred);
                response.sendRedirect("appointment/schedule-appointment.jsp");
                e.printStackTrace();
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
