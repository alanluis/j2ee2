package com.example.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Enumeration;

public class TestInitParams extends HttpServlet{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(
        HttpServletRequest httpServletRequest,
        HttpServletResponse httpServletResponse)
        throws IOException, ServletException {
            httpServletResponse.setContentType("text/html");
            PrintWriter out = httpServletResponse.getWriter();
            out.println("test init parameters<br>");

            Enumeration<String> e = getServletConfig().getInitParameterNames();
            while(e.hasMoreElements()){
                out.println("<br>param name: " + e.nextElement() + "<br>");
            }

            out.println("Admin email is: " + getServletConfig().getInitParameter("adminEmail") + "<br>");
            out.println("Main email is: " + getServletConfig().getInitParameter("mainEmail") + "<br>");

            out.println("App email is: " + getServletContext().getInitParameter("appEmail") + "<br>");
        }
}