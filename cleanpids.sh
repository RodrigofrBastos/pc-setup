#!/usr/bin/python3

import subprocess


class FindProcess:
    def __init__(self, value, filter_name):
        self.value = value
        self.filter_name = filter_name


list_of_pids = []

list_to_find_process = [
    FindProcess("/opt/ros/humble", "humble"),
    FindProcess("ros2", "launch"),
    FindProcess("cbr_ws/install", "lib"),
    FindProcess("gzserver", "cbr_ws/install"),
]


def build_command(value, filter_name):
    return (
        "ps aux | grep '"
        + value
        + "' | grep '"
        + filter_name
        + "' | awk '{ split($13,a,\"/\"); print \"|\"$2 }'"
    )


def list_process_pids():
    for item in list_to_find_process:
        print(" -- {}".format(item.value))
        command = build_command(item.value, item.filter_name)
        output = subprocess.check_output(command, shell=True, universal_newlines=True)
        query_list = output.strip().split("|")
        for val in query_list:
            aux_var = val.strip()
            if aux_var:
                list_of_pids.append(aux_var)
                print(" -- Seeking ... Process {:6s} found".format(aux_var))


def kill_process():
    for pid in list_of_pids:
        print(" -- KILL PID {}".format(pid))
        subprocess.call(["kill", "-9", pid])


if __name__ == "__main__":
    print(" -- Seeking active processes...")
    list_process_pids()
    kill_process()
