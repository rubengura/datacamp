__author__ = "rgr"

### LESSON 1
# IPython commands
# Showing free disk
!df -h

# Capturing output of a command
ls = !ls

# Capturing .csv filenames from a directory
ls = !ls test_dir/*.csv

# Unix pipes
# Counting size of python files
ls -l | awk '{ SUM +=$5} END {print SUM}'

# Pipe multiple outputs using Pipe operators
ls -l | grep .py | awk '{ SUM +=$5} END {print SUM}'

# Magic function %%bash
%%bash --out output
ls -l | awk '{ SUM +=$5} END {print SUM}'

%%bash --out output --err error
ls -l | awk '{ SUM +=$5} END {print SUM}'
echo "no error so far" >&2

# Working with SLists
disk_space = !df -h

print(disk_space)
# ['Filesystem      Size  Used Avail Use% Mounted on',
#  'overlay         194G   48G  146G  25% /',
#  'tmpfs            64M     0   64M   0% /dev',
#  'tmpfs            16G     0   16G   0% /sys/fs/cgroup',
#  '/dev/sda1       194G   48G  146G  25% /etc/hosts',
#  'shm              64M   24K   64M   1% /dev/shm',
#  'tmpfs            16G   12K   16G   1% /run/secrets/kubernetes.io/serviceaccount',
#  'tmpfs            16G     0   16G   0% /proc/acpi',
#  'tmpfs            16G     0   16G   0% /proc/scsi',
#  'tmpfs            16G     0   16G   0% /sys/firmware']

disk_space.fields(1)
# ['Size', '194G', '64M', '16G', '194G', '64M', '16G', '16G', '16G', '16G']

ls = !ls src
ls.grep(".py")
