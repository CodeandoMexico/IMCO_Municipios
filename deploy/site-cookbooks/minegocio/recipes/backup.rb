Chef::Resource::DockerContainer.send(:include, Creds::Helper)

docker_container "minegociobackup" do
    image "minegocio/backup"
    link ["minegociomx_db_1:postgres"]
    env list_credentials
    cmd_timeout 2200
    remove_automatically true
    command ""
    container_name "backup"
    action :run 
end