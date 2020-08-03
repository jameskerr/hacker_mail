deploy:
	ansible-playbook -i ops/production ops/site.yml -t deploy

df:
	ansible all -i ops/production -a "df -H" -u deploy

free:
	ansible all -i ops/production -a "free -m" -u deploy
