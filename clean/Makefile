all: delete

delete:
  	ssh root@proxmoxworks1.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxworks2.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxworks3.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxdell1.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxhp1.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxhp2.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxlenovo1.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@proxmoxworks1.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxworks2.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxworks3.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxdell1.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxhp1.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxhp2.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@proxmoxlenovo1.sj.ifsc.edu.br rm -rf /var/lib/etcd

