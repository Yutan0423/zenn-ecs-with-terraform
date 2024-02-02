# punch-industry-order infrastructure

## introduction

`【Terraform】ECS×ALBで冗長化&負荷分散されたAPIのインフラ環境を構築する`の実際のインフラコードになります。

## 作成手順

1. `iac/api`内で、`terraform init`で初期化
2. `iac/api`内で、`terraform apply`でインフラ構築
3. `iac/api`内で、`terraform destroy`でインフラ削除

※ 複数人で作業を行う場合は、状態管理を統一させるためにリモートバックエンドを利用してください

## 注意点

- 利用しない場合や、ディレクトリレベルの大きな変更がある場合は、`terraform destroy`で環境を一旦削除してから行うようにしてください