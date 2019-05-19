from django.shortcuts import render
import json
import redis
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseRedirect
from django.http import HttpResponse
 
def index(request):
	pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
	r = redis.Redis(connection_pool=pool)
	sended_json_data = { 'keys' : r.keys() }
	print("index")
	header = "Денчик слазиет"
	data = {"header": header}
	return render(request, "index.html", context=data)

@csrf_exempt
def save(request):
	received_json_data=json.loads(request.body)
	pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
	r = redis.Redis(connection_pool=pool)
	key = received_json_data.get('name')
	value = received_json_data.get('data')
	r.set(key, value)
	return HttpResponse("")

@csrf_exempt
def load(request, fileName):
	pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
	r = redis.Redis(connection_pool=pool)
	print(fileName)
	data = r.get(fileName)
	res = {"header": data}
	return render(request, "index.html", context=res)

@csrf_exempt	
def list(request):
	pool = redis.ConnectionPool(host='localhost', port=6379, db=0)
	r = redis.Redis(connection_pool=pool)
	data = r.keys()
	res = {"header": data}
	return render(request, "index.html", context=res)