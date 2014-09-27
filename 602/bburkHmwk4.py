# -*- coding: utf-8 -*-
"""
Created on Fri Sep 26 14:33:47 2014

@author: Brett
Simple program that parses a hardcoded website link
"""
from alchemyapi import AlchemyAPI
import urllib
from bs4 import BeautifulSoup

# Hardcoded link
link = "http://www.gq.com/news-politics/newsmakers/201310/paul-kevin-curtis-elvis-impersonator-ricin-assassinations?printable=true"
f = urllib.urlopen(link)
website = f.read()
# Making soup
soup = BeautifulSoup(website)
docStr = soup.get_text()
# Simple hack to get rid
alchemyapi = AlchemyAPI()
response = alchemyapi.keywords('text', docStr)
# Pulling out just the keywords:
kw = response["keywords"]
# Printing to console
print "Top ten keywords and relevance:"
print "-" * 60
# Simple encoding
for i in range(10):
    print "%i. \t %s \n\t\t\t\t relevance: %s" % ((i+1), kw[i]["text"], kw[i]["relevance"])
    print "-" * 60