docker build -t amndl/multi-client:latest -t amndl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amndl/multi-server:latest -t amndl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amndl/multi-worker:latest -t amndl/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amndl/multi-client:latest
docker push amndl/multi-server:latest
docker push amndl/multi-worker:latest

docker push amndl/multi-client:$SHA
docker push amndl/multi-server:$SHA
docker push amndl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amndl/multi-server:$SHA
kubectl set image deployments/client-deployment client=amndl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amndl/multi-worker:$SHA