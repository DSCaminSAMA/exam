package com.thoughtworks.exam.viewmodel.admin.message;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

@Data
public class MessagePageRequestVM extends BasePage {
    private String sendUserName;
}
