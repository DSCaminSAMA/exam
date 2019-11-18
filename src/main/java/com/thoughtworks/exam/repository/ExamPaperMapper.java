package com.thoughtworks.exam.repository;

import com.thoughtworks.exam.domain.ExamPaper;
import com.thoughtworks.exam.domain.other.KeyValue;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperPageRequestVM;
import com.thoughtworks.exam.viewmodel.student.dashboard.PaperFilter;
import com.thoughtworks.exam.viewmodel.student.dashboard.PaperInfo;
import com.thoughtworks.exam.viewmodel.student.exam.ExamPaperPageVM;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface ExamPaperMapper extends BaseMapper<ExamPaper> {
    int deleteByPrimaryKey(Integer id);

    int insert(ExamPaper record);

    int insertSelective(ExamPaper record);

    ExamPaper selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ExamPaper record);

    int updateByPrimaryKey(ExamPaper record);

    List<ExamPaper> page(ExamPaperPageRequestVM requestVM);

    List<ExamPaper> taskExamPage(ExamPaperPageRequestVM requestVM);

    List<ExamPaper> studentPage(ExamPaperPageVM requestVM);

    List<PaperInfo> indexPaper(PaperFilter paperFilter);

    Integer selectAllCount();

    List<KeyValue> selectCountByDate(@Param("startTime") Date startTime, @Param("endTime") Date endTime);

    int updateTaskPaper(@Param("taskId") Integer taskId, @Param("paperIds") List<Integer> paperIds);

    int clearTaskPaper(@Param("paperIds") List<Integer> paperIds);

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

    List<Map<String,Object>> getContext(@Param("id") String id);



}
