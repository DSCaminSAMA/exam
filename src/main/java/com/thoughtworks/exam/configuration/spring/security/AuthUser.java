package com.thoughtworks.exam.configuration.spring.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

/**
 * @author liu
 */
public class AuthUser extends User {

    private com.thoughtworks.exam.domain.User user;

    AuthUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public AuthUser(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
    }


    public com.thoughtworks.exam.domain.User getUser() {
        return user;
    }

    public void setUser(com.thoughtworks.exam.domain.User user) {
        this.user = user;
    }
}
