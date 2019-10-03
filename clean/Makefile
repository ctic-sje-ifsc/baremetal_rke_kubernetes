all: delete

delete:
	ssh root@vmnuvem1.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@vmnuvem2.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@vmnuvem3.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@vmnuvem4.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@vmnuvem5.sj.ifsc.edu.br "bash -s" < rm_docker_all.sh
	ssh root@vmnuvem1.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@vmnuvem2.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@vmnuvem3.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@vmnuvem4.sj.ifsc.edu.br rm -rf /var/lib/etcd
	ssh root@vmnuvem5.sj.ifsc.edu.br rm -rf /var/lib/etcd