from sklearn.feature_extraction.text import TfidfVectorizer
import pandas as pd
import numpy as np
from sklearn.svm import SVR
import time

start_time = time.time()

df=pd.read_table(".\\cleanSpamHam.csv" ,sep=',', names=['mail','label'])
df_test = pd.read_csv(".\\amazon_reviews_us_Music.tsv", sep='\t', on_bad_lines='skip')
df = df.iloc[1:]
df.label.value_counts()
df['HM'] = df.label.map({'ham':0,'spam':1})

df_test.dropna()
df_test['review_body'] = df_test['review_body'].apply(lambda x: np.str_(x))

df.dropna()
df.drop(columns=['label'], inplace=True)

tfidf = TfidfVectorizer()

print("lamda started")
df['mail'] = df['mail'].apply(lambda x: np.str_(x))

print("lamda ended")
 
# get tf-df values
result = tfidf.fit_transform(df['mail'])
feature_names = tfidf.get_feature_names_out()
# denselist = dense.tolist()  #memmory error

test_vector_tf = tfidf.transform(df_test['review_body'])

prediction_model = SVR(kernel='linear', cache_size=10000).fit(result, df['HM'])

predicted = prediction_model.predict(test_vector_tf)

print(predicted)

df_test['class'] = pd.Series(predicted).values

df_test.loc[df_test['class'] == 1].head(100).to_csv(r'.\\display_csv.csv', index=None)

print("----- %s seconds -------" % (time.time() - start_time))