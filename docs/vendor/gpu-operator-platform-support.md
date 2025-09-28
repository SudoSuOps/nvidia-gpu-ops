# NVIDIA GPU Operator - Platform Support

Source: https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/platform-support.html

Platform Support — NVIDIA GPU Operator
Skip to main content
Back to top
Ctrl+K
NVIDIA GPU Operator
Choose version
Search
Ctrl+K
Search
Ctrl+K
NVIDIA GPU Operator
Choose version
Table of Contents
NVIDIA GPU Operator
About the Operator
Install
Upgrade
Uninstall
Platform Support
Release Notes
Troubleshooting
GPU Driver Upgrades
Using NVIDIA vGPU
NVIDIA AI Enterprise
Security Considerations
Advanced Operator Configuration
Multi-Instance GPU
Time-Slicing GPUs
GPUDirect RDMA and GPUDirect Storage
Outdated Kernels
Custom GPU Driver Parameters
Precompiled Driver Containers
GPU Driver CRD
Container Device Interface Support
Sandboxed Workloads
KubeVirt
Kata Containers
Confidential Containers and Kata
Specialized Networks
HTTP Proxy
Air-Gapped Network
Service Mesh
CSP configurations
Amazon EKS
Azure AKS
Google GKE
NVIDIA DRA Driver for GPUs
Introduction & Installation
GPUs
ComputeDomains
NVIDIA Docs Hub
Cloud Native Technologies
NVIDIA GPU Operator
Platform Support
Platform Support#
NVIDIA GPU Operator Versioning#
NVIDIA GPU Operator is versioned following the calendar versioning convention.
The version follows the pattern YY.MM.PP, such as 23.6.0, 23.6.1, and 23.9.0.
The first two fields, YY.MM identify a major version and indicates when the major version was initially released.
The third field, PP, identifies the patch version of the major version.
Patch releases typically include critical bug and CVE fixes, but can include minor features.
NVIDIA GPU Operator Life Cycle#
When a major version of NVIDIA GPU Operator is released, the previous major version enters maintenance support
and only receives patch release updates for critical bug and CVE fixes.
All prior major versions enter end-of-life (EOL) and are no longer supported and do not receive patch release updates.
The product life cycle and versioning are subject to change in the future.
Note
Upgrades are only supported within a major release or to the next major release.
Support Status for Releases#
GPU Operator Version
Status
25.3.x
Generally Available
24.9.x
Maintenance
24.6.x and lower
EOL
GPU Operator Component Matrix#
The following table shows the operands and default operand versions that correspond to a GPU Operator version.
When post-release testing confirms support for newer versions of operands, these updates are identified as recommended updates to a GPU Operator version.
Refer to Upgrading the NVIDIA GPU Operator for more information.
Component
Version
NVIDIA GPU Operator
v25.3.4
NVIDIA GPU Driver 1
580.82.07 (default, recommended)
580.65.06
575.57.08
570.172.08
570.158.01
570.148.08
535.261.03
550.163.01
535.247.01
NVIDIA Driver Manager for Kubernetes
v0.8.1
NVIDIA Container Toolkit
1.17.8
NVIDIA Kubernetes Device Plugin
0.17.4
DCGM Exporter
4.3.1-4.4.0
Node Feature Discovery
v0.17.3
NVIDIA GPU Feature Discovery
for Kubernetes
0.17.4
NVIDIA MIG Manager for Kubernetes
0.12.3
DCGM
4.3.1
Validator for NVIDIA GPU Operator
v25.3.4
NVIDIA KubeVirt GPU Device Plugin
v1.4.0
NVIDIA vGPU Device Manager
v0.4.0
NVIDIA GDS Driver 2
2.20.5
NVIDIA Kata Manager for Kubernetes
v0.2.3
NVIDIA Confidential Computing
Manager for Kubernetes
v0.1.1
NVIDIA GDRCopy Driver
v2.5.1
1
Known Issue: For drivers 570.124.06, 570.133.20, 570.148.08, and 570.158.01,
GPU workloads cannot be scheduled on nodes that have a mix of MIG slices and full GPUs.
This manifests as GPU pods getting stuck indefinitely in the Pending state.
NVIDIA recommends that you downgrade the driver to version 570.86.15 to work around this issue.
For more detailed information, see GitHub issue NVIDIA/gpu-operator#1361.
2
This release of the GDS driver requires that you use the NVIDIA Open GPU Kernel module driver for the GPUs.
Refer to GPUDirect RDMA and GPUDirect Storage for more information.
Note
Driver version could be different with NVIDIA vGPU, as it depends on the driver
version downloaded from the NVIDIA vGPU Software Portal.
The GPU Operator is supported on all active NVIDIA data center production drivers.
Refer to Supported Drivers and CUDA Toolkit Versions
for more information.
Supported NVIDIA Data Center GPUs and Systems#
The following NVIDIA data center GPUs are supported on x86 based platforms:
GH-series Products
Product
Architecture
NVIDIA GH200 1
NVIDIA Grace Hopper
1
NVIDIA GH200 systems require the NVIDIA Open GPU Kernel module driver.
You can install the open kernel modules by specifying the driver.useOpenKernelModules=true
argument to the helm command.
Refer to Common Chart Customization Options for more information.
A, H and L-series Products
Product
Architecture
NVIDIA H800
NVIDIA Hopper
NVIDIA H200,
NVIDIA H200 NVL
NVIDIA Hopper
NVIDIA DGX H100
NVIDIA Hopper and
NVSwitch
NVIDIA DGX H200
NVIDIA Hopper and
NVSwitch
NVIDIA HGX H100
NVIDIA Hopper and
NVSwitch
NVIDIA HGX H200
NVIDIA Hopper and
NVSwitch
NVIDIA H100,
NVIDIA H100 NVL
NVIDIA Hopper
NVIDIA H20
NVIDIA Hopper
NVIDIA L20
NVIDIA Ada
NVIDIA L40,
NVIDIA L40S
NVIDIA Ada
NVIDIA L4
NVIDIA Ada
NVIDIA DGX A100
A100 and NVSwitch
NVIDIA HGX A100
A100 and NVSwitch
NVIDIA A800
NVIDIA Ampere
NVIDIA A100
NVIDIA Ampere
NVIDIA A100X
NVIDIA Ampere
NVIDIA A40
NVIDIA Ampere
NVIDIA A30
NVIDIA Ampere
NVIDIA A30X
NVIDIA Ampere
NVIDIA A16
NVIDIA Ampere
NVIDIA A10
NVIDIA Ampere
NVIDIA A2
NVIDIA Ampere
Note
The GPU Operator supports DGX A100 with DGX OS 5.1+ and Red Hat OpenShift using Red Hat Core OS.
For installation instructions, see Pre-Installed NVIDIA GPU Drivers and NVIDIA Container Toolkit for DGX OS 5.1+ and Introduction to NVIDIA GPU Operator on OpenShift for Red Hat OpenShift.
D,T and V-series Products
Product
Architecture
NVIDIA T4
Turing
NVIDIA V100
Volta
NVIDIA P100
Pascal
NVIDIA P40
Pascal
NVIDIA P4
Pascal
RTX / T-series Products
Product
Architecture
NVIDIA RTX PRO 6000
Blackwell Server Edition
NVIDIA Blackwell
NVIDIA RTX PRO 6000D
NVIDIA Blackwell
NVIDIA RTX A6000
NVIDIA Ampere /Ada
NVIDIA RTX A5000
NVIDIA Ampere
NVIDIA RTX A4500
NVIDIA Ampere
NVIDIA RTX A4000
NVIDIA Ampere
NVIDIA Quadro RTX 8000
Turing
NVIDIA Quadro RTX 6000
Turing
NVIDIA Quadro RTX 5000
Turing
NVIDIA Quadro RTX 4000
Turing
NVIDIA T1000
Turing
NVIDIA T600
Turing
NVIDIA T400
Turing
Note
NVIDIA RTX PRO 6000 Blackwell Server Edition notes:
Driver versions 575.57.08 or later is required.
MIG is not supported on the 575.57.08 driver release.
You must disable High Memory Mode (HMM) in UVM by Customizing NVIDIA GPU Driver Parameters during Installation.
B-series Products
Product
Architecture
NVIDIA DGX B200
NVIDIA Blackwell
NVIDIA HGX B200
NVIDIA Blackwell
NVIDIA HGX GB200 NVL72
NVIDIA Blackwell
Note
HGX B200 requires a driver container version of 570.133.20 or later.
Supported ARM Based Platforms#
The following NVIDIA data center GPUs are supported:
Product
Architecture
NVIDIA A100X
Ampere
NVIDIA A30X
Ampere
NVIDIA IGX Orin
Ampere
AWS EC2 G5g instances
Turing
In addition to the products specified in the preceding table, any ARM based
system that meets the following requirements is supported:
NVIDIA GPUs connected to the PCI bus.
A supported operating system
such as Ubuntu or Red Hat Enterprise Linux.
Note
The GPU Operator only supports platforms using discrete GPUs.
NVIDIA Jetson, or other embedded products with integrated GPUs, are not supported.
NVIDIA IGX Orin, a platform with an integrated GPU, is supported as long as the discrete GPU is the device being used.
Supported Deployment Options#
The GPU Operator has been validated in the following scenarios:
Deployment Options
Bare Metal
Virtual machines with GPU Passthrough
Virtual machines with NVIDIA vGPU based products
Note
GPU Operator is supported with NVIDIA vGPU 12.0+.
Supported Operating Systems and Kubernetes Platforms#
The GPU Operator has been validated in the following scenarios:
Bare Metal / Virtual Machines with GPU Passthrough
Operating
System
Kubernetes 1
Red Hat
OpenShift
VMware vSphere
with Tanzu
Rancher Kubernetes
Engine 2
HPE Ezmeral
Runtime
Enterprise
Canonical
MicroK8s
Nutanix
NKP
Ubuntu 20.04 LTS 2
1.29â1.33
7.0 U3c, 8.0 U2, 8.0 U3
1.29â1.33
2.12, 2.13, 2.14
Ubuntu 22.04 LTS 2
1.29â1.33
8.0 U2, 8.0 U3
1.29â1.33
1.26
2.12, 2.13, 2.14, 2.15
Ubuntu 24.04 LTS
1.29â1.33
1.29â1.33
Red Hat Core OS
4.12â4.19
Red Hat
Enterprise
Linux 9.2, 9.4, 9.5, 9.6 3
1.29â1.33
1.29â1.33
Red Hat
Enterprise
Linux 8.8,
8.10
1.29â1.33
1.29â1.33
2.12, 2.13, 2.14, 2.15
1
The Kubernetes community only supports the last three minor releases.
Older releases may be supported through enterprise distributions of Kubernetes such as Red Hat OpenShift.
2
For Ubuntu 22.04 LTS, kernel versions 6.8 (non-precompiled driver containers only) 6.5 and 5.15 are LTS ESM kernels.
For Ubuntu 20.04 LTS, kernel versions 5.4 and 5.15 are LTS ESM kernels.
The GPU Driver containers support these Linux kernels.
Refer to the Kernel release schedule on Canonicalâs
Ubuntu kernel lifecycle and enablement stack page for more information.
NVIDIA recommends disabling automatic updates for the Linux kernel that are performed
by the unattended-upgrades package to prevent an upgrade to an unsupported kernel version.
3
Non-precompiled driver containers for Red Hat Enterprise Linux 9.2, 9.4, 9.5, and 9.6 versions are available for x86 based platforms only.
They are not available for ARM based systems.
Note
Red Hat OpenShift Container Platform is supported on AWS, Azure, GCP, and OCI (Oracle) Virtual Machine or Bare Metal instances with T4, V100, L4, L40s, A10, A100, H100, and H200.
Cloud Service Providers
Operating
System
Amazon EKS
Kubernetes
Google GKE
Kubernetes
Microsoft Azure
Kubernetes Service
Ubuntu 20.04 LTS
1.29â1.33
1.29â1.33
1.29â1.33
Ubuntu 22.04 LTS
1.29â1.33
1.29â1.33
1.29â1.33
Ubuntu 24.04 LTS
1.29â1.33
1.29â1.33
1.29â1.33
Virtual Machines with NVIDIA vGPU
Operating
System
Kubernetes
Red Hat
OpenShift
VMware vSphere
with Tanzu
Rancher Kubernetes
Engine 2
Nutanix
NKP
Ubuntu 20.04 LTS
1.29â1.33
7.0 U3c, 8.0 U2, 8.0 U3
1.29â1.33
2.12, 2.13
Ubuntu 22.04 LTS
1.29â1.33
8.0 U2, 8.0 U3
1.29â1.33
2.12, 2.13
Ubuntu 24.04 LTS
1.29â1.33
1.29â1.33
Red Hat Core OS
4.12â4.19
Red Hat
Enterprise
Linux 8.4,
8.6â8.10
1.29â1.33
1.29â1.33
Supported Precompiled Drivers#
The GPU Operator has been validated with the following precompiled drivers.
See the Precompiled Driver Containers page for more information about using precompiled drivers.
Operating System
Kernel Flavor
Kernel Version
CUDA Driver Branch
Ubuntu 22.04
Generic, NVIDIA, Azure
AWS, Oracle
5.15
R535, R570, R580
Ubuntu 22.04
Generic, NVIDIA, Azure
AWS, Oracle
6.8
R535, R570, R580
Ubuntu 24.04
Generic, NVIDIA, Azure
AWS, Oracle
6.8
R570, R580
Supported Container Runtimes#
The GPU Operator has been validated for the following container runtimes:
Operating System
Containerd 1.6 - 2.1
CRI-O
Ubuntu 20.04 LTS
Yes
Yes
Ubuntu 22.04 LTS
Yes
Yes
Ubuntu 24.04 LTS
Yes
Yes
Red Hat Core OS (RHCOS)
No
Yes
Red Hat Enterprise Linux 8
Yes
Yes
Red Hat Enterprise Linux 9
Yes
Yes
Support for KubeVirt and OpenShift Virtualization#
Red Hat OpenShift Virtualization is based on KubeVirt.
Operating System
Kubernetes
KubeVirt
OpenShift Virtualization
GPU
Passthrough
vGPU
GPU
Passthrough
vGPU
Ubuntu 20.04 LTS
1.23â1.33
0.36+
0.59.1+
Ubuntu 22.04 LTS
1.23â1.33
0.36+
0.59.1+
Red Hat Core OS
4.12â4.19
4.13â4.19
You can run GPU passthrough and NVIDIA vGPU in the same cluster as long as you use
a software version that meets both requirements.
NVIDIA vGPU is incompatible with KubeVirt v0.58.0, v0.58.1, and v0.59.0, as well
as OpenShift Virtualization 4.12.0â4.12.2.
Starting with KubeVirt v0.58.2 and v0.59.1, and OpenShift Virtualization 4.12.3 and 4.13,
you must set the DisableMDEVConfiguration feature gate.
Refer to GPU Operator with KubeVirt or NVIDIA GPU Operator with OpenShift Virtualization.
KubeVirt and OpenShift Virtualization with NVIDIA vGPU is supported on the following devices:
RTX Pro 6000 Blackwell Server Edition
H200NVL
H100
GA10x: A100, A40, RTX A6000, RTX A5500, RTX A5000, A30, A16, A10, A2.
The A10G and A10M GPUs are excluded.
AD10x: L40, RTX 6000 Ada, L4.
The L40G GPU is excluded.
Note that HGX platforms are not supported.
Note
KubeVirt with NVIDIA vGPU is supported on nodes with Linux kernel < 6.0, such as Ubuntu 22.04 LTS.
Support for GPUDirect RDMA#
Supported operating systems and NVIDIA GPU Drivers with GPUDirect RDMA.
RHEL 8 with Network Operator 25.1.0.
Ubuntu 24.04 LTS with Network Operator 25.1.0.
Ubuntu 20.04 and 22.04 LTS with Network Operator 24.10.0.
Red Hat Enterprise Linux 9.2, 9.4, 9.5, and 9.6 with Network Operator 25.1.0.
Red Hat OpenShift 4.12 and higher with Network Operator 23.10.0.
For information about configuring GPUDirect RDMA, refer to GPUDirect RDMA and GPUDirect Storage.
Support for GPUDirect Storage#
Supported operating systems and NVIDIA GPU Drivers with GPUDirect Storage.
Ubuntu 24.04 LTS Network Operator 25.1.0
Ubuntu 20.04 and 22.04 LTS with Network Operator 24.10.0
Red Hat OpenShift Container Platform 4.12 and higher
Note
Version v2.17.5 and higher of the NVIDIA GPUDirect Storage kernel driver, nvidia-fs,
requires the NVIDIA Open GPU Kernel module driver.
You can install the open kernel modules by specifying the driver.kernelModuleType=auto if you are using driver container version 570.86.15, 570.124.06 or later.
Or use driver.kernelModuleType=open if you are using a different driver version or branch.
argument to the helm command.
Refer to Common Chart Customization Options for more information.
Not supported with secure boot.
Supported storage types are local NVMe and remote NFS.
Additional Supported Container Management Tools#
Helm v3
Red Hat Operator Lifecycle Manager (OLM)
previous
Uninstalling the GPU Operator
next
Release Notes
On this page
NVIDIA GPU Operator Versioning
NVIDIA GPU Operator Life Cycle
GPU Operator Component Matrix
Supported NVIDIA Data Center GPUs and Systems
Supported ARM Based Platforms
Supported Deployment Options
Supported Operating Systems and Kubernetes Platforms
Supported Precompiled Drivers
Supported Container Runtimes
Support for KubeVirt and OpenShift Virtualization
Support for GPUDirect RDMA
Support for GPUDirect Storage
Additional Supported Container Management Tools
so the DOM is not blocked -->
Privacy Policy
|
Manage My Privacy
|
Do Not Sell or Share My Data
|
Terms of Service
|
Accessibility
|
Corporate Policies
|
Product Security
|
Contact
Copyright Â© 2020-2025, NVIDIA Corporation.