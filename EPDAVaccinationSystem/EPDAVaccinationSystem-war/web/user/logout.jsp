<%-- 
    Document   : logout
    Created on : Oct 2, 2021, 5:33:02 PM
    Author     : Yap Zhen Yie
--%>

<%@page import="constants.ConstantSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.setAttribute(ConstantSession.EPDAUserAccount, null);
    session.setAttribute(ConstantSession.UserCredentialRole, null);
    session.setAttribute(ConstantSession.User, null);
    
    session.setAttribute(ConstantSession.Validate, null);
    session.setAttribute(ConstantSession.ValidateMessage, null);
    session.setAttribute(ConstantSession.Success, null);
    session.setAttribute(ConstantSession.SuccessMessage, null);
    response.sendRedirect("../");
%>
