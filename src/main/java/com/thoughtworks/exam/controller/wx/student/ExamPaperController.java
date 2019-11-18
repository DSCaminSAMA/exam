package com.thoughtworks.exam.controller.wx.student;

import com.thoughtworks.exam.base.RestResponse;
import com.thoughtworks.exam.controller.wx.BaseWXApiController;
import com.thoughtworks.exam.domain.ExamPaper;
import com.thoughtworks.exam.domain.Subject;
import com.thoughtworks.exam.service.ExamPaperService;
import com.thoughtworks.exam.service.SubjectService;
import com.thoughtworks.exam.utility.DateTimeUtil;
import com.thoughtworks.exam.utility.PageInfoHelper;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperEditRequestVM;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperPageResponseVM;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperPageVM;
import com.github.pagehelper.PageInfo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;


@Controller("WXStudentExamController")
@RequestMapping(value = "/api/wx/student/exampaper")
@AllArgsConstructor
@ResponseBody
public class ExamPaperController extends BaseWXApiController {

    private final ExamPaperService examPaperService;
    private final SubjectService subjectService;


    @RequestMapping(value = "/select/{id}", method = RequestMethod.POST)
    public RestResponse<ExamPaperEditRequestVM> select(@PathVariable Integer id) {
        ExamPaperEditRequestVM vm = examPaperService.examPaperToVM(id);
        return RestResponse.ok(vm);
    }


    @RequestMapping(value = "/pageList", method = RequestMethod.POST)
    public RestResponse<PageInfo<ExamPaperPageResponseVM>> pageList(@Valid ExamPaperPageVM model) {
        model.setLevelId(getCurrentUser().getUserLevel());
        PageInfo<ExamPaper> pageInfo = examPaperService.studentPage(model);
        PageInfo<ExamPaperPageResponseVM> page = PageInfoHelper.copyMap(pageInfo, e -> {
            ExamPaperPageResponseVM vm = modelMapper.map(e, ExamPaperPageResponseVM.class);
            Subject subject = subjectService.selectById(vm.getSubjectId());
            vm.setSubjectName(subject.getName());
            vm.setCreateTime(DateTimeUtil.dateFormat(e.getCreateTime()));
            return vm;
        });
        return RestResponse.ok(page);
    }
}
