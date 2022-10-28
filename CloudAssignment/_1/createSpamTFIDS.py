from sklearn.feature_extraction.text import TfidfVectorizer
import pandas as pd



df=pd.read_table(".\\cleanSpamHam.csv" ,sep=',', names=['mail','label'])
df = df.iloc[1:]
df.label.value_counts()
df['HM'] = df.label.map({'ham':0,'spam':1})


df = df[df.HM==1]
df.dropna()
df.drop(columns=['label','HM'], inplace=True)

tfidf = TfidfVectorizer()
 
# get tf-df values
result = tfidf.fit_transform(df['mail'].values.astype('U'))
feature_names = tfidf.get_feature_names_out()
dense = result.todense()
# denselist = dense.tolist()  #memmory error
dftf = pd.DataFrame(dense, columns=feature_names)
print(dftf)