package com.thoughtworks.exam.event;

import com.thoughtworks.exam.domain.ExamPaperAnswerInfo;
import org.springframework.context.ApplicationEvent;

/**
 * @author liu
 */
public class CalculateExamPaperAnswerCompleteEvent extends ApplicationEvent {


    private final ExamPaperAnswerInfo examPaperAnswerInfo;


    public CalculateExamPaperAnswerCompleteEvent(final ExamPaperAnswerInfo examPaperAnswerInfo) {
        super(examPaperAnswerInfo);
        this.examPaperAnswerInfo = examPaperAnswerInfo;
    }

    public ExamPaperAnswerInfo getExamPaperAnswerInfo() {
        return examPaperAnswerInfo;
    }

}
