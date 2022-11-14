import pandas as pd
import numpy as np
import sys
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.tokenize import word_tokenize
import nltk
nltk.download('punkt')
from nltk.corpus import stopwords
import string
import re

def clean_body(word):
    result = re.sub(r'[^0-9A-Za-z ]+', '', word)
    # result = re.sub(r'[0-9A-Za-z]{0,2}', '', result)
    result = re.sub(r'[0-9]+','',result)

    return result

df=pd.read_csv(sys.stdin,index_col=False)

stopwordsList = set(stopwords.words('english'))

punctiuations = string.punctuation 
punctiuationsList = list(punctiuations)
stopwordsList.update(punctiuationsList)

count=[]

for ind in df.index:
    df['review_body'][ind]=clean_body(df['review_body'][ind])
    df['review_body'][ind]=[w for w in word_tokenize(df['review_body'][ind]) if not w.lower() in stopwordsList]
    # df['tfidf'][ind]=tfidf.fit_transform(df['review_body'][ind])
    count.append([pd.value_counts(np.array(df['review_body'][ind]),normalize=True)])


words=[]
count=0
for j in count:
    for i in j:
        if count <=10:
            words.append(i.index)


print(words)

