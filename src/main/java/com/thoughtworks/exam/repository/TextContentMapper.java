package com.thoughtworks.exam.repository;

import com.thoughtworks.exam.domain.TextContent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TextContentMapper extends BaseMapper<TextContent> {
    int deleteByPrimaryKey(Integer id);

    int insert(TextContent record);

    int insertSelective(TextContent record);

    TextContent selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TextContent record);

    int updateByPrimaryKey(TextContent record);

    List<TextContent> getTextContentById(Integer id);
}
