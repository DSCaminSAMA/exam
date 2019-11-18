package com.thoughtworks.exam.configuration.spring.security;

import lombok.Data;

/**
 * @author liu
 */
@Data
public class AuthenticationBean {
    private String userName;
    private String password;
    private boolean remember;
}
