package com.thoughtworks.exam.controller.wx.student;

import com.thoughtworks.exam.base.RestResponse;
import com.thoughtworks.exam.controller.wx.BaseWXApiController;
import com.thoughtworks.exam.domain.TaskExam;
import com.thoughtworks.exam.domain.TaskExamCustomerAnswer;
import com.thoughtworks.exam.domain.TextContent;
import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.domain.enums.ExamPaperTypeEnum;
import com.thoughtworks.exam.domain.task.TaskItemAnswerObject;
import com.thoughtworks.exam.domain.task.TaskItemObject;
import com.thoughtworks.exam.service.ExamPaperService;
import com.thoughtworks.exam.service.TaskExamCustomerAnswerService;
import com.thoughtworks.exam.service.TaskExamService;
import com.thoughtworks.exam.service.TextContentService;
import com.thoughtworks.exam.utility.DateTimeUtil;
import com.thoughtworks.exam.utility.JsonUtil;
import com.thoughtworks.exam.viewmodel.student.dashboard.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


@Controller("WXStudentDashboardController")
@RequestMapping(value = "/api/wx/student/dashboard")
@AllArgsConstructor
@ResponseBody
public class DashboardController extends BaseWXApiController {

    private final ExamPaperService examPaperService;
    private final TextContentService textContentService;
    private final TaskExamService taskExamService;
    private final TaskExamCustomerAnswerService taskExamCustomerAnswerService;

    @RequestMapping(value = "/index", method = RequestMethod.POST)
    public RestResponse<IndexVM> index() {
        IndexVM indexVM = new IndexVM();
        User user = getCurrentUser();

        PaperFilter fixedPaperFilter = new PaperFilter();
        fixedPaperFilter.setGradeLevel(user.getUserLevel());
        fixedPaperFilter.setExamPaperType(ExamPaperTypeEnum.Fixed.getCode());
        indexVM.setFixedPaper(examPaperService.indexPaper(fixedPaperFilter));

        PaperFilter timeLimitPaperFilter = new PaperFilter();
        timeLimitPaperFilter.setDateTime(new Date());
        timeLimitPaperFilter.setGradeLevel(user.getUserLevel());
        timeLimitPaperFilter.setExamPaperType(ExamPaperTypeEnum.TimeLimit.getCode());

        List<PaperInfo> limitPaper = examPaperService.indexPaper(timeLimitPaperFilter);
        List<PaperInfoVM> paperInfoVMS = limitPaper.stream().map(d -> {
            PaperInfoVM vm = modelMapper.map(d, PaperInfoVM.class);
            vm.setStartTime(DateTimeUtil.dateFormat(d.getLimitStartTime()));
            vm.setEndTime(DateTimeUtil.dateFormat(d.getLimitEndTime()));
            return vm;
        }).collect(Collectors.toList());
        indexVM.setTimeLimitPaper(paperInfoVMS);
        return RestResponse.ok(indexVM);
    }

    @RequestMapping(value = "/task", method = RequestMethod.POST)
    public RestResponse<List<TaskItemVm>> task() {
        User user = getCurrentUser();
        List<TaskExam> taskExams = taskExamService.getByGradeLevel(user.getUserLevel());
        if (taskExams.size() == 0) {
            return RestResponse.ok(new ArrayList<>());
        }
        List<Integer> tIds = taskExams.stream().map(taskExam -> taskExam.getId()).collect(Collectors.toList());
        List<TaskExamCustomerAnswer> taskExamCustomerAnswers = taskExamCustomerAnswerService.selectByTUid(tIds, user.getId());
        List<TaskItemVm> vm = taskExams.stream().map(t -> {
            TaskItemVm itemVm = new TaskItemVm();
            itemVm.setId(t.getId());
            itemVm.setTitle(t.getTitle());
            TaskExamCustomerAnswer taskExamCustomerAnswer = taskExamCustomerAnswers.stream()
                    .filter(tc -> tc.getTaskExamId().equals(t.getId())).findFirst().orElse(null);
            List<TaskItemPaperVm> paperItemVMS = getTaskItemPaperVm(t.getFrameTextContentId(), taskExamCustomerAnswer);
            itemVm.setPaperItems(paperItemVMS);
            return itemVm;
        }).collect(Collectors.toList());
        return RestResponse.ok(vm);
    }


    private List<TaskItemPaperVm> getTaskItemPaperVm(Integer tFrameId, TaskExamCustomerAnswer taskExamCustomerAnswers) {
        TextContent textContent = textContentService.selectById(tFrameId);
        List<TaskItemObject> paperItems = JsonUtil.toJsonListObject(textContent.getContent(), TaskItemObject.class);

        List<TaskItemAnswerObject> answerPaperItems = null;
        if (null != taskExamCustomerAnswers) {
            TextContent answerTextContent = textContentService.selectById(taskExamCustomerAnswers.getTextContentId());
            answerPaperItems = JsonUtil.toJsonListObject(answerTextContent.getContent(), TaskItemAnswerObject.class);
        }


        List<TaskItemAnswerObject> finalAnswerPaperItems = answerPaperItems;
        return paperItems.stream().map(p -> {
                    TaskItemPaperVm ivm = new TaskItemPaperVm();
                    ivm.setExamPaperId(p.getExamPaperId());
                    ivm.setExamPaperName(p.getExamPaperName());
                    if (null != finalAnswerPaperItems) {
                        finalAnswerPaperItems.stream()
                                .filter(a -> a.getExamPaperId().equals(p.getExamPaperId()))
                                .findFirst()
                                .ifPresent(a -> {
                                    ivm.setExamPaperAnswerId(a.getExamPaperAnswerId());
                                    ivm.setStatus(a.getStatus());
                                });
                    }
                    return ivm;
                }
        ).collect(Collectors.toList());
    }


}
