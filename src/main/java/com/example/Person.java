package com.example;

public abstract class Person {
    private String name;

    public Person() {}

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }
}