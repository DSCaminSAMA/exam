package com.thoughtworks.exam.utility;

public class NormalException extends RuntimeException{
    private static final long serialVersionUID = 1L;

    public NormalException(String message) {
        super(message);
    }
}