docker build -t sjmaddenhart/multi-client:latest -t sjmaddenhart/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sjmaddenhart/multi-server:latest -t sjmaddenhart/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sjmaddenhart/multi-worker:latest -t sjmaddenhart/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sjmaddenhart/multi-client:latest
docker push sjmaddenhart/multi-server:latest
docker push sjmaddenhart/multi-worker:latest

docker push sjmaddenhart/multi-client:$SHA
docker push sjmaddenhart/multi-server:$SHA
docker push sjmaddenhart/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sjmaddenhart/multi-server:$SHA
kubectl set image deployments/client-deployment client=sjmaddenhart/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sjmaddenhart/multi-worker:$SHA
