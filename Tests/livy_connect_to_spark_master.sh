curl http://livy:8998/sessions
curl http://livy:8998/sessions/0
curl -X POST --data '{"kind": "pyspark"}' -H "Content-Type: application/json" http://livy:8998/sessions
curl http://livy:8998/sessions/0/statements -X POST -H 'Content-Type: application/json' -d '{"code":"1 + 1"}'
