execute "kill if running" do
  cwd "/home/ec2-user/applications"
  command "ps axf | grep server | grep -v grep| awk '{ print $1}' | xargs kill -9"
  only_if "ps x | grep -v grep | grep -c server"
  action :run
end
execute "server start" do
cwd "/home/ec2-user/applications"
command "java -jar rest-0.0.1-SNAPSHOT.jar server prateek.yml &"
action :run
end
