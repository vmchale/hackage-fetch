import subprocess
import os
import shutil

# read lines
with open('all.txt') as f:
    content = f.readlines()

# strip whitespace
content = [x.strip()[1:-1] for x in content] 

# execute command for each line
for line in content:
    subprocess.run(["cabal", "unpack", "-d", "hackage", line])

hackage_names = [ dirs for path, dirs, _ in os.walk("hackage") ][0]

for x in hackage_names:
    shutil.move('hackage/' + x, 'hackage/' + x.partition("-")[0])

new_names = [ dirs for path, dirs, _ in os.walk("hackage") ][0]
file = open('hackage/cabal.project', 'w+')
file.write("packages: ")

for package in new_names[:-1]:
  if package != 'HLogger':
    file.write("%s, " % package)

file.write("%s" % new_names[-1])
