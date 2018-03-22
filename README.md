# Cluster *bare metal* de Kubernetes via RKE em hosts com RancherOS

Nesse repositório é descrita a instalação do cluster [kubernetes](kubernetes.io) via [Rancher Kubernetes Engine - RKE](https://github.com/rancher/rke) em hosts com [RancherOS](https://rancher.com/rancher-os/). 

Atualmente o _cluster_ possui as seguintes especificações de _hardware_:

* 3 x HP Z220: 
  * 1 x Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz 
  * 4 x 4 GB DDR3-1600 = 16GB de RAM 
  * 2 x Gigabit Ethernet (Intel 82579LM e Realtek RTL8169) em agregação de enlace com [LACP](https://standards.ieee.org/findstds/standard/802.1AX-2008.html)

__Total: 12 núcleos de processamento e 64 GB de RAM.__

Para o provisionamento e configuração dos hosts foi utilizado o arquivo [cloud-config](http://rancher.com/docs/os/v1.2/en/configuration/#cloud-config), o qual é específico para cada máquina física: `node1`, `node2` etc.

## Instânciação dos hosts

Os nós(hosts) são instânciados da seguinte maneira:

É feito o boot da máquina com uma [iso do RancherOS](http://rancher.com/docs/os/v1.2/en/running-rancheros/server/install-to-disk/) e então executa-se o seguinte comando, com seu respectivo arquivo cloud-config.yml: 

```$ sudo ros install -c cloud-config.yml -d /dev/sda```

Então a máquina estará preparada para entrar no cluster.

Embora esteja configurado para uma versão específica do Docker e do console é necessário rodar os seguintes comandos para aplicar:

```$ sudo ros console switch debian```  
```$ sudo ros engine switch docker-17.03.2-ce```

Configurado módulos e instalado pacotes para suporte a Gluster e NFS:

```bash
$ apt update 
$ apt install nfs-common glusterfs-client -y
$ modprobe dm_snapshot dm_mirror dm_thin_pool
```

A versão do docker e o console são exemplos.

## Instalando o kubernetes via [rke](https://github.com/rancher/rke):

Com a configuração do cluster.yml gerada utilizamos o seguinte comando para instalar e configurar o kubernetes:

```$ ./rke up --config cluster.yml```
