package com.thoughtworks.exam.domain.question;

import lombok.Data;

@Data
public class QuestionItemObject {

    private String prefix;

    private String content;

    private Integer score;
}
