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

## kubectl
```
$ kubectl get nodes

$ kubectl get pods
```

## Load Balancer Controller

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
  --set vpcId=vpc-05e5fc8ac94806095 \
  --set serviceAccount.name=aws-load-balancer-controller
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
