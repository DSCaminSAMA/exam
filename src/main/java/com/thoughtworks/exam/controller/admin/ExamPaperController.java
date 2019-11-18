package com.thoughtworks.exam.controller.admin;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thoughtworks.exam.base.BaseApiController;
import com.thoughtworks.exam.base.RestResponse;
import com.thoughtworks.exam.domain.ExamPaper;
import com.thoughtworks.exam.repository.ExamPaperMapper;
import com.thoughtworks.exam.service.ExamPaperService;
import com.thoughtworks.exam.utility.*;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperEditRequestVM;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamPaperPageRequestVM;
import com.thoughtworks.exam.viewmodel.admin.exam.ExamResponseVM;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController("AdminExamPaperController")
@RequestMapping(value = "/api/admin/exam/paper")
@AllArgsConstructor
public class ExamPaperController extends BaseApiController {

    private final ExamPaperService examPaperService;

    private final ExamPaperMapper examPaperMapper;

    @RequestMapping(value = "/page", method = RequestMethod.POST)
    public RestResponse<PageInfo<ExamResponseVM>> pageList(@RequestBody ExamPaperPageRequestVM model) {
        PageInfo<ExamPaper> pageInfo = examPaperService.page(model);
        PageInfo<ExamResponseVM> page = PageInfoHelper.copyMap(pageInfo, e -> {
            ExamResponseVM vm = modelMapper.map(e, ExamResponseVM.class);
            vm.setCreateTime(DateTimeUtil.dateFormat(e.getCreateTime()));
            return vm;
        });
        return RestResponse.ok(page);
    }



    @RequestMapping(value = "/taskExamPage", method = RequestMethod.POST)
    public RestResponse<PageInfo<ExamResponseVM>> taskExamPageList(@RequestBody ExamPaperPageRequestVM model) {
        PageInfo<ExamPaper> pageInfo = examPaperService.taskExamPage(model);
        PageInfo<ExamResponseVM> page = PageInfoHelper.copyMap(pageInfo, e -> {
            ExamResponseVM vm = modelMapper.map(e, ExamResponseVM.class);
            vm.setCreateTime(DateTimeUtil.dateFormat(e.getCreateTime()));
            return vm;
        });
        return RestResponse.ok(page);
    }



    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public RestResponse<ExamPaperEditRequestVM> edit(@RequestBody @Valid ExamPaperEditRequestVM model) {
        ExamPaper examPaper = examPaperService.savePaperFromVM(model, getCurrentUser());
        System.out.println(examPaper);
        ExamPaperEditRequestVM newVM = examPaperService.examPaperToVM(examPaper.getId());
        System.out.println(newVM);
        return RestResponse.ok(newVM);
    }

    @RequestMapping(value = "/select/{id}", method = RequestMethod.POST)
    public RestResponse<ExamPaperEditRequestVM> select(@PathVariable Integer id) {
        ExamPaperEditRequestVM vm = examPaperService.examPaperToVM(id);
        System.out.println(vm);
        return RestResponse.ok(vm);
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public RestResponse delete(@PathVariable Integer id) {
        ExamPaper examPaper = examPaperService.selectById(id);
        examPaper.setDeleted(true);
        examPaperService.updateByIdFilter(examPaper);
        return RestResponse.ok();
    }

    @RequestMapping(value = "/exam/{id}",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public void exam(@PathVariable Integer id, HttpServletResponse response){
       String path = this.getClass().getClassLoader().getResource("application.yml").getPath();
       String wordPath= FileUtils.getPath(path,FileUtils.WORD_PATH);
       String zipPath=FileUtils.getPath(path,FileUtils.ZIP_PATH);
       //获取前端的传过来的id
       ExamPaper examPaper = examPaperMapper.selectByPrimaryKey(id);
       //根据FrameTextContentId去获取t_text_content的试题
       Integer frameTextContentId = examPaper.getFrameTextContentId();
       System.out.println(frameTextContentId);
       //点击相应的试卷进入到textcontent中取试题
       String str = examPaperService.selectTextContent(frameTextContentId);
       //把取出来的字符串转化为json数组
       JSONArray json = JSONObject.parseArray(str);
       String s = "";
       String content = "";
       Gson gson = new Gson();
       Map<String, Object> data = new HashMap<>();
       Map<String, Object> obj = null;
       Map<String, Object> textContent = new HashMap<>();
       for (int i = 0;i<json.size();i++) {
           //循环每一个数组然后在变成字符串
           String name = json.getString(i);
           Map<String,Object> na = new HashMap<>();
           na = gson.fromJson(name,na.getClass());
           String name1 = (String) na.get("name");
           String s3 = name.replace(name1, "考试卷");
           System.out.println(s3);
           //截取掉前面没用的字符
           String substring = s3.substring(30, s3.length() - 1);
           //截取出来的转化为数组获取它的id
           net.sf.json.JSONArray array = net.sf.json.JSONArray.fromObject(substring);
           @SuppressWarnings("unchecked")
           List<Map<String, Object>> listJson = (List<Map<String, Object>>) array;
           for (int j= 0; j < listJson.size(); j++) {
               //这个循环是获取它的id然后拼接成一个字符串
               obj = listJson.get(j);
               int o = (int) obj.get("id");
               textContent = examPaperMapper.getTextContent(o);
               String content1 = (String) textContent.get("content");
               //System.out.println(content1);

               Map<String, Object> map = new HashMap<String, Object>();
               //string转化成map
               map = gson.fromJson(content1, map.getClass());
               //得到map中的题干
               String titleContent = (String) map.get("titleContent");
               Object questionItemObjects = map.get("questionItemObjects");
               String substring1 = questionItemObjects.toString();
               String substring2 = substring1.substring(1,substring1.length() - 1);
               String prefix = substring2.replace("prefix=", "选项");
               String content2 = prefix.replace("content=", " ");
               String s2 = RemoveHTML.Html2Text(content2);
               String replace1 = s2.replace("{", "");
               String replace2 = replace1.replace("}", "");
               String replace3 = replace2.replace("score=null", "");
               String replace4 = replace3.replace(",", " ");
               //System.out.println(replace4);
               //去掉里面的dom元素
               String s1 = RemoveHTML.Html2Text(titleContent);
               //去掉没用的转义&nbsp;替换成空格
               String replace = s1.replace("&nbsp;", " ");
               //System.out.println(s1);
               //循环出所有的题干
               content += "I. "+replace+ "\r\n" +replace4+"\r\n";
               //content += textContent;
               //s += "'"+o+"',";
           }
       }
        data.put("content",content);
        data.put("name",examPaper.getName());
        WordUtils.saveWord(data,wordPath);
        ZipUtils.saveZip(wordPath,zipPath,data.get("name").toString(),response);


       /*WordUtils.saveWord(data,wordPath);
       ZipUtils.saveZip(wordPath,zipPath,data.get("name").toString(),response);*/
   }



    //Map<String, Object> data = new HashMap<>();
    //            data.put("maplist", list);
    // exportExcel           ExportExcelUtil.exportExcel(new TemplateExportParams(), data, "knsrd.xls", "knsrd.xlsx", response);
}
