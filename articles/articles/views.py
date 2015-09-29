#!/usr/bin/python -tt
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render, get_object_or_404
from articles.models import Category, Article
import calendar, datetime



# Create your views here.
def home (request):
    page = request.GET.get('page')
    article_queryset = Article.objects.all()
    archive_dates = Article.objects.dates('date_publish','month', order='DESC')
    categories = Category.objects.all()
    paginator = Paginator(article_queryset, 5)
    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)
    return render(request, "home.html",{ "articles" : articles, "archive_dates" : archive_dates, "categories" : categories },)

def tools (request):
    return render(request, "tools.html")

def index(request):
    """The news index"""
    archive_dates = Article.objects.dates('date_publish','month', order='DESC')
    categories = Category.objects.all()
    page = request.GET.get('page')
    article_queryset = Article.objects.all()
    paginator = Paginator(article_queryset, 5)

    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)
    return render(
            request,
            "index.html",
            {
                "articles" : articles,
                "archive_dates" : archive_dates,
                "categories" : categories
            }
            )

def single(request, slug) :
    """A single article"""
    article = get_object_or_404(Article, slug=slug)
    archive_dates = Article.objects.dates('date_publish','month', order='DESC')
    categories = Category.objects.all()

    return render( request, "single.html", { "article" : article, "archive_dates" : archive_dates, "categories" : categories } )


def date_archive(request, year, month) :
    """The blog date archive"""
    # this archive pages dates
    year = int(year)
    month = int(month)
    month_range = calendar.monthrange(year, month)
    start = datetime.datetime(year=year, month=month, day=1)#.replace(tzinfo=utc)
    end = datetime.datetime(year=year, month=month, day=month_range[1])#.replace(tzinfo=utc)
    archive_dates = Article.objects.dates('date_publish','month', order='DESC')
    categories = Category.objects.all()

    # Pagination
    page = request.GET.get('page')
    article_queryset = Article.objects.filter(date_publish__range=(start.date(), end.date()))
    paginator = Paginator(article_queryset, 5)

    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)

    return render(
        request,
        "date_archive.html",
        {
            "start" : start,
            "end" : end,
            "articles" : articles,
            "archive_dates" : archive_dates,
            "categories" : categories
        }
    )

def category_archive(request, slug):
    archive_dates = Article.objects.dates('date_publish','month', order='DESC')
    categories = Category.objects.all()
    category = get_object_or_404(Category, slug=slug)

    # Pagination
    page = request.GET.get('page')
    article_queryset = Article.objects.filter(categories=category)
    paginator = Paginator(article_queryset, 5)

    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)
    return render(
        request,
        "category_archive.html",
        {
            "articles" : articles,
            "archive_dates" : archive_dates,
            "categories" : categories,
            "category" : category
        }
    )