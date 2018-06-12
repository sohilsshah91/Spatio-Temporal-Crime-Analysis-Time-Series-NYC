
# coding: utf-8

# In[2]:


import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
get_ipython().magic('matplotlib inline')


# In[3]:


# read in data
dataset_raw = pd.read_csv("C:\\Users\\sohil\\Desktop\\NYU_2017_Materials_and_Assignments\\Fall2017\\PredictiveAnalytics\\Project\\NYPD_Complaint_Data_Historic.csv", sep=",", header=0)


# In[4]:


dataset_raw.head(n=8)


# In[20]:


def cleanData(dataset):
    # Removing garbage columns with higher NA values
    columns_toDrop = ['CMPLNT_NUM', 'CMPLNT_TO_DT', 'CMPLNT_TO_TM', 'PD_CD', 'PD_DESC', 'JURIS_DESC', 'PARKS_NM', 'HADEVELOPT']
    dataset = dataset.drop(columns_toDrop, 1)

    # Important columns to care and removing NAN values in these fields
    columns_toCare = ['X_COORD_CD', 'Y_COORD_CD']
    dataset_working = dataset.dropna(subset=columns_toCare, how='all')

    return dataset_working


# In[21]:


dataset_clean = cleanData(dataset_raw)
dataset_clean.head(n=8)


# In[7]:


# Save Claned Data file as CSV
dataset_clean.to_csv('crimeDataClean.csv', sep='\t', encoding='utf-8')


# In[8]:


dataNACountCMPLNT = dataset_clean['CMPLNT_FR_DT'].value_counts(dropna=False)
dataNACountCMPLNT


# In[17]:


dataNACountCMPLNT


# In[8]:


print(dataNACountCMPLNT.isnull().sum())


# In[10]:


from pandas import datetime
from matplotlib import pyplot
dataset_clean.groupby(['CMPLNT_FR_DT', 'LAW_CAT_CD', 'BORO_NM']).size()


# In[11]:


dataset_clean.groupby(['CMPLNT_FR_DT', 'LAW_CAT_CD', 'BORO_NM']).size()


# In[14]:


dataset_clean_crimetype = dataset_clean.groupby('OFNS_DESC').nunique()


# In[15]:


dataset_clean_crimetype


# In[19]:


dataset_clean.to_csv('C:\\Users\\sohil\\Desktop\\NYU_2017_Materials_and_Assignments\\Fall2017\\PredictiveAnalytics\\Project\\CrimeCleanTtest.csv', sep=',')


# In[22]:


import sys
import os.path
import os
import warnings
warnings.filterwarnings('ignore')
sys.path.append("../backend/")


# In[23]:


from PreProcessor import PreProcessor
