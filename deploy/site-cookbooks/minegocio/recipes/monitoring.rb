docker_container "cadvisor" do
    image "google/cadvisor"
    tag "latest"
    volume ["/:/rootfs:ro", "/var/run:/var/run:rw", "/sys:/sys:ro", "/var/lib/docker/:/var/lib/docker:ro"]
    port "8080:8080"
    detach true
    container_name "cadvisor"
    action :run
end