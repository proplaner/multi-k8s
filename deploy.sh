docker build -t proplaner/multi-client-k8s:latest -t proplaner/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t proplaner/multi-server-k8s-pgfix:latest -t proplaner/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t proplaner/multi-worker-k8s:latest -t proplaner/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push proplaner/multi-client-k8s:latest
docker push proplaner/multi-server-k8s-pgfix:latest
docker push proplaner/multi-worker-k8s:latest

docker push proplaner/multi-client-k8s:$SHA
docker push proplaner/multi-server-k8s-pgfix:$SHA
docker push proplaner/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=proplaner/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=proplaner/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=proplaner/multi-worker-k8s:$SHA