# Cluster *bare metal* de Kubernetes via RKE em hosts com RancherOS

Nesse repositório é descrita a instalação do cluster [kubernetes](kubernetes.io) via [Rancher Kubernetes Engine - RKE](https://github.com/rancher/rke) em hosts com [RancherOS](https://rancher.com/rancher-os/). 

Atualmente o _cluster_ possui as seguintes especificações de _hardware_:

* 1 x Dell PowerEdge R630: 
  * 1 x Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz
  * 8 x 16 GB DDR4 2133 ECC = 128GB de RAM
  * 4 x Broadcom BCM5720 em agregação de link LACP (IEEE802.3ad)
  
* 4 x HP Z220: 
  * 1 x Intel(R) Xeon(R) CPU E3-1225 V2 @ 3.20GHz 
  * 4 x 4 GB DDR3-1600 = 16GB de RAM 
  * 2 x Gigabit Ethernet (Intel 82579LM e Realtek RTL8169) em agregação de enlace com [LACP](https://standards.ieee.org/findstds/standard/802.1AX-2008.html)

__Total: 36 núcleos de processamento e 192 GB de RAM.__

Para o provisionamento e configuração dos hosts foi utilizado o arquivo [cloud-config](http://rancher.com/docs/os/v1.2/en/configuration/#cloud-config), o qual é específico para cada máquina física: `node1`, `node2` etc.

## Instânciação dos hosts

Os nós(hosts) são instânciados da seguinte maneira:

É feito o boot da máquina com uma [iso do RancherOS](http://rancher.com/docs/os/v1.2/en/running-rancheros/server/install-to-disk/) e então executa-se o seguinte comando, com seu respectivo arquivo cloud-config.yml: 

```$ sudo ros install -c cloud-config.yml -d /dev/sda```

Então a máquina estará preparada para entrar no cluster.

Embora esteja configurado para uma versão específica do Docker, do console e do serviço volume-nfs, é necessário rodar os seguintes comandos para aplicar:

```$ sudo ros console switch debian```  
```$ sudo ros engine switch docker-17.03.2-ce```  
```$ sudo ros service enable volume-nfs```  
```$ sudo ros service up volume-nfs```  
```$ sudo ros service enable open-iscsi```  
```$ sudo ros service up open-iscsi```

Configurado módulos e instalado pacotes para suporte a Gluster:

```bash
$ apt update 
$ apt install glusterfs-client -y
```

A versão do docker e o console são exemplos.

## Instalando o kubernetes via [rke](https://github.com/rancher/rke):

Com a configuração do cluster.yml gerada utilizamos o seguinte comando para instalar e configurar o kubernetes:

```$ ./rke up --config cluster.yml```


## Recuperação de desastre

