package com.thoughtworks.exam.viewmodel.admin.user;

import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.utility.DateTimeUtil;
import com.thoughtworks.exam.viewmodel.BaseVM;
import lombok.Data;

/**
 * @author liu
 */

@Data
public class UserResponseVM extends BaseVM {

    private Integer id;

    private String userUuid;

    private String userName;

    private String realName;

    private Integer age;

    private Integer role;

    private Integer sex;

    private String birthDay;

    private String phone;

    private String lastActiveTime;

    private String createTime;

    private String modifyTime;

    private Integer status;

    private Integer userLevel;

    public static UserResponseVM from(User user) {
        UserResponseVM vm = modelMapper.map(user, UserResponseVM.class);
        vm.setBirthDay(DateTimeUtil.dateFormat(user.getBirthDay()));
        vm.setLastActiveTime(DateTimeUtil.dateFormat(user.getLastActiveTime()));
        vm.setCreateTime(DateTimeUtil.dateFormat(user.getCreateTime()));
        vm.setModifyTime(DateTimeUtil.dateFormat(user.getModifyTime()));
        return vm;
    }
}
