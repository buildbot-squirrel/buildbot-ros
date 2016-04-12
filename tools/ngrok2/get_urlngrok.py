#! /usr/bin/env python

import subprocess
import json

def run_command(command):
    p = subprocess.Popen(command,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.STDOUT)
    return iter(p.stdout.readline, b'')

if __name__ == '__main__':

  command = 'curl http://127.0.0.1:4040/api/tunnels'.split()
  for line in run_command(command):
    a = line
  a_dict =json.loads(a)
  b = a_dict.get("tunnels")
  c =b[1]
  url = c.get("public_url")
  print url
