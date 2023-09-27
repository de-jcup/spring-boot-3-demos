package de.jcup.example.springboot3.webserver.hello;

import java.util.Optional;

import org.springframework.stereotype.Service;

@Service
public class HelloService {

    public Hello sayHello() {
        Hello hello = new Hello();
        hello.setDetails(Optional.of("I am an optional detail from service"));
        return hello;
    }
}
