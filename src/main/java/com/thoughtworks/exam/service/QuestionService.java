package com.thoughtworks.exam.service;

import com.thoughtworks.exam.domain.Question;
import com.thoughtworks.exam.viewmodel.admin.question.QuestionEditRequestVM;
import com.thoughtworks.exam.viewmodel.admin.question.QuestionPageRequestVM;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface QuestionService extends BaseService<Question> {

    PageInfo<Question> page(QuestionPageRequestVM requestVM);

    Question insertFullQuestion(QuestionEditRequestVM model, Integer userId);

    Question updateFullQuestion(QuestionEditRequestVM model);

    QuestionEditRequestVM getQuestionEditRequestVM(Integer questionId);

    QuestionEditRequestVM getQuestionEditRequestVM(Question question);

    Integer selectAllCount();

    List<Integer> selectMothCount();
}
