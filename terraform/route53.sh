#!/bin/bash

# terraform init
# terraform apply -auto-approve

# # Congifure kubectl to work with created cluster
aws eks update-kubeconfig --region us-east-1 --name formapp-cluster

# # Initial password
echo "$(kubectl get -n argocd secret/argocd-initial-admin-secret -o=jsonpath='{.data.password}' | base64 -d)"

# Update record in aws hosted zone #
# get the dns name of elb
elb_dns_name=""
while [[ ! "$elb_dns_name" =~ \.elb\. ]]; do
  elb_dns_name=$(kubectl get ingress/nginx-ingress -n app -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  sleep 2
done

#get ingerss of argocd
argocd_ingress=""
while [[ ! "$argocd_ingress" =~ \.elb\. ]]; do
  argocd_ingress=$(kubectl get ingress/argocd-ingress -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  sleep 2
done


# Create records in JSON format
cat > record.json <<EOF
{
  "Comment": "Update records",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "formapp.sbendarsky.me",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z35SXDOTRQ7X7K",
          "DNSName": "dualstack.${elb_dns_name}",
          "EvaluateTargetHealth": true
        }
      }
    },
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "argocd.sbendarsky.me",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z35SXDOTRQ7X7K", 
          "DNSName": "dualstack.${argocd_ingress}",
          "EvaluateTargetHealth": true
        }
      }
    }
  ]
}
EOF

# update record in aws route 53
aws route53 change-resource-record-sets --hosted-zone-id Z0812785FWYP51NI40L5 --change-batch file://record.json