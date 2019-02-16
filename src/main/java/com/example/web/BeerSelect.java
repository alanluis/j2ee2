package com.example.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

import com.example.model.*;
import com.example.Employee;
import com.example.listener.Dog;

public class BeerSelect extends HttpServlet{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(
        HttpServletRequest httpServletRequest,
        HttpServletResponse httpServletResponse)
        throws IOException, ServletException {

        // BEER
        String color = httpServletRequest.getParameter("color");
        BeerExpert beerExpert = new BeerExpert();
        List<String> result = beerExpert.getBrands(color);
        httpServletRequest.setAttribute("styles", result);
        httpServletRequest.setAttribute("attributeA", "Teste");

        //********** ESCOPOS ************/

        // ATTRIBUTO NO ESCOPO SESSION
        HttpSession session = httpServletRequest.getSession();
        Dog dogSession = new Dog("Dog Session");
        session.setAttribute("dogSession", dogSession);

        // ATRIBUTO NO ESCOPO CONTEXT (não recomendado, melhor via listener)
        if (getServletContext().getAttribute("dogContext") == null) {
            getServletContext().setAttribute("dogContext", new Dog("Dog context"));
        }

        // ATRIBUTO NO ESCOPO REQUEST (THREAD-SAFE)
        Dog dogRequest = new Dog("Dog request <strong>strong</strong>");
        httpServletRequest.setAttribute("dogRequest", dogRequest);

        String[] movieList = {"Amelie", "Return of the King", "Mean Girls"};
        httpServletRequest.setAttribute("movieList", movieList);

        //********** COOKIES ************/

        // ATRIBUTO NO COOKIE
        Cookie cookie = new Cookie("MyCookie", "MyCookieValue");
        cookie.setMaxAge(60 * 60 * 24);
        httpServletResponse.addCookie(cookie);

        //********** JAVA BEANS ************/

        // NOVO OBJETO BEAN COM COMPOSITION
        Employee employee = new Employee();
        Dog dog = new Dog("Cachorro do funcionario");
        employee.setDog(dog);
        httpServletRequest.setAttribute("employeeWithDog", employee);
        
        RequestDispatcher requestDispatcher = httpServletRequest.getRequestDispatcher("result.jsp");
        requestDispatcher.forward(httpServletRequest, httpServletResponse);
    }
}