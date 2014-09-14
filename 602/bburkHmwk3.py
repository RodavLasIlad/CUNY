# Assignment for Week 3
##### Question 1 #####
# Reading in values
import csv
import re
vals = []
with open('cars.data.csv', 'rb') as csvfile:
    reader = csv.reader(csvfile, delimiter=",")
    for row in reader:
        vals.append(row)

##### Cleaning the data #####
buying = ("vhigh", "high", "med", "low")
maint = ("vhigh", "high", "med", "low")
doors = ("2", "3", "4", "5more")
persons =("2", "4", "more")
lug_boot = ("small", "med", "big")
safety = ("low", "med", "high")
err = []
for i in range(len(vals)):
    if (vals[i][0] not in buying) or (vals[i][1] not in maint) or (vals[i][2] not in doors) or (vals[i][3] not in persons) or (vals[i][4] not in lug_boot) or (vals[i][5] not in safety):
        err.append(i)
##### Removing rows that contain erroneus data #####
if err:
    print "The following rows contain erroneus data and have been removed:"
    err.reverse()
    for i in err:
        print "Row #%s" % (i)
        print(vals[i])
        vals.pop(i)
else:
    print "No errors found in the data"

print "\n" * 3        

##### Question 2 #####
##### Part a #####
print "-" * 15 + "Safety descending (top 10)" +"-" * 15
header = ["buying", "maint", "doors", "ppl", "lug", "safe", "class"]
print "%s \t %s \t %s \t %s \t %s \t %s \t %s" % tuple(header)
print "-" * 56

levelsSafety = {"high": 10, "med": 5, "low": 1}
valsSafety = sorted(vals, key = lambda e: levelsSafety[e[5]], reverse=True)[1:10]
for i in valsSafety:
    print '\t '.join(i)
print "\n" * 3
    

##### Part b #####
print "-" * 13 + "Maintenance ascending (bot 10)" +"-" * 13
header = ["buying", "maint", "doors", "ppl", "lug", "safe", "class"]
print "%s \t %s \t %s \t %s \t %s \t %s \t %s" % tuple(header)
print "-" * 56

levelsMaint = {"vhigh": 15, "high": 10, "med": 5, "low": 1}
valsMaint = sorted(vals, key = lambda e: levelsMaint[e[1]])[-15:]

for i in valsMaint:
    print '\t '.join(i)
    
print "\n" * 3
##### Part c #####
regMatches = []
for i in vals:
    if re.match("v?high", i[0]) and re.match("v?high", i[1]) and re.match("v?high", i[5]):
        regMatches.append(i)
        
print "High/VHigh in buying, maint, and safety by doors ascending"
header = ["buying", "maint", "doors", "ppl", "lug", "safe", "class"]
print "%s \t %s \t %s \t %s \t %s \t %s \t %s" % tuple(header)
print "-" * 56

levelsReg = {"2":2, "3":3, "4":4, "5more":5}
valsReg = sorted(regMatches, key = lambda e: levelsReg[e[2]])
for i in valsReg:
    print '\t'.join(i)
print "\n" * 3

##### Part d #####
specMatches = []
f = open('output.txt', 'r+')
for i in vals:
    if i[0] == "vhigh" and i[1] == "med" and i[2] == "4" and (i[3] == "4" or i[3] == "more"):   
        f.write(','.join(i) + '\n')
print "Output Successful"
f.close()