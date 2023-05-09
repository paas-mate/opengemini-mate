FROM ttbb/opengemini:nake

WORKDIR /opt/opengemini

COPY docker-build /opt/opengemini/mate

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/opengemini/mate/scripts/start.sh"]
