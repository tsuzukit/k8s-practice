docker build -t cinemania/multi-client:latest -t cinemania/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cinemania/multi-server:latest -t cinemania/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cinemania/multi-worker:latest -t cinemania/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cinemania/multi-client:latest
docker push cinemania/multi-server:latest
docker push cinemania/multi-worker:latest

docker push cinemania/multi-client:$SHA
docker push cinemania/multi-server:$SHA
docker push cinemania/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=cinemania/multi-client:$SHA
kubectl set image deployments/server-deployment server=cinemania/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cinemania/multi-worker:$SHA
