package com.thoughtworks.exam.viewmodel.admin.exam;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

@Data
public class ExamPaperPageRequestVM extends BasePage {

    private Integer id;
    private Integer subjectId;
    private Integer level;
    private Integer paperType;
    private Integer taskExamId;
}
