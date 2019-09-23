from django.db import models

# Create your models here.
class question(models.Model):
    question_text = models.CharField(max_length = 200)
    time_pub = models.DateTimeField()
    def __str__(self):
        return self.question_text, self.time_pub
class choice(models.Model): 
    question = models.ForeignKey(question, on_delete = models.CASCADE)
    choice_text = models.CharField(max_length = 100)
    vote = models.IntegerField(default=0)