package de.jcup.example.springboot3.webserver.hello;

import java.time.LocalDateTime;
import java.util.Optional;

public class Hello {

    private LocalDateTime creationTime = LocalDateTime.now();
    private String title = "Hello";
    private Optional<String> details;
    
    public Optional<String> getDetails() {
        return details;
    }

    public void setDetails(Optional<String> details) {
        this.details = details;
    }

    public LocalDateTime getCreationTime() {
        return creationTime;
    }
    
    public void setCreationTime(LocalDateTime creationTime) {
        this.creationTime = creationTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
}
