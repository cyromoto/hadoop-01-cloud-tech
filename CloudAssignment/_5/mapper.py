import pandas as pd
import sys


df=pd.read_csv(sys.stdin ,sep='\t', names=['id','review_body'])

df=df.groupby(['id']).sum()
df=df.reset_index(level=0)
print(df.to_csv(sep=',', index=False))
