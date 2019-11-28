CCAT-env 
====

Configuration environment for Beckhoff CCAT FPGA Kernel mode driver [1] to run EtherCAT Master on CX devices 

The following instruction is **invalid** for CentOS7. Please see CentOS7 section below.

## DKMS Setup, Build, and Install Kernel modules


```sh
$ make init
$ make dkms_add
$ make dkms_build
$ make dkms_install
```

In order to remove them

```sh
$ make dkms_uninstall
$ make dkms_remove
```

## Kernel modules configuration

* Create and load the autoload configuration in /etc/modules-load.d/*.conf
* Remove and load the kernel module with modprobe

```sh
$ make setup
```

In order to clean the configuration,

```sh
$ make setup_clean
```

## Notice

If one would like to setup IgH EtherCAT Master via https://github.com/icshwi/etherlabmaster, please *DO NOT* run the dkms_setup.bash script.

## DKMS Systemd Service
If one has already the running dkms.service in systemd, the next reboot with new kernl image will make the kernel module be ready. However, if one doesn't have one, please run bash dkms/dkms_setup.bash in order to enable dkms.service.

```
$ bash dkms/dkms_setup.bash
$ systemctl status dkms
● dkms.service - Builds and install new kernel modules through DKMS
   Loaded: loaded (/etc/systemd/system/dkms.service; enabled; vendor preset: ena
   Active: active (exited) since Sun 2018-07-29 01:13:59 CEST; 4s ago
     Docs: man:dkms(8)
  Process: 3271 ExecStart=/bin/sh -c dkms autoinstall --verbose --kernelver $(un
 Main PID: 3271 (code=exited, status=0/SUCCESS)

```


## CentOS7

We cannot use the dkms, because of the following error:
```
make: Entering directory `/usr/src/kernels/3.10.0-1062.1.2.el7.x86_64'
arch/x86/Makefile:166: *** CONFIG_RETPOLINE=y, but not supported by the compiler. Compiler update recommended..  Stop.
make: Leaving directory `/usr/src/kernels/3.10.0-1062.1.2.el7.x86_64'
```

Thus, one should setup it as follows:

* Install kernel modules
```
make init
make patch
make centos7_modules
sudo make centos7_modules_install
make setup
```

* Remove all kernel modules, and its configuration
```
make setup_clean
```


## References
[1] https://github.com/Beckhoff/CCAT

