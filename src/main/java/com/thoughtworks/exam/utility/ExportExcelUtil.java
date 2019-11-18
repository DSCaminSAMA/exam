package com.thoughtworks.exam.utility;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;
import cn.afterturn.easypoi.excel.entity.params.ExcelExportEntity;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;


public class ExportExcelUtil {

    /**
     * 模板路径
     */
    private static final String TEMPLATE_PATH = "static/";

    /**
     *拼接ExcelExportEntity,动态自定义导出列
     * @param beanList
     * @param title
     * @param sheetName
     * @param list
     * @param fileName
     * @param response
     */
    public static void exportExcel(List<ExcelExportEntity> beanList, String title, String sheetName,
                                   List<Map<String, Object>> list, String fileName, HttpServletResponse response){
        defaultExport(beanList,new ExportParams(title, sheetName), list, fileName, response);
    }

    /**
     * 使用模板导出excel
     * @param params
     * @param data
     * @param templateName
     * @param fileName
     * @param response
     */
    public static void exportExcel(TemplateExportParams params, Map<String, Object> data, String templateName,
                                   String fileName, HttpServletResponse response){
        defaultExport(params,data,templateName,fileName,response);

    }

    private static void defaultExport(List<ExcelExportEntity> beanList, ExportParams exportParams,
                                      List<Map<String, Object>> list, String fileName, HttpServletResponse response){
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams,beanList,list);
        if (workbook != null){
            downLoadExcel(fileName, response, workbook);
        }

    }

    /**
     * 基于模板导出
     * @param params 模板参数（业务层设置）
     * @param data  需要导出的数据
     * @param templateName 模板名
     * @param fileName  导出的文件名
     * @param response
     */
    private static void defaultExport(TemplateExportParams params, Map<String, Object> data,
                                      String templateName, String fileName, HttpServletResponse response){
        String templatePath = TEMPLATE_PATH + templateName;
        try {
            File file = getTemplateFile(templatePath);
            params.setTemplateUrl(file.getAbsolutePath());
            Workbook workbook = ExcelExportUtil.exportExcel(params,data);
            if (file.exists()){
                file.delete();
            }
            if (workbook != null){
                downLoadExcel(fileName, response, workbook);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    /**
     * 下载excel
     * @param fileName
     * @param response
     * @param workbook
     */
    private static void downLoadExcel(String fileName, HttpServletResponse response, Workbook workbook) {
        try {
            response.setCharacterEncoding("UTF-8");
            response.setHeader("content-Type", "application/vnd.ms-excel");
            response.setHeader("Content-Disposition",
                    "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            throw new NormalException(e.getMessage());
        }
    }

    /**
     * 获取模板文件--获取到的文件为临时文件，用完后需要手动删除
     * <p>由于springboot打包成jar之后，不能以绝对路径的形式读取模板文件，故此处将模板文件以临时文件的形式写到磁盘中，用完请手动删除</p>
     * @param templatePath 模板路径
     * @return 模板文件
     * @throws Exception 异常抛出
     */
    private static File getTemplateFile(String templatePath) throws IOException{
        File file = File.createTempFile("temp", null);
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource[] resources = resolver.getResources(templatePath);
        if(resources.length == 1) {
            InputStream inputStream = resources[0].getInputStream();
            inputStreamToFile(inputStream, file);
        }else {
            System.out.println("请检查模板文件是否存在");
        }
        return file;
    }

    /**
     * InputStream 转file
     * @param ins 输入流
     * @param file 目标文件
     */
    private static void inputStreamToFile(InputStream ins,File file) {
        try {
            OutputStream os = new FileOutputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.close();
            ins.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}