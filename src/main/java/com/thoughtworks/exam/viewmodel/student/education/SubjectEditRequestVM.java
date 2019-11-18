package com.thoughtworks.exam.viewmodel.student.education;

import com.thoughtworks.exam.viewmodel.BaseVM;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
public class SubjectEditRequestVM extends BaseVM {

    private Integer id;

    @NotBlank
    private String name;

    @NotNull
    private Integer level;

    @NotBlank
    private String levelName;

}