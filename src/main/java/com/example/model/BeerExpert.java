package com.example.model;

import java.util.*;

public class BeerExpert {
    public List<String> getBrands(String color) {
        List<String> brands = new ArrayList<>();

        if (color.equals("amber")) {
            brands.add("Kack Amber.");
            brands.add("Red Moose.");
            return brands;
        }

        brands.add("Jail Pale Ale.");
        brands.add("Gout Sout.");

        return brands;
    }
}