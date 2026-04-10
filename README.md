```md
![AWS](https://img.shields.io/badge/AWS-Security-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple)
![Docker](https://img.shields.io/badge/Container-Docker-blue)
![Status](https://img.shields.io/badge/Status-Lab-green)
```


# AWS Cognito + ECS Authentication Lab

Laboratório prático para estudo de autenticação segura em microsserviços na AWS utilizando **Amazon Cognito**, **Amazon ECS Fargate**, **API Gateway** e **IAM Roles**, baseado em cenários típicos do exame **AWS Certified Security – Specialty**.

---

## Objetivo

Demonstrar uma arquitetura moderna de autenticação/autorização para aplicações web com usuários externos consumindo múltiplos microsserviços hospedados no Amazon ECS, utilizando:

* **Amazon Cognito User Pools** para autenticação de usuários
* **Amazon Cognito App Clients** para integração com aplicações web
* **Amazon API Gateway JWT Authorizer** para validação de tokens
* **IAM Task Roles** para credenciais temporárias por microsserviço
* **Amazon ECS Fargate** para execução dos containers

---

## Arquitetura

```text
User
 |
 | Login / JWT
 v
Amazon Cognito
 |
 | Bearer Token
 v
API Gateway HTTP API
 |
 | JWT Authorizer
 v
Application Load Balancer
 |
 v
Amazon ECS Fargate
 |
 v
Microservice Container
```

---

## Estrutura do Projeto

```text
.
├── app/
│   ├── app.py
│   └── Dockerfile
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── variables.tf
└── versions.tf
```

---

## O que é provisionado via Terraform

* VPC
* Subnets Públicas
* Internet Gateway
* Route Tables
* Security Groups
* Amazon ECR Repository
* IAM Execution Role
* IAM Task Role
* ECS Cluster
* ECS Task Definition
* ECS Service (Fargate)
* Application Load Balancer
* Target Group
* Listener HTTP
* CloudWatch Log Group

---

## Configuração Manual (Hands-On AWS Console)

Os recursos abaixo devem ser configurados manualmente para fins didáticos:

1. Amazon Cognito User Pool
2. Amazon Cognito App Client
3. Usuário de teste no Cognito
4. API Gateway HTTP API
5. JWT Authorizer
6. Proteção da rota `/private`

---

## Como Executar

### 1. Provisionar infraestrutura

```bash
terraform init
terraform apply
```

---

### 2. Build e Push da imagem Docker

```bash
docker build -t cognito-lab ./app

docker tag cognito-lab:latest <ECR_REPO>:latest

docker push <ECR_REPO>:latest
```

---

### 3. Forçar novo deployment ECS

```bash
aws ecs update-service \
  --cluster cognito-ecs-lab-cluster \
  --service cognito-ecs-lab-service \
  --force-new-deployment
```

---

## Endpoints Disponíveis

| Endpoint | Descrição          | Proteção |
| -------- | ------------------ | -------- |
| /health  | Health Check       | Pública  |
| /public  | Endpoint público   | Pública  |
| /private | Endpoint protegido | JWT      |

---

## Conceitos Demonstrados

### Autenticação

* User Pool Authentication
* OAuth / OpenID Connect
* JWT Token Issuance

### Autorização

* JWT Validation via API Gateway
* IAM Roles per Service

### Segurança de Infraestrutura

* Least Privilege IAM
* Temporary Credentials
* Network Segmentation
* Public/Private Endpoint Separation

---

## Casos de Uso Relacionados ao Exame AWS Security Specialty

Este laboratório ajuda a praticar tópicos como:

* Authentication and Authorization Mechanisms
* Temporary Credentials Strategy
* Cognito vs IAM Identity Center
* API Gateway Authorizers
* ECS Task Roles
* Secure Microservice Architecture

---

## Segurança Implementada

| Categoria                 | Controle                                     |
| ------------------------- | -------------------------------------------- |
| A - Segurança Básica      | Cognito User Pools                           |
| A - Segurança Básica      | JWT Validation                               |
| A - Segurança Básica      | IAM Task Roles                               |
| B - Segurança Recomendada | Least Privilege per Microservice             |
| B - Segurança Recomendada | API Gateway Front Door                       |
| C - Segurança Opcional    | WAF / mTLS / Service Mesh (não implementado) |

---

## Futuras Melhorias

* Adicionar HTTPS/ACM
* Adicionar AWS WAF
* Implementar múltiplos microsserviços
* Adicionar autorização por Claims/Scopes
* Integrar com IdP externo via Federation
* Adicionar Terraform para Cognito/API Gateway (opcional)

---

## Observações

Este projeto foi desenvolvido com foco educacional e para prática de conceitos de arquitetura segura na AWS.
Não é destinado para uso direto em produção sem hardening adicional.

---





