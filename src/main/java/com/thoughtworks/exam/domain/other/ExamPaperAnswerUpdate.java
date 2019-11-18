package com.thoughtworks.exam.domain.other;

import lombok.Data;

@Data
public class ExamPaperAnswerUpdate {
    private Integer id;
    private Integer customerScore;
    private Boolean doRight;
}
