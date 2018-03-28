echo "checkColaUser.cmd userAccount domainName"
wmic useraccount where (name='%1' and domain='%2') list