# -*- coding: utf-8 -*-
"""
Created on Fri Oct 19 12:40:26 2018

@author: ohmgs
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Oct  8 12:38:53 2018

@author: ohmgs
"""

# set working directory
import os
project_root = '/Users/ohmgs/Documents/ANLY503/project/'
os.chdir(project_root)

# Import Libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Seaborn Style:
import seaborn as sns
sns.set(style="darkgrid")

########################### Make a barplot of infrastructure index in 2016 ######################
# load data
#index = pd.read_csv('index2.csv')

# Read DataFrame ( and parse by Country)
df = pd.read_csv("Infrastructure_Index.csv", usecols=['2016','2003','Country'], parse_dates=['Country'])

# Read Income Level csv
income_level = pd.read_csv("Income Level.csv", usecols = ['country','income'])
# Change column name of country to Country for merging 2 dataframes 
income_level.columns = ['Country', 'income']


# Drop duplicates 
income_level_remove_duplicate = income_level.drop_duplicates()
# Merge two dataframes and drop 1 row(South Sudan) as it has a missing value
merged = pd.merge(df, income_level_remove_duplicate, on='Country')
merged = merged.dropna()
#merged.to_csv('merged.csv')


# Draw a borplot for 2016
plt.figure(figsize=(15,8))
plt.xlabel('Country', fontsize = 30)
ax = sns.barplot(x="2016", y="Country", hue="income", hue_order = ['High income', 'Upper middle income', 'Lower middle income', 'Low income'],
                 palette=['b','g','C1','r'],
                 data=merged, dodge=False
                 )
plt.xlabel("Index [0-100]", fontsize = 15)
plt.ylabel("Country", fontsize = 15)
plt.title("Infrastructure Index in 2016", fontsize = 20)


############################# Make a density plot of infrastructure index in 2003 and 20016#########

df = pd.read_csv("Infrastructure_Index.csv",  usecols=['2016','2003','Country'])

# Read Income Level csv
income_level = pd.read_csv("Income Level.csv", usecols = ['country','income'])
# Change column name of country to Country for merging 2 dataframes 
income_level.columns = ['Country', 'income']
# list(income_level)

# Drop duplicates 
income_level_remove_duplicate = income_level.drop_duplicates()
# Merge two dataframes and drop 1 row(South Sudan) as it has a missing value
merged = pd.merge(df, income_level_remove_duplicate, on='Country')
merged.to_csv('merged_income_infraindex.csv')

# Univariate Density Plots

names = ['year 2003', 'year 2016']
#plt.figure(figsize = (25,22))
plt.rcParams["figure.figsize"] = [16,9]
merged.plot(kind='density', layout=(1,2), sharex=False)
plt.title('Infrastructure Index in Africa 2003 and 2016', fontsize = 20)
plt.xlabel('Infrastructure Index', fontsize = 15)
plt.ylabel('Density', fontsize = 15)
plt.show()





