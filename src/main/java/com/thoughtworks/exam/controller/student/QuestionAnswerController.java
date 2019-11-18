package com.thoughtworks.exam.controller.student;

import com.thoughtworks.exam.base.BaseApiController;
import com.thoughtworks.exam.base.RestResponse;
import com.thoughtworks.exam.domain.ExamPaperQuestionCustomerAnswer;
import com.thoughtworks.exam.domain.Subject;
import com.thoughtworks.exam.domain.TextContent;
import com.thoughtworks.exam.domain.question.QuestionObject;
import com.thoughtworks.exam.service.ExamPaperQuestionCustomerAnswerService;
import com.thoughtworks.exam.service.QuestionService;
import com.thoughtworks.exam.service.SubjectService;
import com.thoughtworks.exam.service.TextContentService;
import com.thoughtworks.exam.utility.DateTimeUtil;
import com.thoughtworks.exam.utility.HtmlUtil;
import com.thoughtworks.exam.utility.JsonUtil;
import com.thoughtworks.exam.utility.PageInfoHelper;
import com.thoughtworks.exam.viewmodel.admin.question.QuestionEditRequestVM;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperSubmitItemVM;
import com.thoughtworks.exam.viewmodel.student.question.answer.QuestionAnswerVM;
import com.thoughtworks.exam.viewmodel.student.question.answer.QuestionPageStudentRequestVM;
import com.thoughtworks.exam.viewmodel.student.question.answer.QuestionPageStudentResponseVM;
import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController("StudentQuestionAnswerController")
@RequestMapping(value = "/api/student/question/answer")
@AllArgsConstructor
public class QuestionAnswerController extends BaseApiController {

    private final ExamPaperQuestionCustomerAnswerService examPaperQuestionCustomerAnswerService;
    private final QuestionService questionService;
    private final TextContentService textContentService;
    private final SubjectService subjectService;

    @RequestMapping(value = "/page", method = RequestMethod.POST)
    public RestResponse<PageInfo<QuestionPageStudentResponseVM>> pageList(@RequestBody QuestionPageStudentRequestVM model) {
        model.setCreateUser(getCurrentUser().getId());
        PageInfo<ExamPaperQuestionCustomerAnswer> pageInfo = examPaperQuestionCustomerAnswerService.studentPage(model);
        PageInfo<QuestionPageStudentResponseVM> page = PageInfoHelper.copyMap(pageInfo, q -> {
            Subject subject = subjectService.selectById(q.getSubjectId());
            QuestionPageStudentResponseVM vm = modelMapper.map(q, QuestionPageStudentResponseVM.class);
            vm.setCreateTime(DateTimeUtil.dateFormat(q.getCreateTime()));
            TextContent textContent = textContentService.selectById(q.getQuestionTextContentId());
            QuestionObject questionObject = JsonUtil.toJsonObject(textContent.getContent(), QuestionObject.class);
            String clearHtml = HtmlUtil.clear(questionObject.getTitleContent());
            vm.setShortTitle(clearHtml);
            vm.setSubjectName(subject.getName());
            return vm;
        });
        return RestResponse.ok(page);
    }


    @RequestMapping(value = "/select/{id}", method = RequestMethod.POST)
    public RestResponse<QuestionAnswerVM> select(@PathVariable Integer id) {
        QuestionAnswerVM vm = new QuestionAnswerVM();
        ExamPaperQuestionCustomerAnswer examPaperQuestionCustomerAnswer = examPaperQuestionCustomerAnswerService.selectById(id);
        ExamPaperSubmitItemVM questionAnswerVM = examPaperQuestionCustomerAnswerService.examPaperQuestionCustomerAnswerToVM(examPaperQuestionCustomerAnswer);
        QuestionEditRequestVM questionVM = questionService.getQuestionEditRequestVM(examPaperQuestionCustomerAnswer.getQuestionId());
        vm.setQuestionVM(questionVM);
        vm.setQuestionAnswerVM(questionAnswerVM);
        return RestResponse.ok(vm);
    }

}
