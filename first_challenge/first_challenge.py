import requests
import pandas as pd
import json
import matplotlib.pyplot as plt

# point 1: get the data
urlData = requests.get("https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=perl&site=stackoverflow").content
data = json.loads(urlData)
items = pd.DataFrame(data['items'])
items['creation_date'] = pd.to_datetime(items['creation_date'],unit='s') # Change the format of the creation date

# Point 2: catalog each item about the boolean value of 'is answered'
data_answered = []
data_notAnswered = []
for item in data['items']:
    if item['is_answered'] == True:
        data_answered.append(item)
    else: data_notAnswered.append(item)
print("El número de respuestas contestadas es ", len(data_answered))
print("El número de respuestas no contestadas es ", len(data_notAnswered))
plt.pie([len(data_answered),len(data_notAnswered)], labels= ['contestadas\n'+str(len(data_answered)),'no contestadas\n'+str(len(data_notAnswered))], shadow = True)
plt.show()

# Point 3: get the response with lower view count
byViews = items.sort_values('view_count')
print("\n\nElemento con menor número de vistas:\n",byViews.iloc[0])

# Point 4: get the oldest and newest response
byCreationDate = items.sort_values('creation_date')
print("\n\nElemento de la respuesta que es más antigua:\n",byCreationDate.iloc[0])
print("\n\nElemento de la respuesta más reciente:\n",byCreationDate.iloc[-1])

# Point 5: get the response of the user with more reputation
rep = 0
for owner in items['owner']:
    if owner['reputation'] > rep: 
        rep = owner['reputation']
        bestOwner = owner
resBestOwner = 0
print("\n\nRespuesta del usuario con mayor reputación:\n",items.loc[items['owner'] == bestOwner].T)
