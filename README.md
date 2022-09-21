# Infrastructure as Code (IaC)

Infrastructure as code (IaC) uses DevOps methodology and versioning with a descriptive model to define and deploy infrastructure, such as networks, virtual machines, load balancers, and connection topologies. Just as the same source code always generates the same binary, an IaC model generates the same environment every time it deploys.

IaC evolved to solve the problem of environment drift in release pipelines. Without IaC, teams must maintain deployment environment settings individually. Over time, each environment becomes a "snowflake," a unique configuration that can't be reproduced automatically. Inconsistency among environments can cause deployment issues. Infrastructure administration and maintenance involve manual processes that are error prone and hard to track.

> IaC allows you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.

## Use declarative definition files

IaC should use declarative definition files if possible. A definition file describes the **components and configuration that an environment requires**, but not necessarily how to achieve that configuration. For example, the file might define a required server version and configuration, but not specify the server installation and configuration process. This abstraction allows for greater flexibility to use optimized techniques the infrastructure provider supplies. Declarative definitions also help reduce the technical debt of maintaining imperative code, such as deployment scripts, that can accrue over time.

There's no standard syntax for declarative IaC. The syntax for describing IaC usually depends on the requirements of the target platform. Different platforms support file formats such as YAML, JSON, and XML.

![](/.img/IaC.png)

## Why Insfrastructure as Code?

- Stand up environments in the fastest means possible. Teams can provision multiple test environments reliably on demand.
- Avoid configuration drift. Remove the human element and reliably and repeatable deploy every time. 
- Improve environment visibility and improve developer efficiency.
- Store your infrastructure definitions alongside with your application code. Use Version Control Systems (VCSs) like GitHub, Azure DevOps, and others.

## Deploy IaC on Azure
Azure provides native support for IaC via the Azure Resource Manager model. Teams can define declarative ARM templates that specify the infrastructure required to deploy solutions.

Third-party platforms like **Terraform**, Ansible, Chef, and Pulumi also support IaC to manage automated infrastructure.


# Terraform
![](https://learn.hashicorp.com/_next/static/images/color-2760d41bea9a4203553d88a51fa1800c.svg)

Terraform is HashiCorp's infrastructure as code tool. It lets you define resources and infrastructure in human-readable, declarative configuration files, and manages your infrastructure's lifecycle. Using Terraform has several advantages over manually managing your infrastructure:

- Terraform can manage infrastructure on multiple cloud platforms.
- The human-readable configuration language helps you write infrastructure code quickly.
- Terraform's state allows you to track resource changes throughout your deployments.
- You can commit your configurations to version control to safely collaborate on infrastructure.

## Manage any infrastructure
Terraform plugins called providers let Terraform interact with cloud platforms and other services via their application programming interfaces (APIs). HashiCorp and the Terraform community have written over 1,000 providers to manage resources on Azure, Amazon Web Services (AWS), Google Cloud Platform (GCP), Kubernetes, Helm, GitHub, Azure DevOps, and many others. Find providers for many of the platforms and services you already use in the [Terraform Registry](https://registry.terraform.io/browse/providers). If you don't find the provider you're looking for, you can write your own.

Providers define individual units of infrastructure, for example compute instances or private networks, as resources. You can compose resources from different providers into reusable Terraform configurations called modules, and manage them with a consistent language and workflow.

Terraform's configuration language is declarative, meaning that it describes the desired end-state for your infrastructure, in contrast to procedural programming languages that require step-by-step instructions to perform tasks. Terraform providers automatically calculate dependencies between resources to create or destroy them in the correct order.

To deploy infrastructure with Terraform:

- **Scope** - Identify the infrastructure for your project.
- **Author** - Write the configuration for your infrastructure.
- **Initialize** - Install the plugins Terraform needs to manage the infrastructure.
- **Plan** - Preview the changes Terraform will make to match your configuration.
- **Apply** - Make the planned changes.

Terraform keeps track of your real infrastructure in a **state file**, which **acts as a source of truth** for your environment. Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.

> **_NOTE:_** To learn how to install Terraform see [here](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started#install-terraform).

https://www.terraform.io/intro

# How to Provision Infrastructure with Terraform



# Terraform Commands List

| Command | Description |
| --- | --- |
| terraform init |  |
| terraform plan |  |
| terraform apply |  |