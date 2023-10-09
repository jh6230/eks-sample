# eks-sample

## Cluster
Create
```
eksctl create cluster --name sample-cluster --region ap-northeast-1 --fargate
```

Delete
```
eksctl delete cluster --name sample-cluster --region ap-northeast-1
```

Update kubeconfig
```
aws eks update-kubeconfig --region ap-northeast-1 --name sample-cluster
```

## kubectl
```
$ kubectl get nodes

$ kubectl get pods
```

## Load Balancer Controller

OIDC Install
```
$ export cluster_name=sample-cluster
$ eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve

```

IAMポリシー ダウンロード
```
$ curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
```

IAMポリシー作成
```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```

IAMロール作成
```
eksctl create iamserviceaccount \
  --cluster=sample-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::*********:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

```
$ helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=sample-cluster \
  --set serviceAccount.create=false \
  --set region=ap-northeast-1 \
  --set vpcId=vpc-0a28777638bbe515b \
  --set serviceAccount.name=aws-load-balancer-controller
```

```
eksctl create fargateprofile \
    --cluster sample-cluster \
    --region ap-northeast-1 \
    --name alb-sample-app \
    --namespace game-2048
```

## 参考資料
EKSのスタート
- https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/getting-started-eksctl.html

Load Balancer Controller
- https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/aws-load-balancer-controller.html

ALB
- https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/alb-ingress.html

Docker
- https://docs.aws.amazon.com/ja_jp/eks/latest/userguide/copy-image-to-repository.html
