package com.thoughtworks.exam.viewmodel.admin.education;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

@Data
public class SubjectPageRequestVM extends BasePage {
    private Integer id;
    private Integer level;
}
