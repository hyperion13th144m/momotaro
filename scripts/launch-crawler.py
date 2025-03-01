#!/usr/bin/env python

"""
This program is launcher for clawler.sh
"""

import os
import json
import fcntl
import subprocess

# Assuming the script directory is at the same level as the data directory.
project_root = os.path.join(os.path.dirname(__file__), '..')
version_data = os.path.join(project_root, 'data', 'version.json')
crawler_sh = os.path.join(project_root, 'scripts', 'crawler.sh')


### - crawler.sh finds archives and upload them to servers.
### - this launcher gives parameters to crawler.sh
### - upload is controlled by version.

### if current version == latest vresion
###    the launcher gives the crawler.sh parameters
###    that uploads the archives if the archives hasn't been uploaded.
###    (incremental upload)

### else if current version < latest version
###    the launcher gives the crawler.sh parameters
###    that uploads forcely the archives
###    regardless of wheter the archives has been uploaded.
###    after upload, sets current version to latest version.
###    (force upload)

### version consists of document codes to be uploaded.
### version_list is a list of the version.
version_list = [
    ['A101', 'A102', 'A1131', 'A1523', 'A153',
     'A163', 'A1631', 'A1632', 'A1634',],  # version 0
    ["A163"],                              # version 1
    ['A153', 'A163'],                      # version 2
    ['A101']                               # version 3
]


def get_current_version_index():
    """return current version index.
    
    if version_data exists, then read current version from it.
    else return 0
    """
    if os.path.exists(version_data):
        with open(version_data, 'r') as f:
            data = json.load(f)
            if 'version' in data:
                current_version_index = data['version']
    else:
        current_version_index = 0
    return current_version_index


def save_current_version_index(version):
    """save current version index to file"""
    with open(version_data, 'w') as f:
        json.dump({'version': version}, f)


def is_latest_version(version):
    return version >= len(version_list)


def flatten(arr):
    return sum(arr, [])


def main():
    current_version_index = get_current_version_index()

    if (is_latest_version(current_version_index)):
        # launcher gives no parameters.
        # the crawler.sh runs in incremental upload mode.
        cmd = f'{crawler_sh}'.split()
    else:
        # itegrate versions after current version.
        # -f: force update flag
        # -t: document codes to be uploaded
        targets = list(set(flatten(version_list[current_version_index:])))
        targets_arg = ','.join(targets)
        cmd = f'{crawler_sh} -t {targets_arg} -f'.split()

    result = subprocess.call(cmd)
    if result == 0:
        new_version = len(version_list)
        save_current_version_index(new_version)


if __name__ == '__main__':
    # prevent multiple invocation using file lock
    with open('/tmp/crawler-lockfile', 'w') as f:
        try:
            fcntl.flock(f.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
        except IOError:
            print('Another crawler is running')
            exit(0)

        try:
            main()
        finally:
            fcntl.flock(f.fileno(), fcntl.LOCK_UN)
