package com.example.listener;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ListenerTester extends HttpServlet{
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
            out.println("Test context attribute set by listener<br>");

            Dog dog = (Dog) this.getServletContext().getAttribute("dog");
            out.println("The Dog's breed is: " + dog.getBreed() + "<br>");
        }
}