#!/bin/bash
kill -9 `ps -ef|grep smsd |awk '{print $2}'`
kill -9 `ps -ef|grep injectord |awk '{print $2}'`