#!/bin/bash
cd /root/config/nb
nb run &
go-cqhttp &
wait