# -*- coding: utf-8 -*-
"""
Created on Mon Jul 21 20:51:21 2014

@author: Brett
"""

import sqlite3
import random
conn = sqlite3.connect(r"C:\Users\Brett\Dropbox\CUNY\egdb.sqlite") #Creates new database in SQLite
cur = conn.cursor()

cur.execute('DROP TABLE IF EXISTS  table1')
cur.execute('CREATE TABLE table1 (id INTEGER, names TEXT, lastNameID INTEGER)')
names = ["tom", "dick", "harry", "steve", "brett", "thomas"]
for i in range(len(names)):
    cur.execute('INSERT INTO table1 (id, names, lastNameID) VALUES (?,?,?)', ((i+1), names[i],random.randrange(1,4,1))) #Gives everyone a random last name

lastnames = ["smith", "thompkins", "doe"]
cur.execute('DROP TABLE IF EXISTS  table2')
cur.execute('CREATE TABLE table2 (lastNameID INTEGER, lastName TEXT)')
for i in range(len(lastnames)):
    cur.execute('INSERT INTO table2 (lastNameID, lastName) VALUES (?,?)', ((i+1), lastnames[i]))
cur.execute('SELECT names, lastName FROM table1 LEFT JOIN table2 ON table1.lastNameID = table2.lastnameID')
for row in cur:
    print row
conn.commit()
cur.close()