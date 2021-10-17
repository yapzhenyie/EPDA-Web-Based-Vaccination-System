package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import constants.ConstantLink;
import java.util.Date;
import java.util.Calendar;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_out_value_nobody;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_c_out_value_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_c_out_value_nobody.release();
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\" theme-mode=\"light\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>EPDA Vaccination System</title>\n");
      out.write("        <link rel=\"icon\" href=\"assets/media/APU-Logo.png\" type=\"image/x-icon\">\n");
      out.write("        <!-- Mandatory CSS Library -->\n");
      out.write("        <link href=\"assets/vendors/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"assets/vendors/fontawesome-free/css/all.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"assets/css/style-bundle.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"assets/css/style-index.css\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Font Family -->\n");
      out.write("        <link href=\"https://fonts.googleapis.com/css?family=Source+Code+Pro:300,400,500,600,700&family=Poppins:300,400,500,600,700\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("        <!-- Optional CSS Library -->\n");
      out.write("\n");
      out.write("        <!-- Mandatory JavaScript Library -->\n");
      out.write("        <script src=\"assets/vendors/jquery/jquery.min.js\"></script>\n");
      out.write("        <script src=\"assets/vendors/bootstrap/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("\n");
      out.write("        <!-- Optional JavaScript Library -->\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <noscript>\n");
      out.write("        <div class=\"v-noscript\">\n");
      out.write("            This site requires JavaScript. You will not be able to continue if Javascript is disabled.\n");
      out.write("        </div>\n");
      out.write("        </noscript>\n");
      out.write("        <div class=\"v-container\">\n");
      out.write("            <nav class=\"container-navbar\">\n");
      out.write("                <div class=\"container d-block d-md-flex\">\n");
      out.write("                    <div class=\"brand\">\n");
      out.write("                        <div class=\"brand-logo\">\n");
      out.write("                            <a href=\"");
      out.print( ConstantLink.UrlIndex);
      out.write("\">\n");
      out.write("                                <img src=\"");
      out.print( ConstantLink.BrandLogo);
      out.write("\" alt=\"EPDA\" width=\"56px\" height=\"56px\"></img>\n");
      out.write("                                <h1>EPDA Vaccination System</h1>\n");
      out.write("                            </a>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"navigation-menu\">\n");
      out.write("                        <ul class=\"d-flex justify-content-center align-items-center list-unstyled mb-0\">\n");
      out.write("                            <li>\n");
      out.write("                                <a href=\"");
      out.print( ConstantLink.UrlIndex);
      out.write("\">Home</a>\n");
      out.write("                            </li>\n");
      out.write("                            <li>\n");
      out.write("                                <a href=\"");
      out.print( ConstantLink.UrlDashboard);
      out.write("\">Dashboard</a>\n");
      out.write("                            </li>\n");
      out.write("                        </ul>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"tools\">\n");
      out.write("                        <a class=\"tool-btn mr-1 btn btn-primary\" href=\"user/login.jsp\" role=\"button\" aria-pressed=\"true\">Login</a>\n");
      out.write("                        <a class=\"tool-btn ml-1 btn btn-outline-primary\" href=\"user/signup.jsp\" role=\"button\" aria-pressed=\"true\">Sign up</a>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </nav>\n");
      out.write("            <div class=\"container\" style=\"height: 500px;\">\n");
      out.write("                <div>Main section</div>\n");
      out.write("            </div>\n");
      out.write("            <footer style=\"background-color: gray;\">\n");
      out.write("                <div class=\"container\">\n");
      out.write("                    <div class=\"text-center text-white p-5\">\n");
      out.write("                        ");
 pageContext.setAttribute("currentYear", java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
      out.write("\n");
      out.write("                        Copyright &copy; ");
      if (_jspx_meth_c_out_0(_jspx_page_context))
        return;
      out.write(" Yap Zhen Yie (TP054300) - APU EPDA\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("            </footer>\n");
      out.write("        </div>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_out_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:out
    org.apache.taglibs.standard.tag.rt.core.OutTag _jspx_th_c_out_0 = (org.apache.taglibs.standard.tag.rt.core.OutTag) _jspx_tagPool_c_out_value_nobody.get(org.apache.taglibs.standard.tag.rt.core.OutTag.class);
    _jspx_th_c_out_0.setPageContext(_jspx_page_context);
    _jspx_th_c_out_0.setParent(null);
    _jspx_th_c_out_0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${currentYear}", java.lang.Object.class, (PageContext)_jspx_page_context, null));
    int _jspx_eval_c_out_0 = _jspx_th_c_out_0.doStartTag();
    if (_jspx_th_c_out_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_out_value_nobody.reuse(_jspx_th_c_out_0);
      return true;
    }
    _jspx_tagPool_c_out_value_nobody.reuse(_jspx_th_c_out_0);
    return false;
  }
}
