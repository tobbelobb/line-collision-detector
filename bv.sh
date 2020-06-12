#!/bin/bash

# |& pipes both stdout and stderr

b "$@" |&
	awk '{
         line=$0;
         ORS="";
         if (line ~/(\.c|\.cpp|\.h|\.c\+\+|\.h\+\+):[0-9]+:[0-9]+:.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?(note|error):/)
         {
           n=split(line, a, ":");
           print("vim " a[1] " +" a[2] " ;# ");
           print(a[3]);
           for(i=4;i<n+1;i++){
             print(":" a[i])
           }
           print("\n");
         }
         else
         {
             print(line "\n");
         };
       }' | head -n 40
