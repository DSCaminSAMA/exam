package com.thoughtworks.exam.viewmodel.student.question.answer;

import com.thoughtworks.exam.viewmodel.admin.question.QuestionEditRequestVM;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperSubmitItemVM;
import lombok.Data;

@Data
public class QuestionAnswerVM {
    private QuestionEditRequestVM questionVM;
    private ExamPaperSubmitItemVM questionAnswerVM;
}
