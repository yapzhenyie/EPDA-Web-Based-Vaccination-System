<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<footer class="pt-5">
    <div class="text-center p-3">
        <% pageContext.setAttribute("currentYear", java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));%>
        Copyright &copy; <c:out value="${currentYear}" /> Yap Zhen Yie (TP054300) - APU EPDA
    </div>
</footer>