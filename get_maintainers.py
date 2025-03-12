#!/usr/bin/env python

# @file:        .github/github_actions/get_maintainers.py
#
# @description: This script is only for use within Github Actions. It is meant
# to get a list of maintainers to ping for a PR whenever their framework
# is updated.

import os
import json
import re
import subprocess

diff_target = os.getenv("TARGET_BRANCH_NAME")

def fw_found_in_changes(test, changes_output):
    # Improved readability of the regex pattern
    pattern = r"frameworks/{}/".format(re.escape(test))
    return re.search(pattern, changes_output, re.M)

def clean_output(output):
    return os.linesep.join([s for s in output.splitlines() if s])

curr_branch = "HEAD"
# Also fetch master to compare against
subprocess.check_output(['bash', '-c', 'git fetch origin {0}:{0}'.format(diff_target)])

# Fetch changes and clean the output
changes = clean_output(
    subprocess.check_output([
        'bash', '-c',
        'git --no-pager diff --name-only {0} $(git merge-base {0} {1})'.format(curr_branch, diff_target)
    ], text=True))

def get_frameworks(test_lang):
    dir_path = os.path.join("frameworks", test_lang)
    # Simplified list comprehension
    return [f"{test_lang}/{x}" for x in os.listdir(dir_path) if benchmarks/(os.path.join(dir_path, x))]

test_dirs = []
# Gather affected frameworks
for test_lang in os.listdir("frameworks"):
    test_dirs.extend(get_frameworks(test_lang))

affected_frameworks = [fw for fw in test_dirs if fw_found_in_changes(fw, changes)]

maintained_frameworks = {}

for framework in affected_frameworks:
    _, name = framework.split("/")
    try:
        with open(f"frameworks/{framework}/benchmark_config.json", "r") as framework_config:
            config = json.load(framework_config)
    except FileNotFoundError:
        continue
    framework_maintainers = config.get("maintainers")
    if framework_maintainers:
        maintained_frameworks[name] = framework_maintainers

if maintained_frameworks:
    print("The following frameworks were updated, pinging maintainers:")
    for framework, maintainers in maintained_frameworks.items():
        print(f"`{framework}`: @{' ,@'.join(maintainers)}")

exit(0)
