package com.thoughtworks.exam.viewmodel.student.dashboard;

import lombok.Data;

@Data
public class PaperInfoVM extends PaperInfo {
    private String startTime;
    private String endTime;
}
