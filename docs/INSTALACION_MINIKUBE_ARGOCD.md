# Guía: Instalación de Minikube, ArgoCD y Cambio de Contraseña

## 1. Instalación de Minikube

### Requisitos previos
- Docker instalado
- kubectl instalado

### Pasos
```bash
# Instala Minikube (en macOS)
brew install minikube

# Inicia el clúster de Minikube
minikube start --profile=minikube-backstage

# Verifica el estado del clúster
kubectl get nodes
```

---

## 2. Instalación de ArgoCD en Minikube

### Crear el namespace para ArgoCD
```bash
kubectl create namespace argocd
```

### Instalar ArgoCD usando los manifiestos oficiales
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Verificar que los pods estén en estado Running
```bash
kubectl get pods -n argocd
```

### Exponer el servidor de ArgoCD localmente
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Accede a ArgoCD en tu navegador: http://localhost:8080

### Obtener la contraseña inicial de admin
```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode; echo
```

---

## 3. Cambiar la contraseña de admin en ArgoCD

### 1. Elige una nueva contraseña segura
Por ejemplo: NuevaPassword123

### 2. Cambia la contraseña ejecutando:
```bash
NUEVA_PASSWORD="NuevaPassword123"
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "'$(htpasswd -bnBC 10 "" Thomas#1109 | tr -d ':\n')'",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'
```

### 3. Reinicia el pod de ArgoCD server para aplicar el cambio
```bash
kubectl -n argocd delete pod -l app.kubernetes.io/name=argocd-server
```

Ahora puedes iniciar sesión en ArgoCD con usuario `admin` y la nueva contraseña.
