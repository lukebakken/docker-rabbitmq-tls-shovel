ARG RABBITMQ_DOCKER_TAG=rabbitmq:3-management
FROM ${RABBITMQ_DOCKER_TAG}

COPY --chown=rabbitmq:rabbitmq --chmod=0400 erlang.cookie /var/lib/rabbitmq/.erlang.cookie
COPY --chown=rabbitmq:rabbitmq definitions.json /etc/rabbitmq/
COPY --chown=rabbitmq:rabbitmq enabled_plugins /etc/rabbitmq/
COPY --chown=rabbitmq:rabbitmq rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY --chown=rabbitmq:rabbitmq ca_certificate.pem /etc/rabbitmq/
COPY --chown=rabbitmq:rabbitmq *rmq0*.pem /etc/rabbitmq/

EXPOSE 4369 5671 5672 15671 15672 15692 25672 35672-35682
