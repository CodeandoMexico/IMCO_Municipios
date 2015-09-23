Chef::Resource::DockerContainer.send(:include, Creds::Helper)

git '/var/minegocio' do
    repository "https://github.com/civica-digital/mi-negocio-mx.git"
    revision "master"
    action :sync
end


docker_image "minegocio" do
    tag "latest"
    source "/var/minegocio"
    cmd_timeout 12200
    action :build
    notifies :redeploy, "docker_container[minegocio_app]", :immediately
end

#docker_container "minegocio_dbcreate" do
#    image "minegocio"
#    tag "latest"
#    container_name "minegocio_dbcreate"
#    env list_credentials
#    link ["postgres:postgres"]
#    entrypoint "rake"
#    command "db:create"
#    remove_automatically true
#    action :run
#end

#docker_container "minegocio_dbmigrate" do
#    image "minegocio"
#    tag "latest"
#    container_name "minegocio_dbmigrate"
#    env list_credentials
#    link ["minegociomx_db_1:postgres"]
#    entrypoint "rake"
#    command "db:migrate"
#    remove_automatically true
#    action :run
#end

docker_container "minegocio_app" do
    image "minegocio"
    tag "latest"
    container_name "minegocio_app"
    detach true
    env list_credentials
    port ["80:80"]
    link ["minegociomx_db_1:postgres"]
    action :run
end