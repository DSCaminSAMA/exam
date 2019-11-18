package com.thoughtworks.exam.viewmodel.admin.user;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

/**
 * @author liu
 */

@Data
public class UserEventPageRequestVM extends BasePage {

    private Integer userId;

    private String userName;

}
