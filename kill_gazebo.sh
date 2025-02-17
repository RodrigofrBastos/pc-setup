#!/bin/bash
#

declare -a list_of_gazebo=("ign")
declare -a list_of_apps=("launch", "ign", "humble")
declare -a list_of_pids=()
declare -a list_of_gazebo_instance=("gazebo", "gzserver",  "gzserver", "gzclient", "gzclient")


printf -- " -- \e[93mSeeking active processes...\e[0m\n"


for i in  ${list_of_gazebo_instance[@]}; do
  query=`ps aux | grep verbose | grep $i | awk '{ split($13,a,"/"); print "|"$2 }'`
  if [ ! -z "$query" ];then
    IFS='|' query_list=(${query[@]})
    for val in ${query_list[@]}; do
      if [ ! -z "$val" ];then
        aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
        list_of_pids+=($aux_var)
        printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
      fi
    done
  fi
done
sleep 1

query=`ps aux | grep ruby | grep 'ign)' | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi


query=`ps aux | grep ruby | grep 'ign)' | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi

query=`ps aux | grep ros2 | grep launch | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi

query=`ps aux | grep ign | grep server | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi


(( ${#list_of_pids[@]} )) || printf -- " -- \e[93mNo processes found!\e[0m\n"

for i in ${list_of_pids[@]}; do
  printf -- " -- KILL PID \e[31m\e[1m $i\e[0m\n"
  kill -9 $i
done

sleep 1

unset list_of_pids

(( ${#list_of_pids[@]} )) || printf -- " -- \e[93mLooking for persistent processes and zombies...\e[0m\n"

query=`ps aux | grep ruby | grep 'ign)' | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi

query=`ps aux | grep ros2 | grep launch | awk '{ split($13,a,"/"); print "|"$2 }'`
if [ ! -z "$query" ];then
  IFS='|' query_list=(${query[@]})
  for val in ${query_list[@]}; do
    if [ ! -z "$val" ];then
      aux_var=$(echo $val | sed '/^[[:space:]]*$/d')
      list_of_pids+=($aux_var)
      printf -- " -- \e[93mSeeking \e[34m %-10s \e[0m Process %6s\n" $i $aux_var
    fi
  done
fi
sleep 1

defunct=`ps axo stat,ppid,pid,comm | grep -w defunct | awk '{ split($13,a,"/"); print $2 }'`
  if [ ! -z "$defunct" ];then
    printf -- " --KILL PID \e[31m\e[1m $defunct\e[0m\n"
    kill -9 $defunct
  fi
