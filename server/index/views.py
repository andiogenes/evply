from django.shortcuts import render
import json
import redis
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseRedirect
 
@csrf_exempt
def index(request):
	if(request.method == 'POST'):
		received_json_data=json.loads(request.body)
		pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
		r = redis.Redis(connection_pool=pool)
		key = received_json_data.get('name')
		value = received_json_data.get('surname')
		r.set(key, value)
		return render(request, "index.html", context=received_json_data)
	
	else:
		pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
		r = redis.Redis(connection_pool=pool)
		for key in r.keys():
			print(key)
			print(r.get(key))
			print()
		header = "Денчик слазиет"
		data = {"header": header}
		return render(request, "index.html", context=data)