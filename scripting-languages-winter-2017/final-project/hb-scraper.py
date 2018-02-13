#!/usr/bin/env python3
# Witold Bobrowski ; Group 2

from bs4 import BeautifulSoup
import requests
import re
import sys

# Constants

TIER = "main-content-row dd-game-row js-nav-row"
TIER_HEADLINE = "dd-header-headline"
ELEMENT_CAPTION = "dd-image-box-caption-container"
ELEMENT_TITLE = "dd-image-box-caption"

class Price:
    def __init__(self, amount, currency):
        self.amount = amount
        self.currency = currency

class Tier:
    def __init__(self, books, price):
        self.books = books
        self.price = price

class Bundle:
    def __init__(self, title, url, tiers):
        self.title = title
        self.url = url
        self.tiers = tiers

def getBundle(url):
    content = getPageContent(url)
    title = getTitle(content)
    tiers = getTiers(content)
    return Bundle(title, url, tiers)

def getPageContent(url):
    page = requests.get(url)
    if page.status_code == 200:
        return BeautifulSoup(page.content, 'html.parser')

def getTitle(content):
    return content.title.get_text()

def getTiers(content):
    tiers = []
    for tier_content in content.find_all(class_ = TIER):
        price = getPrice(tier_content.find(class_ = TIER_HEADLINE))
        books = getElements(tier_content)
        tiers.append(Tier(books, price))
    return tiers

def getPrice(title_content):
    string = title_content.get_text().strip()
    return Price(re.search('\$(.+?)\ ', string).group(1), "$")

def getElements(tier_content):
    books = []
    for book_content in tier_content.find_all(class_ = ELEMENT_CAPTION):
        books.append(book_content.find(class_ = ELEMENT_TITLE).get_text().strip())
    return books

bundle = getBundle(sys.argv[1])

print(bundle.url)
print(bundle.title)

for tier in bundle.tiers:
    print(tier.price.currency + tier.price.amount);
    for book in tier.books:
        print(book, end = ", ")
    print("\n")
