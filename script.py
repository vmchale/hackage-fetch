import os
import shutil

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
