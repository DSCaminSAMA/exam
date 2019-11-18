package com.thoughtworks.exam.viewmodel.admin.task;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

@Data
public class TaskPageRequestVM extends BasePage {
    private Integer gradeLevel;
}
