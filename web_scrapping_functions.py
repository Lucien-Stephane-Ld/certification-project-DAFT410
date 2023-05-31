# WEB SCRAPPING FUNCTIONS

import requests
import pandas as pd
from bs4 import BeautifulSoup
import re



def get_names(url_list, ctl_names = []) :  # test this out
   
   # import requests
   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      names = soup.find('h1', class_="wprm-recipe-name wprm-block-text-bold").text
      ctl_names.append(names)

   return ctl_names





def get_description(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      description = soup.find('div', class_="wprm-recipe-summary wprm-block-text-normal")

      if description is not None:
         description_txt = soup.find('div', class_="wprm-recipe-summary wprm-block-text-normal").text
         ctl_description.append(description_txt)

      else:
         ctl_description.append("Unfortunately, we have no description for this drink... You'll have to describe it yourself!")




def get_prep_time(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      prep_time = soup.find('div', class_="wprm-recipe-block-container wprm-recipe-block-container-columns wprm-block-text-normal wprm-recipe-time-container wprm-recipe-total-time-container")

      if prep_time is not None:
         prep_time_txt = prep_time.text.replace(' minutes minutes',' minutes')
         ctl_preptime.append(prep_time_txt)

      else:
         ctl_preptime.append("No time estimate for the preparation... Only one way to find out!")




def get_ingredients(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      # ingredients = soup.find('div' , class_="wprm-recipe-ingredients-container wprm-recipe-ingredients-no-images wprm-recipe-87010-ingredients-container wprm-block-text-normal wprm-ingredient-style-regular wprm-recipe-images-before")
      ingredients = soup.find('div', class_="wprm-recipe-ingredient-group")

      if ingredients is not None:
         ingredients_txt = ingredients.text.replace('▢',' |').replace('  ',':')

         ctl_ingredients.append(ingredients_txt)

      else:
         ctl_ingredients.append("Woops... What happened ?! Something didn't work, please try again.")    




def get_recipe(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      recipe = soup.find('div', class_="wprm-recipe-instruction-group")

      if recipe is not None:
         recipe_txt = recipe.text

         ctl_recipe.append(recipe_txt)

      else:
         ctl_recipe.append("Woops... We couldn't retrieve the exact recipe... It's trial & error time! Just a little more fun before enjoying a nice drink!") 




def get_video(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      video = soup.find('iframe')

      if video is not None:
         video_url = video['src']
         ctl_vid.append(video_url)

      else:
         ctl_vid.append("There doesn't seem to be an instructional video for this cocktail. Why not make the tutorial yourself!") 




def get_nutrition(url_list):

   for url in url_list:
      response = requests.get(url)
      soup = BeautifulSoup(response.content, 'html.parser')
      nutrition = soup.find('div', class_="wprm-nutrition-label-container wprm-nutrition-label-container-simple wprm-block-text-normal")

      if nutrition is not None:
         nutrition_txt = nutrition.text
         ctl_nutrition.append(nutrition_txt)

      else:
         ctl_nutrition.append("There doesn't seem to be any nutritional facts associated to this cocktail. But we know that's not why you're here...") 




