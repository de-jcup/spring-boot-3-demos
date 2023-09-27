package de.jcup.example.springboot3.webserver;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import static org.springframework.security.config.Customizer.withDefaults;
@Configuration
@EnableWebSecurity
public class DemoServerConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        /* @formatter:off */
        http.formLogin(withDefaults());
        
        http.
            authorizeHttpRequests((authorizeHttpRequests) ->   
                authorizeHttpRequests.
                  requestMatchers("/hello").anonymous().
                  requestMatchers("/**").authenticated()
            );
            
        /* @formatter:on */
        return http.build();
    }
    
}
