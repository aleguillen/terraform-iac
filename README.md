# Infrastructure as Code (IaC)

Infrastructure as code (IaC) uses DevOps methodology and versioning with a descriptive model to define and deploy infrastructure, such as networks, virtual machines, load balancers, and connection topologies. Just as the same source code always generates the same binary, an IaC model generates the same environment every time it deploys.

IaC evolved to solve the problem of environment drift in release pipelines. Without IaC, teams must maintain deployment environment settings individually. Over time, each environment becomes a "snowflake," a unique configuration that can't be reproduced automatically. Inconsistency among environments can cause deployment issues. Infrastructure administration and maintenance involve manual processes that are error prone and hard to track.

## Use declarative definition files

IaC should use declarative definition files if possible. A definition file describes the **components and configuration that an environment requires**, but not necessarily how to achieve that configuration. For example, the file might define a required server version and configuration, but not specify the server installation and configuration process. This abstraction allows for greater flexibility to use optimized techniques the infrastructure provider supplies. Declarative definitions also help reduce the technical debt of maintaining imperative code, such as deployment scripts, that can accrue over time.

There's no standard syntax for declarative IaC. The syntax for describing IaC usually depends on the requirements of the target platform. Different platforms support file formats such as YAML, JSON, and XML.

![](/.img/IaC.png)

## Why Insfrastructure as Code?

![](https://pics.freeicons.io/uploads/icons/png/13270834371639572784-512.png){:height="15px" width="15px"} Remove the human element and reliably and repeatable deploy every time. Avoid configuration drift.



## Deploy IaC on Azure
Azure provides native support for IaC via the Azure Resource Manager model. Teams can define declarative ARM templates that specify the infrastructure required to deploy solutions.

Third-party platforms like Terraform, Ansible, Chef, and Pulumi also support IaC to manage automated infrastructure.


# Terraform by Hashicorp - IaC tool

https://www.terraform.io/intro

# How to Provision Infrastructure with Terraform

# Terraform Commands List

| Command | Description |
| --- | --- |
| terraform init |  |
| terraform plan |  |
| terraform apply |  |