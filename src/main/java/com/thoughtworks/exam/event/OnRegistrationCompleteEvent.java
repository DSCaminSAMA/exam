package com.thoughtworks.exam.event;

import com.thoughtworks.exam.domain.User;
import org.springframework.context.ApplicationEvent;

/**
 * @author liu
 */
public class OnRegistrationCompleteEvent extends ApplicationEvent {


    private final User user;


    public OnRegistrationCompleteEvent(final User user) {
        super(user);
        this.user = user;
    }

    public User getUser() {
        return user;
    }

}