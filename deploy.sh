docker build -t amndl/multi-client -f ./client/Dockerfile ./client
docker build -t amndl/multi-server -f ./server/Dockerfile ./server
docker build -t amndl/multi-worker -f ./worker/Dockerfile ./worker
docker push amndl/multi-client
docker push amndl/multi-server
docker push amndl/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amndl/multi-server