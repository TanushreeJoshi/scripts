#include_recipe "jars::dir_creation"
execute "create uploads" do
cwd "/home/ec2-user/"
command "mkdir uploads"
creates 'uploads'
action :run
end
execute "create app" do
cwd "/home/ec2-user/"
command "mkdir applications"
creates 'applications'
action :run
end
execute "create archives" do
cwd "/home/ec2-user/"
command "sudo mkdir applications/archives"
creates 'applications/archives'
action :run
end
execute "uploads/date"do
cwd "/home/ec2-user/"
command "test -d uploads/$(date +%Y%m%d) &&  cd .. || sudo mkdir uploads/$(date +%Y%m%d)"
action :run
end
execute "cwd" do
  cwd "/home/ec2-user/"
  command "cd uploads/$(date +%Y%m%d)"
  action :run
end
remote_file "example.keystore" do
  source "https://s3-ap-southeast-1.amazonaws.com/adorotest/example.keystore"
  action :create
end
remote_file "prateek.yml" do
  source "https://s3-ap-southeast-1.amazonaws.com/adorotest/prateek.yml"
  action :create
end
remote_file "rest-0.0.1-SNAPSHOT.jar" do
  source "https://s3-ap-southeast-1.amazonaws.com/adorotest/rest-0.0.1-SNAPSHOT.jar"
  action :create
end
execute "copy to $date"do
cwd "/home/ec2-user/uploads/"
command "cp ../../../example.keystore $(date +%Y%m%d)/example.keystore"
action :run
end
execute "copy to $date"do
cwd "/home/ec2-user/uploads/"
command "cp ../../../prateek.yml $(date +%Y%m%d)/prateek.yml"
action :run
end
execute "copy to $date"do
cwd "/home/ec2-user/uploads/"
command "cp ../../../rest-0.0.1-SNAPSHOT.jar $(date +%Y%m%d)/rest-0.0.1-SNAPSHOT.jar"
action :run
end
execute "copy to app" do
cwd "/home/ec2-user/uploads/"
command "cp $(date +%Y%m%d)/example.keystore ../applications/ "
action :run
end
execute "copy to app" do
cwd "/home/ec2-user/uploads/"
command "cp $(date +%Y%m%d)/prateek.yml ../applications/ "
action :run
end
execute "copy to app" do
cwd "/home/ec2-user/uploads/"
command "cp $(date +%Y%m%d)/rest-0.0.1-SNAPSHOT.jar ../applications/ "
action :run
end
execute "temp dir"do
  cwd "/home/ec2-user/uploads/"
  command "sudo mkdir abc"
end
execute "move old files" do
  cwd "/home/ec2-user"
  command "find uploads/ -maxdepth 1 -mindepth 1 -not -name $(date +%Y%m%d) -print0 | xargs -0 sudo mv -t applications/archives/"
  action :run
end
