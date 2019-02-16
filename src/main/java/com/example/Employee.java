package com.example;

import com.example.listener.Dog;

public class Employee extends Person {
    private int empID;
    private Dog dog;

    public Employee() {}

    public int getEmpID() {
        return this.empID;
    }

    public void setEmpID(int empID) {
        this.empID = empID;
    }

    public Dog getDog() {
        return this.dog;
    }

    public void setDog(Dog dog) {
        this.dog = dog;
    }
}