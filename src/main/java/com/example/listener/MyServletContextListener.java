package com.example.listener;

import javax.servlet.*;

public class MyServletContextListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("SERVIDOR INICIOU");
        ServletContext sc  = event.getServletContext();
        String dogBreed = sc.getInitParameter("breed");
        Dog d = new Dog(dogBreed);
        System.out.println("SETTING DOG " + d + " ATTRIBUTE ON CONTEXT");
        sc.setAttribute("dog", d);
    }

    public void contextDestroyed(ServletContextEvent event) {
        System.out.println("SERVIDOR ENCERROU");
    }
}