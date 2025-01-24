# encoding: UTF-8
require '../../lib/wiz-teleport/ruby_shell'

# begin
#   Net::SSH.start('10.51.81.70', 'root1', password: 'ChangCheng@12#$') do |ssh|
#     puts "Connected to #{@host}"
#     # Your code here
#   end
# rescue Net::SSH::AuthenticationFailed => e
#   puts "Authentication failed: #{e.message}"
# rescue StandardError => e
#   puts "An error occurred: #{e.message}"
# end

#ssh_client = SSHClient.new('10.51.81.70', 'root1', 'ChangCheng@12#$' )
#p r.run('uname -a')

#r = RemoteHost.new('10.51.81.70', 'root1', "ChangCheng@12\#$" )
#p r.run('uname -a')

# require 'net/ssh'
#
#
#  Net::SSH.start('10.51.52.214', 'cc', password: "Huawei12\#$", auth_methods: ['password']) do |ssh|
#    puts ssh.exec!('uname -a')
#  end

#r = SSHClient.new('10.51.52.214', 'cc', 'Huawei@12#$' )
#p r.run('uname -a')

#t = SSHCommander.new(HOSTS, USER, PASSWORD)
#p t.run('uname -a')

# 上传文件到每个主机
#t.put('local_file.txt', '/remote/path/local_file.txt')
#
# 创建shell实例

WizTeleport::RubyShell.run 'web' do
  # 这里可以直接写Ruby代码
  puts "Hello from Ruby Shell!"

  # 运行简单的Ruby表达式
  result = 3 + 4
  puts "Result of 3 + 4 is #{result}"

  # 直接运行Linux命令
  uname "-a"
  ls "-l"

  # 更多的Ruby代码
  files = ["file1.txt", "file2.txt", "file3.txt"]
  puts "Files in the current directory: #{files.join(', ')}"
end
