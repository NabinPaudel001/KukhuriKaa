import os
import sys
import pickle
import joblib
import requests
import sklearn

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
    return prediction[0]

# Function to fetch news titles from API
def fetch_news_titles(api_url):
    response = requests.get(api_url)
    titles = []
    urls = []
    if response.status_code == 200:
        data = response.json()
        if 'results' in data:
            for source in data['results']:
                description = source.get('description', 'No description available')
                url = source.get('url', 'No URL available')
                titles.append((description, url))
        else:
            print("No sources found in the response.")
    else:
        print("Failed to fetch data, status code:", response.status_code)
    return titles

if __name__ == "__main__":
    # Define the base directory
    base_dir = os.path.dirname(os.path.abspath(__file__))

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
    news_data.append(("Further bird flu cases confirmed at farm", "https://www.bbc.com/news/articles/cwyxj2ke3n9o"))

    # Predict for each news title
    for title, url in news_data:
        prediction = predict(vectorizer, model, title)
        print(f"Title: {title}\nURL: {url}\nPrediction: {1 if prediction == 1 else 0}\n")
 