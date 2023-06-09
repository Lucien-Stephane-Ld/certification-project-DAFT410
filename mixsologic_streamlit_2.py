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
stemmer = EnglishStemmer()


def preprocess_input(input_text):
    input_text = input_text.lower()
    input_text = re.sub("[^a-zA-Z]", " ", input_text)
    input_words = input_text.split()
    stemmed_words = [stemmer.stem(word) for word in input_words]
    preprocessed_text = ' '.join(stemmed_words)
    return preprocessed_text


def recommend_ctl(input_text):
    # Preprocess user input
    input_text = preprocess_input(input_text)

    # Load data and model
    results_df = pd.read_csv('./CSVs/return_info_ctl.csv', sep=',')

    # Find nearest neighbors
   
    input_vector = preprocess_input(user_input)
    input_vector = np.asarray(input_vector)  # Convert to numpy array

    input_vector_norm = Normalizer().fit_transform(input_vector)

    distances, indices = final_model.kneighbors(input_vector_norm)

    # Get recommended cocktails
    similar_cocktails = indices[0]
    recommended_cocktails = results_df.iloc[similar_cocktails]

    return recommended_cocktails


####################################################################################################
#  Setting up the streamlit interface:


def train_model():
    # Import data
    df_ctl_text = pd.read_csv('./CSVs/df_ctl_text.csv', sep=',')
    clean_text = df_ctl_text['text'].apply(lambda x: re.sub(r'\d+\w*', '', x))

    # Create vectors & vocabulary
    vectors = vectorizer.fit_transform(clean_text).todense()
    vocabulary = vectorizer.get_feature_names_out()

    # Create word matrix
    index = df_ctl_text['Name'].tolist()
    word_matrix = pd.DataFrame(vectors, columns=vocabulary, index=index)

    # Truncate & Normalize
    svd = TruncatedSVD(n_components=5, n_iter=7, random_state=42)
    word_matrix_norm = svd.fit_transform(word_matrix)
    word_matrix_norm = Normalizer().fit_transform(word_matrix_norm)
    word_matrix_norm = pd.DataFrame(word_matrix_norm)

    # Define the model's data
    X = word_matrix_norm
    y = df_ctl_text['Name']

    # Define the model
    final_model = NearestNeighbors(n_neighbors=10, algorithm='auto', leaf_size=1, radius=0.07)
    final_model.fit(X)

    return final_model


# Train the model
final_model = train_model()

####### Title
# st.title('Mix So Logic')
# st.header('Cocktail recipe recommender for the recreational cocktail maker!')

##### Image #########
image = Image.open('bg_streamlit_app.jpg')
st.image(image)

with st.form(key='cocktail_form'):
    # User input
    user_input = st.text_input('Please describe what cocktail you would enjoy drinking!')
    submit_button = st.form_submit_button(label='Submit')

    if submit_button and user_input:
        st.write(f"We'll do our best to propose cocktails corresponding to '{user_input}'.")
        recommended_cocktails = recommend_ctl(user_input)
        st.write(recommended_cocktails)
