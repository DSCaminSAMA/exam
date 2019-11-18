package com.thoughtworks.exam.viewmodel.admin.question;

import com.thoughtworks.exam.base.BasePage;
import lombok.Data;

@Data
public class QuestionPageRequestVM extends BasePage {

    private Integer id;
    private Integer level;
    private Integer subjectId;
    private Integer questionType;
    private String knowledgePoint;
}
