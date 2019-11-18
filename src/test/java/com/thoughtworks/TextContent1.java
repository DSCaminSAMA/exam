package com.thoughtworks;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thoughtworks.exam.domain.ExamPaper;
import com.thoughtworks.exam.domain.TextContent;
import com.thoughtworks.exam.repository.ExamPaperMapper;
import com.thoughtworks.exam.repository.TextContentMapper;
import com.thoughtworks.exam.utility.*;
import com.google.gson.Gson;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = ExamApplicationTests.class)
public class TextContent1 {

    @Autowired
    private ExamPaperMapper examPaperMapper;
    @Autowired
    private TextContentMapper textContentMapper;

    @Test
    public void test(){
        //获取前端的传过来的id
        //String path = this.getClass().getClassLoader().getResource("application.yml").getPath();
        //String wordPath= FileUtils.getPath(path,FileUtils.WORD_PATH);
        //String zipPath=FileUtils.getPath(path,FileUtils.ZIP_PATH);
        ExamPaper examPaper = examPaperMapper.selectByPrimaryKey(4);
        //根据FrameTextContentId去获取t_text_content的试题
        Integer frameTextContentId = examPaper.getFrameTextContentId();
        //System.out.println(frameTextContentId);
        //点击相应的试卷进入到textcontent中取试题
        String str = examPaperMapper.selectTextContent(frameTextContentId);
        //把取出来的字符串转化为json数组
        JSONArray json = JSONObject.parseArray(str);
        String s = "";
        Map<String, Object> data = new HashMap<>();
        Map<String, Object> obj = null;
        String content = "";
        Map<String, Object> textContent = new HashMap<>();
        Gson gson = new Gson();
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
                content += replace+ "\r\n" +replace4+"\r\n";

            }

        }
        System.out.println(content);
        data.put("content",content);
        //WordUtils.saveWord(data,wordPath);
        //ZipUtils.saveZip(wordPath,zipPath,data.get("name").toString(),response);

        //把刚才循环中的字符串截取掉最后一个,放入到sql的in()中,这样就能查询到它的题号了
        /*String substring = s.substring(0,s.length()-1);
        //String substring2 = "(" +substring+")";
        System.out.println(substring);
        List<Map<String, Object>> textContent = examPaperMapper.getTextContent(substring);
        int size = textContent.size();
        System.out.println(size);*/
    }
    @Test
    public void test2(){
        List<TextContent> textContents = textContentMapper.getTextContentById(80);
        List<Integer> tIds = textContents.stream().map(textContent -> textContent.getId()).collect(Collectors.toList());
        System.out.println(tIds);

    }


}
