<%@page import="constants.ConstantLink"%>
<div class="container-navbar">
    <div class="brand">
        <div class="navbar-toggle-button-container">
            <button class="navbar-toggle-button" id="sidebarCollapse">
                <i class="fas fa-bars"></i>
            </button>
        </div>
        <div class="brand-logo">
            <a href="<%= ConstantLink.UrlIndex%>">
                <img src="<%= ConstantLink.BrandLogo%>" alt="EPDA" width="56px" height="56px"></img>
                <h1>EPDA Vaccination System</h1>
            </a>
        </div>
    </div>
    <div class="tools">
    </div>
</div>