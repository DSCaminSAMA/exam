package com.thoughtworks.exam.controller.wx;

import com.thoughtworks.exam.context.WxContext;
import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.domain.UserToken;
import com.thoughtworks.exam.utility.ModelMapperSingle;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;

public class BaseWXApiController {
    protected final static ModelMapper modelMapper = ModelMapperSingle.Instance();
    @Autowired
    private WxContext wxContext;

    protected User getCurrentUser() {
        return wxContext.getCurrentUser();
    }

    protected UserToken getUserToken() {
        return wxContext.getCurrentUserToken();
    }
}
