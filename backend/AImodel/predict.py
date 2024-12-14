import os
import sys
import pickle
import joblib
import requests
import json

# Function to load vectorizer
def load_vectorizer(vectorizer_path):
    with open(vectorizer_path, 'rb') as file:
        vectorizer = joblib.load(file)
    return vectorizer

# Function to load model
def load_model(model_path):
    with open(model_path, 'rb') as file:
        model = pickle.load(file)
    return model

# Function to predict using the model
def predict(vectorizer, model, text):
    text_transformed = vectorizer.transform([text])
    prediction = model.predict(text_transformed)
    return int(prediction[0])  # Ensure integer output

# Function to fetch news titles from API
def fetch_news_titles(api_url):
    response = requests.get(api_url)
    news_data = []
    if response.status_code == 200:
        data = response.json()
        if 'results' in data:
            for source in data['results']:
                description = source.get('description', 'No description available')
                url = source.get('url', 'No URL available')
                news_data.append({'description': description, 'url': url})
        else:
            print("No sources found in the response.")
    else:
        print("Failed to fetch data, status code:", response.status_code)
    return news_data

if _name_ == "_main_":
    # Define the base directory
    base_dir = os.path.dirname(os.path.abspath(_file_))

    # Update the paths to be absolute
    vectorizer_path = os.path.join(base_dir, 'count_vectorizer.pkl')
    model_path = os.path.join(base_dir, 'model.pkl')

    # API URL to fetch news titles
    api_url = "https://newsdata.io/api/1/sources?country=np&apikey=pub_62266aba0643a6bf2b5c2df1f89b66249cd53"

    # Load vectorizer and model
    vectorizer = load_vectorizer(vectorizer_path)
    model = load_model(model_path)

    # Fetch news titles
    news_data = fetch_news_titles(api_url)
    news_data.append({"description": "Further bird flu cases confirmed at farm", 
                      "url": "https://www.bbc.com/news/articles/cwyxj2ke3n9o"})
    news_data.append({
    "description": "10 Chicken Breeds for Your Farm", 
    "url": "https://www.agriculture.com/livestock/poultry/10-chicken-breeds-for-your-farm"
})

    # Predict for each news title
    output = []
    for item in news_data:
        description = item['description']
        url = item['url']
        prediction = predict(vectorizer, model, description) if description != 'No description available' else None
        output.append({"title": description, "url": url, "prediction": prediction})

    # Save to a JSON file
    output_path = os.path.join(base_dir, 'news_predictions.json')
    with open(output_path, 'w') as json_file:
        json.dump(output, json_file, indent=4)

    print(f"Data saved to {output_path}")