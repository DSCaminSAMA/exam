package com.thoughtworks.exam.viewmodel.admin.user;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

/**
 * @author liu
 */

@Data
public class UserPageRequestVM extends BasePage {

    private String userName;
    private Integer role;

}
