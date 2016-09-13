import os
import sys
import re

def write_to_file(file_object,code):
    file_object.write(code)
    file_object.close();

def create_and_write_new_file(filename,code):
     print("creating and writng to " + filename)
     dir = os.path.dirname(filename)
     try:
           os.stat(dir)
     except:
           os.mkdir(dir)

     file_object = open(filename,"w")
     write_to_file(file_object,code)

def append_to_file(filename,code):
    print("appending to " + filename)
    file_object = open(filename,"a")
    write_to_file(file_object,code)

def extract_if_applicable(code):
    regexp = re.compile("//file:\s*\{(.*)\}")
    regexp_for_partial = re.compile("//file\-([0-9]+):\s*\{(.*)\}")

    result = regexp.search(code)
    partial_result = regexp_for_partial.search(code)
    if result:
         filename = result.group(1)
         create_and_write_new_file(filename,code)
    elif partial_result:
         filename = partial_result.group(2)
         if partial_result.group(1) == "1":
             create_and_write_new_file(filename,code)
         else:
             append_to_file(filename,code)

file_buffer = ""
buffer_read = False

for line in sys.stdin:
    if line.startswith("```c") or line.startswith("~~~c"):
        buffer_read = True
    elif line.startswith("```")  or line.startswith("~~~"):
        extract_if_applicable(file_buffer)
        buffer_read = False
        file_buffer = ""
    elif buffer_read:
        file_buffer = file_buffer + line
