# WizTeleport

WizTeleport is a Ruby Gem that simplifies SSH connections and remote command execution. It is ideal for operational tasks and automated deployments.

WizTeleport is designed to execute shell commands remotely over SSH, with no agents to install on remote systems.

## Installation

Add this line to your application's Gemfile:

   ```bash
   gem 'wiz-teleport'
   ```

And then execute:

   ```bash
   $ bundle
   ```

Or install it yourself as:

   ```bash
   gem install wiz-teleport
   ```

## Usage
WizTeleport is a powerful automation tool for configuration management, application deployment, task execution, and more. It is based on SSH, so there is no need to install the agent on the target host. Here are the basic steps and examples for using WizTeleport.

1. Create a project directory

    First, create a new directory to save your Ruby project:
    ```bash
    mkdir my_ruby_project
    cd my_ruby_project
    ```
2. Install WizTeleport

   Make sure you have Ruby installed. Then run the following command to install the WizTeleport:
    ```bash
    gem install wiz-teleport
    ```

3. Create an WizTeleport manifest file

   WizTeleport uses a manifest file to define hosts. Wiz-Teleport reads a list or group from Inventory.yml and can operate these controlled nodes or hosts simultaneously and concurrently, just like Ansible. Create a file called inventory.yml that looks like this:
   ```yaml
   # inventory.yml
   ---
   - name: web1
     user: root
     password: root
     servers:
     - host: 127.0.0.1     
   - name: data1
     servers:
     - host: db1.example.com       
     - host: db2.example.com
       name: db1
       user: root
       password: root
     children:
     - web1
   ```
6. Build an WizTeleport script

   WizTeleport script defines tasks by writing ruby scripts. Here is an example of a simple WizTeleport script:
   ```ruby
   #example.rb
   require 'wiz-teleport'
   
   WizTeleport::Shell.run 'web1' do
     # write ruby code
     puts "Hello from Ruby Shell!"
     
     # running linux command
     uname "-a"
     ls "-l" 
     
   end
   
   ```
7. Execute WizTeleport script

   Run WizTeleport script using ruby command:
   ```bash
   ruby example.rb
   ```
## Build WizTeleport task
Executing shell tasks in rakefiles is a common requirement. A shell task is actually a rake task. Here is a basic example of how to define and execute a shell task in a Rakefile.

1. Create Rakefile
   ```ruby
   # Rakefile.rb
   require 'rake'
   require 'wiz-teleport'
   
   namespace :custom do
     desc "A custom shell task"
     shell :example, 'web1' do
       puts 'Hello from Ruby Shell!'
       uname "-a"
       ls "-l"
     end
   end
   ```
2. Execute Rake tasks
   ```bash
   rake custom:example
   ```

## File structure

The project structure looks like this:
```bash
my_ruby_project/
│
├── inventory.yml
├── Rakefile
├── example.rb
└── ... other file
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/songgz/wiz-teleport. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/songgz/wiz-teleport/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WizTeleport project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wiz-teleport/blob/master/CODE_OF_CONDUCT.md).
