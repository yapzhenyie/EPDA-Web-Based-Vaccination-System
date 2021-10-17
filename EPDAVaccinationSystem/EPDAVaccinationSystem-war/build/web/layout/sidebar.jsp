<%@page import="classes.UserRole"%>
<%@page import="constants.ConstantLink"%>
<%@page import="constants.ConstantSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav id="sidebar">
    <ul class="list-unstyled components">
        <li>
            <a href="<%= ConstantLink.UrlDashboard%>">
                <div class="menu-item">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </div>
            </a>
        </li>
        <%
            if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                    && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Public_User.toString())) {
        %>
        <li>
            <a href="#">
                <div class="menu-item">
                    <i class="far fa-calendar-check"></i>
                    <span>Appointment</span>
                </div>
            </a>
        </li>
        <%
        } else {
        %>
        <li>
            <a href="#appointmentSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                <div class="menu-item">
                    <i class="far fa-calendar-check"></i>
                    <span>Appointment</span>
                </div>
            </a>
            <ul class="collapse list-unstyled" id="appointmentSubmenu">
                <%
                    if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
                %>
                <li>
                    <a href="<%= ConstantLink.UrlAppointmentScheduleAppointment%>">Schedule Appointment</a>
                </li>
                <li>
                    <a href="<%= ConstantLink.UrlAppointmentManageAppointment%>">Manage Appointment</a>
                </li>
                <%
                    }
                %>
                <%
                    if (session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Clinic_Staff.toString())) {
                %>
                <li>
                    <a href="<%= ConstantLink.UrlAppointmentViewAppointment%>">View Appointment</a>
                </li>
                <li>
                    <a href="<%= ConstantLink.UrlAppointmentCompleteVaccinationProcess%>">Complete Vaccination Process</a>
                </li>
                <%
                    }
                %>
            </ul>
        </li>
        <%
            }
        %>
        <%
            if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                    && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
        %>
        <li>
            <a href="#manageAccountSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">
                <div class="menu-item">
                    <i class="fas fa-users"></i>
                    <span>Manage Accounts</span>
                </div>
            </a>
            <ul class="collapse list-unstyled" id="manageAccountSubmenu">
                <li>
                    <a href="<%= ConstantLink.UrlManageAccountMinistryStaff%>">Ministry Staff</a>
                </li>
                <li>
                    <a href="<%= ConstantLink.UrlManageAccountClinicStaff%>">Clinic Staff</a>
                </li>
                <li>
                    <a href="<%= ConstantLink.UrlManageAccountPublicUser%>">Public User</a>
                </li>
            </ul>
        </li>
        <%
            }
        %>
        <%
            if (session.getAttribute(ConstantSession.UserCredentialRole) != null
                    && session.getAttribute(ConstantSession.UserCredentialRole).equals(UserRole.Ministry_Staff.toString())) {
        %>
        <li>
            <a href="#">
                <div class="menu-item">
                    <i class="far fa-file"></i>
                    <span>Reports</span>
                </div>
            </a>
        </li>
        <%
            }
        %>
        <div class="divider"></div>
        <li>
            <a href="<%= ConstantLink.UrlUserProfile%>">
                <div class="menu-item">
                    <i class="far fa-user"></i>
                    <span>Profile</span>
                </div>
            </a>
        </li>
        <li>
            <a href="<%= ConstantLink.UrlLogout%>">
                <div class="menu-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </div>
            </a>
        </li>
    </ul>
</nav>
