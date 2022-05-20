#!/bin/bash

rpm --quiet -q tigervnc-server
if [ $? -ne 0 ]; then
   yum -y install tigervnc-server
fi
x0vncserver AcceptKeyEvents=0 AcceptPointerEvents=0 \
AlwaysShared=1 SecurityTypes=None rfbport=5908
