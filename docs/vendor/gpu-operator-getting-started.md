# NVIDIA GPU Operator - Getting Started

Source: https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html

Installing the NVIDIA GPU Operator — NVIDIA GPU Operator
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
Installing the NVIDIA GPU Operator
Installing the NVIDIA GPU Operator#
Prerequisites#
You have the kubectl and helm CLIs available on a client machine.
You can run the following commands to install the Helm CLI:
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
&& chmod 700 get_helm.sh \
&& ./get_helm.sh
All worker nodes or node groups to run GPU workloads in the Kubernetes cluster must run the same operating system version to use the NVIDIA GPU Driver container.
Alternatively, if you pre-install the NVIDIA GPU Driver on the nodes, then you can run different operating systems.
For worker nodes or node groups that run CPU workloads only, the nodes can run any operating system because
the GPU Operator does not perform any configuration or management of nodes for CPU-only workloads.
Nodes must be configured with a container engine such CRI-O or containerd.
If your cluster uses Pod Security Admission (PSA) to restrict the behavior of pods,
label the namespace for the Operator to set the enforcement policy to privileged:
$ kubectl create ns gpu-operator
$ kubectl label --overwrite ns gpu-operator pod-security.kubernetes.io/enforce=privileged
Node Feature Discovery (NFD) is a dependency for the Operator on each node.
By default, NFD master and worker are automatically deployed by the Operator.
If NFD is already running in the cluster, then you must disable deploying NFD when you install the Operator.
One way to determine if NFD is already running in the cluster is to check for a NFD label on your nodes:
$ kubectl get nodes -o json | jq '.items[].metadata.labels | keys | any(startswith("feature.node.kubernetes.io"))'
If the command output is true, then NFD is already running in the cluster.
Procedure#
Tip
For installation on Red Hat OpenShift Container Platform,
refer to Installation and Upgrade Overview on OpenShift.
Add the NVIDIA Helm repository:
$ helm repo add nvidia https://helm.ngc.nvidia.com/nvidia \
&& helm repo update
Install the GPU Operator.
Install the Operator with the default configuration:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4
Install the Operator and specify configuration options:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set <option-name>=<option-value>
Refer to the Common Chart Customization Options
and Common Deployment Scenarios for more information.
Common Chart Customization Options#
The following options are available when using the Helm chart.
These options can be used with --set when installing with Helm.
The following table identifies the most frequently used options.
To view all the options, run helm show values nvidia/gpu-operator.
Parameter
Description
Default
ccManager.enabled
When set to true, the Operator deploys NVIDIA Confidential Computing Manager for Kubernetes.
Refer to GPU Operator with Confidential Containers and Kata for more information.
false
cdi.enabled
When set to true, the Operator installs two additional runtime classes,
nvidia-cdi and nvidia-legacy, and enables the use of the Container Device Interface (CDI)
for making GPUs accessible to containers.
Using CDI aligns the Operator with the recent efforts to standardize how complex devices like GPUs
are exposed to containerized environments.
Pods can specify spec.runtimeClassName as nvidia-cdi to use the functionality or
specify nvidia-legacy to prevent using CDI to perform device injection.
false
cdi.default
When set to true, the container runtime uses CDI to perform device injection by default.
false
daemonsets.annotations
Map of custom annotations to add to all GPU Operator managed pods.
{}
daemonsets.labels
Map of custom labels to add to all GPU Operator managed pods.
{}
dcgmExporter.enabled
By default, the Operator gathers GPU telemetry in Kubernetes via DCGM Exporter.
Set this value to false to disable it.
Available values are true (default) or false.
true
dcgmExporter.service.internalTrafficPolicy
Specifies the internalTrafficPolicy for the DCGM Exporter service.
Available values are Cluster (default) or Local.
Cluster
devicePlugin.config
Specifies the configuration for the NVIDIA Device Plugin as a config map.
In most cases, this field is configured after installing the Operator, such as
to configure Time-Slicing GPUs in Kubernetes.
{}
driver.enabled
By default, the Operator deploys NVIDIA drivers as a container on the system.
Set this value to false when using the Operator on systems with pre-installed drivers.
true
driver.kernelModuleType
Specifies the type of the NVIDIA GPU Kernel modules to use.
Valid values are auto (default), proprietary, and open.
Auto means that the recommended kernel module type (open or proprietary) is chosen based on the GPU devices on the host and the driver branch used.
Note, auto is only supported with the 570.86.15 and 570.124.06 or later driver containers.
550 and 535 branch drivers do not yet support this mode.
Open means the open kernel module is used.
Proprietary means the proprietary module is used.
auto
driver.repository
The images are downloaded from NGC. Specify another image repository when using
custom driver images.
nvcr.io/nvidia
driver.rdma.enabled
Controls whether the driver daemon set builds and loads the legacy nvidia-peermem kernel module.
You might be able to use GPUDirect RDMA without enabling this option.
Refer to GPUDirect RDMA and GPUDirect Storage for information about whether you can use DMA-BUF or
you need to use legacy nvidia-peermem.
false
driver.rdma.useHostMofed
Indicate if MLNX_OFED (MOFED) drivers are pre-installed on the host.
false
driver.startupProbe
By default, the driver container has an initial delay of 60s before starting liveness probes.
The probe runs the nvidia-smi command with a timeout duration of 60s.
You can increase the timeoutSeconds duration if the nvidia-smi command
runs slowly in your cluster.
60s
driver.useOpenKernelModules Deprecated.
This field is deprecated as of v25.3.0 and will be ignored. Use kernelModuleType instead.
When set to true, the driver containers install the NVIDIA Open GPU Kernel module driver.
false
driver.usePrecompiled
When set to true, the Operator attempts to deploy driver containers that have
precompiled kernel drivers.
Refer to the precompiled driver containers page for the supported operating systems.
false
driver.version
Version of the NVIDIA datacenter driver supported by the Operator.
If you set driver.usePrecompiled to true, then set this field to
a driver branch, such as 525.
Depends on the version of the Operator. See the Component Matrix
for more information on supported drivers.
gdrcopy.enabled
Enables support for GDRCopy.
When set to true, the GDRCopy Driver runs as a sidecar container in the GPU driver pod.
For information about GDRCopy, refer to the gdrcopy page.
You can enable GDRCopy if you use the NVIDIA GPU Driver Custom Resource Definition.
false
kataManager.enabled
The GPU Operator deploys NVIDIA Kata Manager when this field is true.
Refer to GPU Operator with Kata Containers for more information.
false
mig.strategy
Controls the strategy to be used with MIG on supported NVIDIA GPUs. Options
are either mixed or single.
single
migManager.enabled
The MIG manager watches for changes to the MIG geometry and applies reconfiguration as needed. By
default, the MIG manager only runs on nodes with GPUs that support MIG (for e.g. A100).
true
nfd.enabled
Deploys Node Feature Discovery plugin as a daemonset.
Set this variable to false if NFD is already running in the cluster.
true
nfd.nodefeaturerules
Installs node feature rules that are related to confidential computing.
NFD uses the rules to detect security features in CPUs and NVIDIA GPUs.
Set this variable to true when you configure the Operator for Confidential Containers.
false
operator.labels
Map of custom labels that will be added to all GPU Operator managed pods.
{}
psp.enabled
The GPU Operator deploys PodSecurityPolicies if enabled.
false
sandboxWorkloads.defaultWorkload
Specifies the default type of workload for the cluster, one of container, vm-passthrough, or vm-vgpu.
Setting vm-passthrough or vm-vgpu can be helpful if you plan to run all or mostly virtual machines in your cluster.
Refer to KubeVirt, Kata Containers, or Confidential Containers.
container
toolkit.enabled
By default, the Operator deploys the NVIDIA Container Toolkit (nvidia-docker2 stack)
as a container on the system. Set this value to false when using the Operator on systems
with pre-installed NVIDIA runtimes.
true
Common Deployment Scenarios#
The following common deployment scenarios and sample commands apply best to
bare metal hosts or virtual machines with GPU passthrough.
Specifying the Operator Namespace#
Both the Operator and operands are installed in the same namespace.
The namespace is configurable and is specified during installation.
For example, to install the GPU Operator in the nvidia-gpu-operator namespace:
$ helm install --wait --generate-name \
-n nvidia-gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
If you do not specify a namespace during installation, all GPU Operator components are installed in the default namespace.
Preventing Installation of Operands on Some Nodes#
By default, the GPU Operator operands are deployed on all GPU worker nodes in the cluster.
GPU worker nodes are identified by the presence of the label feature.node.kubernetes.io/pci-10de.present=true.
The value 0x10de is the PCI vendor ID that is assigned to NVIDIA.
To disable operands from getting deployed on a GPU worker node, label the node with nvidia.com/gpu.deploy.operands=false.
$ kubectl label nodes $NODE nvidia.com/gpu.deploy.operands=false
Preventing Installation of NVIDIA GPU Driver on Some Nodes#
By default, the GPU Operator deploys the driver on all GPU worker nodes in the cluster.
To prevent installing the driver on a GPU worker node, label the node like the following sample command.
$ kubectl label nodes $NODE nvidia.com/gpu.deploy.driver=false
Installation on Red Hat Enterprise Linux#
In this scenario, use the NVIDIA Container Toolkit image that is built on UBI 8:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set toolkit.version=v1.16.1-ubi8
Replace the v1.16.1 value in the preceding command with the version that is supported
with the NVIDIA GPU Operator.
Refer to the GPU Operator Component Matrix on the platform support page.
When using RHEL8 with Kubernetes, SELinux must be enabled either in permissive or enforcing mode for use with the GPU Operator.
Additionally, when using RHEL8 with containerd as the runtime and SELinux is enabled (either in permissive or enforcing mode) at the host level, containerd must also be configured for SELinux, by setting the enable_selinux=true configuration option.
Note, network restricted environments are not supported.
Pre-Installed NVIDIA GPU Drivers#
In this scenario, the NVIDIA GPU driver is already installed on the worker nodes that have GPUs:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set driver.enabled=false
The preceding command prevents the Operator from installing the GPU driver on any nodes in the cluster.
If you do not specify the driver.enabled=false argument and nodes in the cluster have a pre-installed GPU driver, the init container in the driver pod detects that the driver is preinstalled and labels the node so that the driver pod is terminated and does not get re-scheduled on to the node.
The Operator proceeds to start other pods, such as the container toolkit pod.
Pre-Installed NVIDIA GPU Drivers and NVIDIA Container Toolkit#
In this scenario, the NVIDIA GPU driver and the NVIDIA Container Toolkit are already installed on
the worker nodes that have GPUs.
Tip
This scenario applies to NVIDIA DGX Systems that run NVIDIA Base OS.
Before installing the Operator, ensure that the default runtime is set to nvidia.
Refer to Configuration in the NVIDIA Container Toolkit documentation for more information.
Install the Operator with the following options:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set driver.enabled=false \
--set toolkit.enabled=false
Pre-Installed NVIDIA Container Toolkit (but no drivers)#
In this scenario, the NVIDIA Container Toolkit is already installed on the worker nodes that have GPUs.
Configure toolkit to use the root directory of the driver installation as /run/nvidia/driver, because this is the path mounted by driver container.
$ sudo sed -i 's/^#root/root/' /etc/nvidia-container-runtime/config.toml
Install the Operator with the following options (which will provision a driver):
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set toolkit.enabled=false
Running a Custom Driver Image#
If you want to use custom driver container images, such as version 465.27, then
you can build a custom driver container image. Follow these steps:
Rebuild the driver container by specifying the $DRIVER_VERSION argument when building the Docker image. For
reference, the driver container Dockerfiles are available on the Git repository at nvidia/container-images/driver.
Build the container using the appropriate Dockerfile. For example:
$ docker build --pull -t \
--build-arg DRIVER_VERSION=455.28 \
nvidia/driver:455.28-ubuntu20.04 \
--file Dockerfile .
Ensure that the driver container is tagged as shown in the example by using the driver:<version>-<os> schema.
Specify the new driver image and repository by overriding the defaults in
the Helm install command. For example:
$ helm install --wait --generate-name \
-n gpu-operator --create-namespace \
nvidia/gpu-operator \
--version=v25.3.4 \
--set driver.repository=docker.io/nvidia \
--set driver.version="465.27"
These instructions are provided for reference and evaluation purposes.
Not using the standard releases of the GPU Operator from NVIDIA would mean limited
support for such custom configurations.
Specifying Configuration Options for containerd#
When you use containerd as the container runtime, the following configuration
options are used with the container-toolkit deployed with GPU Operator:
toolkit:
env:
- name: CONTAINERD_CONFIG
value: /etc/containerd/config.toml
- name: CONTAINERD_SOCKET
value: /run/containerd/containerd.sock
- name: CONTAINERD_RUNTIME_CLASS
value: nvidia
- name: CONTAINERD_SET_AS_DEFAULT
value: true
If you need to specify custom values, refer to the following sample command for the syntax:
helm install gpu-operator -n gpu-operator --create-namespace \
nvidia/gpu-operator $HELM_OPTIONS \
--version=v25.3.4 \
--set toolkit.env[0].name=CONTAINERD_CONFIG \
--set toolkit.env[0].value=/etc/containerd/config.toml \
--set toolkit.env[1].name=CONTAINERD_SOCKET \
--set toolkit.env[1].value=/run/containerd/containerd.sock \
--set toolkit.env[2].name=CONTAINERD_RUNTIME_CLASS \
--set toolkit.env[2].value=nvidia \
--set toolkit.env[3].name=CONTAINERD_SET_AS_DEFAULT \
--set-string toolkit.env[3].value=true
These options are defined as follows:
CONTAINERD_CONFIGThe path on the host to the containerd config
you would like to have updated with support for the nvidia-container-runtime.
By default this will point to /etc/containerd/config.toml (the default
location for containerd). It should be customized if your containerd
installation is not in the default location.
CONTAINERD_SOCKETThe path on the host to the socket file used to
communicate with containerd. The operator will use this to send a
SIGHUP signal to the containerd daemon to reload its config. By
default this will point to /run/containerd/containerd.sock
(the default location for containerd). It should be customized if
your containerd installation is not in the default location.
CONTAINERD_RUNTIME_CLASSThe name of the
Runtime Class
you would like to associate with the nvidia-container-runtime.
Pods launched with a runtimeClassName equal to CONTAINERD_RUNTIME_CLASS
will always run with the nvidia-container-runtime. The default
CONTAINERD_RUNTIME_CLASS is nvidia.
CONTAINERD_SET_AS_DEFAULTA flag indicating whether you want to set
nvidia-container-runtime as the default runtime used to launch all
containers. When set to false, only containers in pods with a runtimeClassName
equal to CONTAINERD_RUNTIME_CLASS will be run with the nvidia-container-runtime.
The default value is true.
Rancher Kubernetes Engine 2#
For Rancher Kubernetes Engine 2 (RKE2), refer to
Deploy NVIDIA Operator
in the RKE2 documentation.
Refer to the Known Limitations.
MicroK8s#
For MicroK8s, set the following in the ClusterPolicy.
toolkit:
env:
- name: CONTAINERD_CONFIG
value: /var/snap/microk8s/current/args/containerd-template.toml
- name: CONTAINERD_SOCKET
value: /var/snap/microk8s/common/run/containerd.sock
- name: CONTAINERD_RUNTIME_CLASS
value: nvidia
- name: CONTAINERD_SET_AS_DEFAULT
value: "true"
These options can be passed to GPU Operator during install time as below.
helm install gpu-operator -n gpu-operator --create-namespace \
nvidia/gpu-operator $HELM_OPTIONS \
--version=v25.3.4 \
--set toolkit.env[0].name=CONTAINERD_CONFIG \
--set toolkit.env[0].value=/var/snap/microk8s/current/args/containerd-template.toml \
--set toolkit.env[1].name=CONTAINERD_SOCKET \
--set toolkit.env[1].value=/var/snap/microk8s/common/run/containerd.sock \
--set toolkit.env[2].name=CONTAINERD_RUNTIME_CLASS \
--set toolkit.env[2].value=nvidia \
--set toolkit.env[3].name=CONTAINERD_SET_AS_DEFAULT \
--set-string toolkit.env[3].value=true
Verification: Running Sample GPU Applications#
CUDA VectorAdd#
In the first example, letâs run a simple CUDA sample, which adds two vectors together:
Create a file, such as cuda-vectoradd.yaml, with contents like the following:
apiVersion: v1
kind: Pod
metadata:
name: cuda-vectoradd
spec:
restartPolicy: OnFailure
containers:
- name: cuda-vectoradd
image: "nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.7.1-ubuntu20.04"
resources:
limits:
nvidia.com/gpu: 1
Run the pod:
$ kubectl apply -f cuda-vectoradd.yaml
The pod starts, runs the vectorAdd command, and then exits.
View the logs from the container:
$ kubectl logs pod/cuda-vectoradd
Example Output
[Vector addition of 50000 elements]
Copy input data from the host memory to the CUDA device
CUDA kernel launch with 196 blocks of 256 threads
Copy output data from the CUDA device to the host memory
Test PASSED
Done
Removed the stopped pod:
$ kubectl delete -f cuda-vectoradd.yaml
Example Output
pod "cuda-vectoradd" deleted
Jupyter Notebook#
You can perform the following steps to deploy Jupyter Notebook in your cluster:
Create a file, such as tf-notebook.yaml, with contents like the following example:
---
apiVersion: v1
kind: Service
metadata:
name: tf-notebook
labels:
app: tf-notebook
spec:
type: NodePort
ports:
- port: 80
name: http
targetPort: 8888
nodePort: 30001
selector:
app: tf-notebook
---
apiVersion: v1
kind: Pod
metadata:
name: tf-notebook
labels:
app: tf-notebook
spec:
securityContext:
fsGroup: 0
containers:
- name: tf-notebook
image: tensorflow/tensorflow:latest-gpu-jupyter
resources:
limits:
nvidia.com/gpu: 1
ports:
- containerPort: 8888
name: notebook
Apply the manifest to deploy the pod and start the service:
$ kubectl apply -f tf-notebook.yaml
Check the pod status:
$ kubectl get pod tf-notebook
Example Output
NAMESPACE   NAME          READY   STATUS      RESTARTS   AGE
default     tf-notebook   1/1     Running     0          3m45s
Because the manifest includes a service, get the external port for the notebook:
$ kubectl get svc tf-notebook
Example Output
NAME          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)       AGE
tf-notebook   NodePort    10.106.229.20   <none>        80:30001/TCP  4m41s
Get the token for the Jupyter notebook:
$ kubectl logs tf-notebook
Example Output
[I 21:50:23.188 NotebookApp] Writing notebook server cookie secret to /root/.local/share/jupyter/runtime/notebook_cookie_secret
[I 21:50:23.390 NotebookApp] Serving notebooks from local directory: /tf
[I 21:50:23.391 NotebookApp] The Jupyter Notebook is running at:
[I 21:50:23.391 NotebookApp] http://tf-notebook:8888/?token=3660c9ee9b225458faaf853200bc512ff2206f635ab2b1d9
[I 21:50:23.391 NotebookApp]  or http://127.0.0.1:8888/?token=3660c9ee9b225458faaf853200bc512ff2206f635ab2b1d9
[I 21:50:23.391 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 21:50:23.394 NotebookApp]
To access the notebook, open this file in a browser:
file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
Or copy and paste one of these URLs:
http://tf-notebook:8888/?token=3660c9ee9b225458faaf853200bc512ff2206f635ab2b1d9
or http://127.0.0.1:8888/?token=3660c9ee9b225458faaf853200bc512ff2206f635ab2b1d9
The notebook should now be accessible from your browser at this URL:
http://your-machine-ip:30001/?token=3660c9ee9b225458faaf853200bc512ff2206f635ab2b1d9.
Installation on Commercially Supported Kubernetes Platforms#
Product
Documentation
Red Hat OpenShift 4
using RHCOS worker nodes
NVIDIA GPU Operator on Red Hat OpenShift Container Platform
VMware vSphere with Tanzu
and NVIDIA AI Enterprise
NVIDIA AI Enterprise VMware vSphere Deployment Guide
Google Cloud Anthos
NVIDIA GPUs with Google Anthos
previous
About the NVIDIA GPU Operator
next
Upgrading the NVIDIA GPU Operator
On this page
Prerequisites
Procedure
Common Chart Customization Options
Common Deployment Scenarios
Specifying the Operator Namespace
Preventing Installation of Operands on Some Nodes
Preventing Installation of NVIDIA GPU Driver on Some Nodes
Installation on Red Hat Enterprise Linux
Pre-Installed NVIDIA GPU Drivers
Pre-Installed NVIDIA GPU Drivers and NVIDIA Container Toolkit
Pre-Installed NVIDIA Container Toolkit (but no drivers)
Running a Custom Driver Image
Specifying Configuration Options for containerd
Rancher Kubernetes Engine 2
MicroK8s
Verification: Running Sample GPU Applications
CUDA VectorAdd
Jupyter Notebook
Installation on Commercially Supported Kubernetes Platforms
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