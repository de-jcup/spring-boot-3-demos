package de.jcup.example.springboot3.webserver.userinfo;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@EnableAutoConfiguration
public class UserInfoRestController {

    @Autowired
    UserInfoService userInfoService;

    @RequestMapping(path = "userinfo", method = RequestMethod.GET, produces = { MediaType.APPLICATION_JSON_VALUE })
    @ResponseStatus(HttpStatus.OK)
    public UserInfo sayHello(Authentication authentication) {
        UserInfo info = userInfoService.getUserInfo();
        info.setDetails(Optional.of("You are logged in as: '"+authentication.getName()+"'"));
        return info;
    }

}
