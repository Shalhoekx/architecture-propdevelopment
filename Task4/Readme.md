## 1. Запуск Minikube

```bash
minikube start
```

### Перейдём в папку задания (если консоль не оттуда - ошибок на сертификат не будет, пока не попробуем под контекстом зайти)
```bash
cd Task4
```

```bash
kubectl config set-credentials viewer_user --client-certificate=./users/viewer_user.crt --client-key=./users/viewer_user.key
```

```bash
kubectl config set-credentials developer_user --client-certificate=./users/developer_user.crt --client-key=./users/developer_user.key
```

### Добавить контекст viewer_user-context:
```bash
kubectl config set-context viewer_user-context --cluster=minikube --namespace=default --user=viewer_user
```

### Добавить контекст developer_user-context:
```bash
kubectl config set-context developer_user-context --cluster=minikube --namespace=default --user=developer_user
```

### Переключиться на контекст viewer_user-context:
```bash
kubectl config use-context viewer_user-context
kubectl get pods
```

## 3. Запуск yaml с ролями и байндингом

```bash
kubectl config use-context minikube
kubectl apply -f roles.yaml
kubectl apply -f bindings.yaml
```

### Подключение от имени пользователя
```bash
kubectl config set-context viewer_user-context --cluster=minikube --user=viewer_user
kubectl config set-context developer_user-context --cluster=minikube --user=developer_user
# Переключение на контекст viewer_user-context
kubectl config use-context viewer_user-context
kubectl get pods
```