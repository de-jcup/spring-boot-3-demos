package de.jcup.example.springboot3.webserver.userinfo;

import org.springframework.stereotype.Service;

@Service
public class UserInfoService {
    
    public UserInfo getUserInfo() {
        UserInfo hello = new UserInfo();
        return hello;
    }
}
