//Viewer, Developer
# Генерируем приватный ключ
openssl genrsa -out users/viewer_user.key 2048
openssl genrsa -out users/developer_user.key 2048

# Создаем запрос на подпись сертификата (CSR)
#git-bash
openssl req -new -key users/viewer_user.key -out users/viewer_user.csr -subj "//CN=viewer_user\O=viewers"
openssl req -new -key users/developer_user.key -out users/developer_user.csr -subj "//CN=developer_user\O=developers"

# Подписываем сертификат с помощью CA Minikube
openssl x509 -req -in users/viewer_user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out users/viewer_user.crt -days 365
openssl x509 -req -in users/developer_user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out users/developer_user.crt -days 365

# Устанавлием конфигурационный файл
kubectl config set-credentials users/viewer_user --client-certificate=viewer_user.crt --client-key=viewer_user.key
kubectl config set-credentials users/developer_user --client-certificate=developer_user.crt --client-key=developer_user.key

# Создаем контекст для пользователя
kubectl config set-context viewer_user-context --cluster=minikube --namespace=default --user=viewer_user
kubectl config set-context developer_user-context --cluster=minikube --namespace=default --user=developer_user

# Переключаемся на контекст пользователя
kubectl config use-context viewer_user-context
kubectl config use-context developer_user-context