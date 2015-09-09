include_recipe 'git'

Chef::Resource::DockerContainer.send(:include, Creds::Helper)

    
#docker_service 'default' do
#    action [:create, :start]
#end


docker_image "docker.io/postgres" do
    tag "9.4"
end

docker_image 'civicadigital/backup' do
    tag "latest"
end

docker_image "phusion/passenger-ruby22" do
    tag "0.9.16"
end

docker_image "google/cadvisor" do
    tag "latest"
end


docker_image "gliderlabs/logspout" do
    tag "v2"
end

#docker_container "postgres" do
#    image "docker.io/postgres"
#    tag "9.4"
#    container_name "postgres"
#    detach  true
#    env "POSTGRES_PASSWORD=#{creds['POSTGRES_PASSWORD']}"
#end
