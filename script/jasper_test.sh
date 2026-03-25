#!/bin/bash

touch output/jasper_status.txt

source /cadence/cshrc

jaspergold -help > output/jasper_status.txt 2>&1

