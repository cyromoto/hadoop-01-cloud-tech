import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from wordcloud import WordCloud
import matplotlib.pyplot as plt

from sklearn.feature_extraction.text import TfidfVectorizer

import re
import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer 
from nltk.stem.porter import PorterStemmer



# #loading dataset
# df=pd.read_csv(".\\enron_spam_data.csv")
# df.drop(columns=['Message ID','Subject','Date'], inplace=True)
# df.to_csv(".\\cleanSpamHam.csv",index=None)


df=pd.read_table(".\\cleanSpamHam.csv" ,sep=',', names=['mail','label'])
df = df.iloc[1:]
df.label.value_counts()
df['HM'] = df.label.map({'ham':0,'spam':1})




df = df[df.HM==1]
df.dropna()
df.drop(columns=['label','HM'], inplace=True)
data=df['mail'].tolist()

ps = PorterStemmer()
lm = WordNetLemmatizer() 
corpus = []
for i in range(0, len(data)):
    review = re.sub('[^a-zA-Z]', ' ', data[i])
    review = review.lower()
    review = review.split()
    review = [lm.lemmatize(word) for word in review if not word in stopwords.words('english')]
    review = ' '.join(review)
    corpus.append(review)

print(corpus)
























# tfidf = TfidfVectorizer()
 
# # get tf-df values
# result = tfidf.fit_transform(df['mail'].values.astype('U'))
# feature_names = tfidf.get_feature_names_out()
# dense = result.todense()
# # denselist = dense.tolist()
# dftf = pd.DataFrame(dense, columns=feature_names)
# print(dftf)


# # dftf.head(1000).to_csv(".\\Test.csv",index="None")
# # # get indexing
# # print('\nWord indexes:')
# # print(tfidf.vocabulary_)
 
# # # display tf-idf values
# # print('\ntf-idf value:')
# # print(result)
 
# # # in matrix form
# # print('\ntf-idf values in matrix form:')
# # print(result.toarray())

# # spam_wc = WordCloud(width = 600,height = 512).generate(spam_words)
# # plt.figure(figsize = (12, 8), facecolor = 'k')
# # plt.imshow(spam_wc)
# # plt.axis('off')
# # plt.tight_layout(pad = 0)
# # plt.show()
# # X=df.mail
# # y=df.HM


# # X_train, X_test, y_train, y_test= train_test_split(X,y, random_state=1)
# # print(X_train.shape)
# # print(X_test.shape)
# # print(y_train.shape)
# # print(y_test.shape)

# # vect= CountVectorizer(stop_words='english')
# # X_train_dtm= vect.fit_transform(X_train)
# # X_test_dtm= vect.transform(X_test)


# # nb= MultinomialNB()
# # %time nb.fit(X_train_dtm, y_train)
