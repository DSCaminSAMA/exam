package com.thoughtworks.exam.service;

import com.thoughtworks.exam.domain.User;
import com.thoughtworks.exam.domain.UserToken;

public interface UserTokenService extends BaseService<UserToken> {

    UserToken bind(User user);

    UserToken checkBind(String openId);

    UserToken getToken(String token);

    UserToken insertUserToken(User user);

    void unBind(UserToken userToken);
}
