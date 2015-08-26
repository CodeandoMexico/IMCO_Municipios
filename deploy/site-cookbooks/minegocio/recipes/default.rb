include_recipe 'git'

creds = data_bag_item("secrets", "keys")


list_credentials = []

creds.keys.each do |key|
    if key !=  "id"
        list_credentials.push "#{key}=#{creds[key]}"
    end
end

    
docker_service 'default' do
    action [:create, :start]
end


docker_image "docker.io/postgres" do
    tag "9.4"
end

docker_image "phusion/passenger-ruby22" do
    tag "latest"
end

docker_container "postgres" do
    image "docker.io/postgres"
    tag "9.4"
    container_name "postgres"
    detach  true
    env "POSTGRES_PASSWORD=#{creds['POSTGRES_PASSWORD']}"
end


git '/var/minegocio' do
    repository "https://github.com/civica-digital/mi-negocio-mx.git"
    revision "master"
    action :sync
end


docker_image "minegocio" do
    tag "latest"
    source "/var/minegocio"
    action :build
    notifies :redeploy, "docker_container[minegocio_sidekiq]", :immediately
    notifies :redeploy, "docker_container[minegocio_app]", :immediately
end

docker_container "minegocio_app" do
    image "minegocio"
    tag "latest"
    container_name "minegocio_app"
    detach true
    env list_credentials
    port ["80:80"]
    links ["postgres:postgres"]
end

docker_container "minegocio_sidekiq" do
    image "minegocio"
    tag "latest"
    container_name "minegocio_sidekiq"
    detach true
    env list_credentials
    entrypoint "sidekiq"
    links ["postgres:postgres"]
    action :run
end