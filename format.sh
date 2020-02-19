#!/bin/bash

while :
do
        echo "Press 1 : "
        echo "Press 2 : "
        echo "Press 3 : "
        echo "Press 4 : "
        echo "Press 5 : "
        echo "Press 6 : "
        read value

        if [ "$value" == 1 ];then
                echo -e "done 1 testing one \n"
        elif [ "$value" == 2 ];then
                echo -e "done 2 testing two \n"
        elif [ "$value" == 3 ];then
                echo "done 3 testing three \n"
        elif [ "$value" == 4 ];then
                echo -e "done 4 testing four \n"
        elif [ "$value" == 5 ];then
                echo -e "done 5 testing five \n"
        elif [ "$value" == 6 ];then
                echo -e "done 6 testing six \n"
        fi
done

