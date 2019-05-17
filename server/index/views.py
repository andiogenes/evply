from django.shortcuts import render
 
def index(request):
    header = "Денчик слазиет"                    # обычная переменная
    data = {"header": header}
    return render(request, "index.html", context=data)