package de.jcup.example.springboot3.webserver.userinfo;

import java.time.LocalDateTime;
import java.util.Optional;

public class UserInfo {

    private LocalDateTime creationTime = LocalDateTime.now();
    private String title = "Userinfo for loged in user";
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
