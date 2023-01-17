package de.jcup.springboot3.profiledemo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ProfiledemoCommandLineRunner implements CommandLineRunner{

    @Value("${testing.profiles.server:undefined}")
    String server;

    @Value("${testing.profiles.database:undefined}")
    String database;

    @Value("${testing.profiles.products:undefined}")
    String products;

    @Value("${spring.profiles.active:}")
    String springActiveProfiles;

    
    @Override
    public void run(String... args) throws Exception {
        System.out.println("____________________________________________________________");
        System.out.println("Currently Spring Profiles active:"+springActiveProfiles);
        System.out.println("____________________________________________________________");
        
        System.out.println("\nLeads to situation:");
        System.out.println("-server:"+server);
        System.out.println("-database:"+database);
        System.out.println("-products:"+products);
    }

}
