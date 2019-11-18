package com.thoughtworks.exam.base;


import com.thoughtworks.exam.context.WebContext;
import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.utility.ModelMapperSingle;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author liu
 */
public class BaseApiController {
    protected final static String DEFAULT_PAGE_SIZE = "10";
    protected final static ModelMapper modelMapper = ModelMapperSingle.Instance();
    @Autowired
    protected WebContext webContext;

    protected User getCurrentUser() {
        return webContext.getCurrentUser();
    }
}
