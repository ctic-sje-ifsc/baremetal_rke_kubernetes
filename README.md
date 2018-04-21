# Cluster *bare metal* de Kubernetes via RKE em hosts com RancherOS(ou CoreOS)

Nesse repositório é descrita a instalação do cluster [kubernetes](kubernetes.io) via [Rancher Kubernetes Engine - RKE](https://github.com/rancher/rke) em hosts com [RancherOS](https://rancher.com/rancher-os/)([ou Coreos Container Linux](https://coreos.com/os/docs/latest/)). 

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

Para o provisionamento e configuração dos hosts foi utilizado o arquivo [cloud-config](http://rancher.com/docs/os/v1.2/en/configuration/#cloud-config), o qual é específico para cada máquina física: `node1`, `node2` etc. Também criamos a versão dos arquivos cloud-config para o SO [Coreos Container Linux](https://coreos.com/os/docs/latest/).

## Instânciação dos hosts

Os nós(hosts) são instânciados da seguinte maneira:

É feito o boot da máquina com uma [iso do RancherOS](http://rancher.com/docs/os/v1.2/en/running-rancheros/server/install-to-disk/) 

Configure a rede do host para acessar a internet(caso não tenha um DHCP).

Faça o download do arquivo de configuração do SO (cloud config):
```
$ wget bit.ly/noderke[1-5]
```

e então executa-se o seguinte comando, com seu respectivo arquivo cloud-config.yml: 

```
$ sudo ros install -c noderke[1-5] -d /dev/sda
```

Então a máquina estará preparada para entrar no cluster.

Embora esteja configurado para uma versão específica do Docker, do console e do serviço volume-nfs, é necessário rodar os seguintes comandos para aplicar:

```
$ sudo ros console switch debian    
$ sudo ros engine switch docker-17.03.2-ce     
$ sudo ros service enable volume-nfs  
$ sudo ros service up volume-nfs 
$ sudo ros service enable open-iscsi 
$ sudo ros service up open-iscsi
```

A versão do docker e o console são exemplos.

## Instalando o kubernetes via [rke](https://github.com/rancher/rke):

Com a configuração do cluster.yml gerada utilizamos o seguinte comando para instalar e configurar o kubernetes:

```
$ ./rke up --config cluster.yml
```


# Recuperação de desastre

A recuperação de desastre dessa estrutura consiste em seguir os passos desse tutorial a partir de [instânciação-dos-hosts](#instânciação-dos-hosts).

Caso não seja necessário reinstalar o SO, os passos são os seguintes:

Remover o cluster kubernetes:   
``` 
$ ./rke remove 
```

Acessar cada nó e rodar os seguintes comandos:
```
$ sudo docker stop $(docker ps -a -q)
$ sudo docker rm $(docker ps -a -q)
$ sudo docker volume prune
$ sudo rm -rf /var/lib/rook
```

## Reestabelecendo o cluster kubernetes e os serviços:

Quando você já possui acesso via ssh (ssh rancher@nodenuvemX) a todos os hosts pode executar o comando para criar/atualizar o cluster(possuindo o arquivo cluster.yml):

```$ ./rke up --config cluster.yml```

Clone o repositório dos serviços: https://github.com/ctic-sje-ifsc/servicos_kubernetes

Criando todos os namespaces:
```
$ cd servicos_kubernetes/namespaces
$ kubectl create -f namespaces.yaml
```

Baixar as chaves do [drive](https://drive.google.com/drive/folders/0B_KFdN7OB_xwZ1J0SVk2QWNnU3M?usp=sharing) e criar todas com o comando:

```
$ make -i create
```

Depois acesse a pasta dos serviços e inicie todos com o seguinte comando:
```
$ cd servicos_kubernetes
$ make -i create
```





