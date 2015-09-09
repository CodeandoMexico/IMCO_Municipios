docker_container "logs" do
  image "gliderlabs/logspout"
  tag "v2"
  container_name "logs"
  detach true
  volume ["/var/run/docker.sock:/tmp/docker.sock", "/var/log/urbem:/mnt/routes"]
  port "127.0.0.1:8000:8000"
end