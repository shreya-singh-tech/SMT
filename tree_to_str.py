from sys import argv
import io

script , from_file = argv
temp=[]

datafile = file(from_file)
for line in datafile:
    if "(ROOT" in line.strip():
	temp.append("\n")        
	temp.append(line.strip())
	  
    else:
	temp.append(line.strip())

for i in temp :
    if i =="\n":
	print("\n")
    else:
	print i,


