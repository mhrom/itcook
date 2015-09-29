# Register your models here.

from django.contrib import admin
from django import forms
from ckeditor.widgets import CKEditorWidget
from pagedown.widgets import AdminPagedownWidget
from articles.models import Category, Article

class ArticleForm(forms.ModelForm):
    content = forms.CharField(widget=CKEditorWidget())
    class Meta:
        model = Article
        widgets = {
            'content_markdown' : AdminPagedownWidget(),
        }
        exclude = ['content_markup',]


class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',)}
    list_display = ('title', )
    search_fields = ('title', )
    fieldsets = ((None,{'fields': ('title', 'slug',)}),)

class ArticleAdmin(admin.ModelAdmin):
    form = ArticleForm
    prepopulated_fields = {'slug': ('title',)}
    list_display = ('title', 'date_publish')
    search_fields = ('title', 'content_markdown',)
    list_filter = ('categories',)
    fieldsets = ((None,{'fields': ('title', 'slug', 'content_markdown', 'categories', 'date_publish',)}),)

admin.site.register(Category, CategoryAdmin)
admin.site.register(Article, ArticleAdmin)