<!-- SPDX-License-Identifier: MIT --->

About certificates untracked folder
===================================

Here your p12 certificates have to be stored
- local development
- prod
- ..

Inside this folder GIT does ignore anything except this `README.md`!

For local development please call `dev-ensure_localhost_certificate.sh` - it will create a new self signed certificate to this folder. 


Why?
----
For security reasons: If a developer does accept this certificate on his/her machine it would be an attack vector if the certificate would be ever checked in...

