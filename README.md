# Certification-project-DAFT410

*Mixology is defined as "the skills to mix cocktails and drinks". My proposed algorythm recommends to users one or more cocktail recipe according to the ingredients you like, and those you have in your home. From there on, the user will acquier a deeper comprehension and can evolve into more complexe cocktails!*  

## Cocktail recommender : according to available ingredients. 
Best version = https://www.cocktailbuilder.com/  


HOW TO LINKS:  
- https://medium.com/@AI_Whisperer/how-i-made-a-cocktail-recommendation-app-using-machine-learning-with-python-streamlit-airtable-9e60dc054dc (project)  
- https://github.com/luongtruong77/nlp-drinks-cocktails-recommender (github)  
- https://github.com/luongtruong77/nlp-drinks-cocktails-recommender/tree/main/notebooks (notebooks)  
- https://lvngd.com/blog/building-cocktail-recommender-python/ (using node graph)

EXISTING DATASET :  
- https://www.kaggle.com/datasets/shuyangli94/cocktails-hotaling-co (cocktail recipde dataset - 600 cocktails)  

TO WEB SCRAPP :  
- https://www.drinklab.org/cocktail-recipes/  (cocktail recipde sebwite - 10 000 cocktails)

Concat both dataset, dropping redundant ?  
Keep just the 10 000 recipes dataset.  

### Pipeline:  
* ETL data
* Build recommender using :  KNNeighbors ? Graph ?
* Manage user input :  make a list of ingredients to select from ?
* Manage output : what appears & what format.  
* Integrate into Streamlit  



#### Recommender = Clusters
#### Classifier = categories
#### Score/Number output = Regression



____________________________________________________________________________________________________________________________________________

## Level 1 :
### Whisky recommender: according to whiskey description and favorite whisky recommend other whiskeys. => recommend new whiskeys only ?
LINKS :  
- https://medium.com/@hylau17/whisky-recommendation-using-user-drinker-based-nearest-neighbor-and-matrix-factorization-f06d7d25a705 (Tutorial)  
- https://gabrielashirley.com/whiskey-recommender-system.pdf  (pro project recap')
- https://github.com/minionsDoJo/Wiskey-Recommendation-System  
- https://www.kaggle.com/datasets/koki25ando/22000-scotch-whisky-reviews  
- https://betterprogramming.pub/scraping-whiskey-review-data-to-build-a-recommendation-system-af6b82f31301  
- https://www.kaggle.com/code/koheimuramatsu/whiskey-reviews-eda-recommendation-using-bert/notebook (recommender project using BERT language model for NLP)


### TV Show - Drink pairing recommender : accordin to mood of the show, recommend a drink  
meh... or meh?

## Level 2 :
### Analyse website copywriting / blog posts and classify it into a list of blog posts for you to read about a certain subject:  
medium.com / mashable / techcrunch / gizmodo / huffpost (choose one ?)  
- https://medium.com/web-mining-is688-spring-2021/article-recommendation-system-using-python-8b0fec6e6de8  

### Recommender article:  
https://anderfernandez.com/en/blog/recommendation-system-with-python/

## Level 3 :
### Analyse photos from your device, and classifies them and appends them in separate folders: cute animals, traveling, food, political, 
(same dimension picture, find training pictures (a lot) )  

https://blog.hubspot.fr/marketing/instagram-api



### User interactivity / input :
* No user input in Tableau !! => make predefined profile, or find an extension.
* **Use Streamlit**



