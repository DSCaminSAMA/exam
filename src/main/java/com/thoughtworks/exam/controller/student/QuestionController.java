package com.thoughtworks.exam.controller.student;

import com.thoughtworks.exam.base.BaseApiController;
import com.thoughtworks.exam.service.QuestionService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("StudentQuestionController")
@RequestMapping(value = "/api/student/question")
@AllArgsConstructor
public class QuestionController extends BaseApiController {

    private final QuestionService questionService;


}
