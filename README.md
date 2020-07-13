# SPA frontend for Kubernetes with configmaps

## Build docker image
```
docker build -t sample-container .
```

### Run docker image
```
docker run -it -e HOST=yourhost -e API=/api -p 8080:80 --rm sample-container:latest
```

### Deployment for kubernetes
```
apiVersion: "extensions/v1beta1"
kind: "Deployment"
metadata:
  labels:
    app.kubernetes.io/name: "demo-vue-kubernetes"
    app.kubernetes.io/instance: "demo-vue-kubernetes"
    app.kubernetes.io/version: "$VERSION"
  name: "demo-vue-kubernetes"
spec:
  replicas: 2
  ...
  template:
    metadata:
      labels:
        app.kubernetes.io/name: "demo-vue-kubernetes"
        app.kubernetes.io/instance: "demo-vue-kubernetes"
    spec:
      containers:
        - name: "demo-vue-kubernetes"
          image: "${IMAGE}:${VERSION}"
          env:
            - name: "HOST"
              value: "yourhost"
            - name: "API"
              value: "/api"
```

### How to use in your SPA project

The next step would be to refer this file in the index.html to make it available at application loading. So, in the index.html the following line is added:

```
<html lang="en">
  <head>
    <script type="text/javascript" src="%PUBLIC_URL%/config.js"></script>
    ...
  </head>
  <body>
    <div id="root"></div>
    ...
  </body>
</html>
```

