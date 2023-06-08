########################################
#  Import all necessary libraries

import streamlit as st
from PIL import Image

import pandas as pd
import numpy as np
import re

from sklearn.feature_extraction.text import CountVectorizer
from nltk.stem.snowball import EnglishStemmer

from sklearn.preprocessing import Normalizer
from sklearn.decomposition import TruncatedSVD

from sklearn.neighbors import NearestNeighbors

#########################################
#  Define functions

vectorizer = CountVectorizer(stop_words='english')


def preprocess_input(input):
    input = input.lower()
    # input = re.sub("[0-9]", "",input)
    input_word = input.split(' ')
    input_word = vectorizer.transform(input_word)
    return input_word

def recommend_ctl(x):

    # Import all variables from CSV
    df_ctl_text = pd.read_csv('./CSVs/df_ctl_text.csv', sep=',')
    # word_matrix_norm = pd.read_csv('./CSVs/word_matrix_norm.csv', sep=',')
    results_df = pd.read_csv('./CSVs/return_info_ctl.csv', sep=',')

    #  Create vectors & vocabulary
    text = df_ctl_text['text'].tolist()

    clean_text = []
    for x in text:
        clean_str = re.sub(r'\s+',' ', x)
        clean_str = re.sub(r'\d+\w*', '', x)
        clean_str = re.sub(r'cl', '', x)
        clean_text.append(clean_str)

    vectors = vectorizer.fit_transform(clean_text).todense()
    vocabulary = vectorizer.get_feature_names_out()

    # Create word matrix
    index = df_ctl_text['Name'].tolist()
    word_matrix = pd.DataFrame(vectors, columns=vocabulary, index=index)

    #  Truncate & Normalize
    svd = TruncatedSVD(n_components=5, n_iter=7, random_state=42)
    svd.fit(word_matrix)    

    normalizer = Normalizer() 
    word_matrix_norm = normalizer.fit_transform(word_matrix)
    word_matrix_norm = pd.DataFrame(word_matrix_norm)

    #  Define the model's data
    X = word_matrix_norm

    y = word_matrix_norm.reset_index()
    y.rename(columns={'index':'id'}, inplace=True)
    y = y['id']

    #  Define the model
    
    final_model = NearestNeighbors(n_neighbors=10, algorithm='auto' , leaf_size= 1 , radius= 0.07)
    final_model.fit(X.values,y.values)

    #  Run the model
    # user_input = st.text_input('Please describe what cocktail you would enjoy drinking!')
    # st.write(f"We'll do our best to propose cocktails corresponding to '{user_input}'.")
    
    input_vector = preprocess_input(user_input)

    distances, indices = final_model.kneighbors(input_vector)

    similar_cocktails = y.iloc[indices[0]].values

    st.write("Recommended cocktails:")

    results_df = results_df.iloc[similar_cocktails]
    st.write(results_df)


####################################################################################################
#  Setting up the streamlit interface:


####### Title 
st.title('Mix So Logic')
st.header('Cocktail recipe recommender for the recreational cocktail maker!')

##### Image #########
image = Image.open('bg_streamlit_app.jpg')
st.image(image) 


with st.form(key='cocktail_form'):
    # User input
    user_input = st.text_input('Please describe what cocktail you would enjoy drinking!', key='user_input')
    submit_button = st.form_submit_button(label='Submit')

    if submit_button and user_input:
        st.write(f"We'll do our best to propose cocktails corresponding to '{user_input}'.")
        recommend_ctl(user_input)


# prev_qry = ""
# user_query = st.text_input(label="Enter query")
# if st.button('Search') or (prev_qry != user_query):
#     prev_qry = user_query