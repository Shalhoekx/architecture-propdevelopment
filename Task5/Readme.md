## 1. Запуск Minikube

```bash
minikube start
```

### Создадим поды
```bash
kubectl config use-context minikube

kubectl run front-end-app --image=nginx --labels role=front-end --expose --port 80

kubectl run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80

kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80

kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80
```

### Применить сетевую политику
```bash
    kubectl apply -f non-admin-api-allow.yaml
```

### Проверить трафик
```bash
        kubectl run test-1 --rm -i -t --image=alpine -- sh # wget -qO- --timeout=2 http://front-end-app
    / # wget -qO- --timeout=2 http://front-end-app
    / # wget -qO- --timeout=2 http://back-end-api-app
    / # wget -qO- --timeout=2 http://admin-front-end-app
    / # wget -qO- --timeout=2 http://admin-back-end-api-app
```