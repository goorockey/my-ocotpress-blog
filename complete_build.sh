#!/bin/sh

theme=$1


rake install["$theme"] && rake gen_deploy && git add . && git commit -a -m "renew" && git push origin source
