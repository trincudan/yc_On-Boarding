#!/bin/bash

#Create user 'dan.trincu@test.com'
curl -s -k -u admin:admin -FcreateUser=dan.trincu@test.com -FauthorizableId=dan.trincu@test.com -Frep:password="testpass" -Fprofile/email=dan.trincu@test.com https://localhost:4502/libs/granite/security/post/authorizables

#Create group 'test-group'
curl -s -k -u admin:admin -FcreateGroup=test-group -FauthorizableId=test-group http://localhost:4502/libs/granite/security/post/authorizables

#Add user 'dan.trincu@test.com' to group 'test-group'
curl -s -k -u admin:admin -FaddMembers=dan.trincu@test.com http://localhost:4502/home/groups/q/qVup8Li_CQUqgh_VyAE6.rw.html

