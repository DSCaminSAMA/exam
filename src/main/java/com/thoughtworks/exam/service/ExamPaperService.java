package com.thoughtworks.exam.service;

import com.thoughtworks.exam.domain.ExamPaper;
import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperEditRequestVM;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperPageRequestVM;
import com.thoughtworks.exam.viewmodel.student.dashboard.PaperFilter;
import com.thoughtworks.exam.viewmodel.student.dashboard.PaperInfo;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperPageVM;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ExamPaperService extends BaseService<ExamPaper> {

    PageInfo<ExamPaper> page(ExamPaperPageRequestVM requestVM);

    PageInfo<ExamPaper> taskExamPage(ExamPaperPageRequestVM requestVM);

    PageInfo<ExamPaper> studentPage(ExamPaperPageVM requestVM);

    ExamPaper savePaperFromVM(ExamPaperEditRequestVM examPaperEditRequestVM, User user);

    ExamPaperEditRequestVM examPaperToVM(Integer id);

    List<PaperInfo> indexPaper(PaperFilter paperFilter);

    Integer selectAllCount();

    List<Integer> selectMothCount();

    /**
     * 这个根据id查询t_text_content表中试卷存放的试题内容
     * @param id
     * @return
     */
    String selectTextContent(@Param("id") Integer id);

    /**
     * 根据传递过来的ids去查询相应的试题
     * @param ids
     * @return
     */
    Map<String,Object> getTextContent(@Param("ids") Integer ids);
}
