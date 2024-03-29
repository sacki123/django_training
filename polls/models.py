from django.db import models

# Create your models here.
class question(models.Model):
    question_text = models.CharField(max_length = 200)
    time_pub = models.DateTimeField()
    def __str__(self):
        return self.question_text
class choice(models.Model): 
    question = models.ForeignKey(question, on_delete = models.CASCADE)
    choice_text = models.CharField(max_length = 100)
    vote = models.IntegerField(default=0)
    def __str__(self):
        return self.choice_text
class Blog(models.Model):
    name =  models.CharField(max_length=100)
    tagline = models.TextField()

    def __str__(self):
        return self.name
class Author(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()

    def __str__(self):
        return self.name
class Entry(models.Model):
    blog = models.ForeignKey(Blog, on_delete = models.CASCADE)
    headline = models.CharField(max_length=255)
    body_text = models.TextField()
    pub_date = models.DateField()
    mod_date = models.DateField()
    authors = models.ManyToManyField(Author)  
    n_comments = models.IntegerField()
    n_pingbacks = models.IntegerField()
    rating = models.IntegerField()

    def __str__(self):
        return self.headline

         
            
            