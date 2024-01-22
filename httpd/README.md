# `httpd` - WebDAV and CGI server.

This directory contains config files of the `httpd` component.

## Generate password file

Run the following command to generate `AuthUserFile` referenced in `httpd-dav.conf`:
```shell
htpasswd -c "users.passwd" admin
```
