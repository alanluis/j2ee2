package com.example.listener;
import javax.servlet.http.*;

public class Dog implements HttpSessionBindingListener{
    private String breed;

    public Dog() {}

    public Dog(String breed) {
        this.breed = breed;
    }

    public String getBreed() {
        return this.breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    public String toString() {
        return this.breed;
    }

    public synchronized void valueBound(HttpSessionBindingEvent event){
        System.out.println("DOG " + this + " entrou na sessao");
    }

    public synchronized void valueUnbound(HttpSessionBindingEvent event){
        System.out.println("DOG " + this + " saiu da sessao");
    }
}