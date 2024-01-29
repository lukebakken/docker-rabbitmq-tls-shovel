.PHONY: clean down up perms rmq-perms

RABBITMQ_DOCKER_TAG ?= rabbitmq:3-management

clean: perms
	git clean -xffd

down:
	docker compose down

$(CURDIR)/tls-gen/basic/result/server_rmq0_certificate.pem:
	$(MAKE) -C $(CURDIR)/tls-gen/basic CN=rmq0 gen
	cp -v $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/rmq0
	cp -v $(CURDIR)/tls-gen/basic/result/*rmq0*.pem $(CURDIR)/rmq0
rmq0-cert: $(CURDIR)/tls-gen/basic/result/server_rmq0_certificate.pem

$(CURDIR)/tls-gen/basic/result/server_rmq1_certificate.pem:
	$(MAKE) -C $(CURDIR)/tls-gen/basic CN=rmq1 gen-client gen-server
	cp -v $(CURDIR)/tls-gen/basic/result/ca_certificate.pem $(CURDIR)/rmq1
	cp -v $(CURDIR)/tls-gen/basic/result/*rmq1*.pem $(CURDIR)/rmq1
rmq1-cert: $(CURDIR)/tls-gen/basic/result/server_rmq1_certificate.pem

certs: rmq0-cert rmq1-cert

up: rmq-perms
	# NB: fresh stuffs
	docker compose build --no-cache --pull --build-arg RABBITMQ_DOCKER_TAG=$(RABBITMQ_DOCKER_TAG)
	docker compose up --pull always

perms:
	sudo chown -R "$(USER):$(USER)" data log

rmq-perms:
	sudo chown -R '999:999' data log
