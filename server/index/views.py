from django.shortcuts import render
import json
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseRedirect
 
@csrf_exempt
def index(request):
	if(request.method == 'POST'):
		received_json_data=json.loads(request.body)
		print(received_json_data)
		return render(request, "index.html", context=received_json_data)
	
	else:
		header = "Денчик слазиет"                    			# обычная переменная
		data = {"header": header}
		return render(request, "index.html", context=data)