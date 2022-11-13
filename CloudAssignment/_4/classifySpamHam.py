import pandas as pd
import numpy as np
import nltk
nltk.download('punkt')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import string

# getting all stipwords
stopwordsList = set(stopwords.words('english'))

df=pd.read_csv(".\\spam.csv", sep=',', on_bad_lines='skip', encoding='latin-1')

punctiuations = string.punctuation 
punctiuationsList = list(punctiuations)
stopwordsList.update(punctiuationsList)

# stop word removal
spamWordList=[]
hamWordList=[]
for ind in df.index:
    if(df['v1'][ind]=='ham'):
        hamWordList.append([w for w in word_tokenize(df['v2'][ind]) if not w.lower() in stopwordsList])
    else:
        spamWordList.append([w for w in word_tokenize(df['v2'][ind]) if not w.lower() in stopwordsList])

hamWordList = [item for sublist in hamWordList for item in sublist]
spamWordList = [item for sublist in spamWordList for item in sublist]

# print (hamWordList)
hamDataFrame=pd.value_counts(np.array(hamWordList))
spamDataFrame=pd.value_counts(np.array(spamWordList))


hamDataFrame=hamDataFrame.iloc[50:100]
spamDataFrame=spamDataFrame.iloc[50:100]
# print(spamDataFrame.iloc[:100])

hamString="("
spamString="("

for i in hamDataFrame.index:
    hamString=hamString+"|"+str(i).upper()
for i in spamDataFrame.index:
    spamString=spamString+"|"+str(i).upper()
hamstring=hamString+")"
spamString=spamString+")"

print(hamstring)
# print(spamString)