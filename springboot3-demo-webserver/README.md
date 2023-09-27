# README

## Create self signed certificate

call `dev-ensure_localhost_certificate.sh` from command line

Remark: the certificates are never stored inside git... just for local development

## Start demo server locally

```
    export SPRING_PROFILES_ACTIVE=server_local
    ./gradlew bootRun
    
```

## Try it out

### Unauthenticated
https://localhost:8443/hello

### Authenticated
https://localhost:8443/userinfo

enter "user" as user name and use the generated password inside the console output

After this you see the json output with the user info
