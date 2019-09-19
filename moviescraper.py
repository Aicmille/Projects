from bs4 import BeautifulSoup
import requests

source = requests.get('https://www.amctheatres.com/movie-theatres/bloomington-in/amc-classic-bloomington-12').text
soup = BeautifulSoup(source, 'lxml')


for movie in soup.find_all("div", class_="slick-slide"):
    title = movie.h3.text
    length = movie.find("span", class_="u-separator js-runtimeConvert u-inlineFlexCenter").text
    date = movie.find("span", class_="MoviePosters__released-month clearfix").text

    print(title)
    print(length)
    print(date)
