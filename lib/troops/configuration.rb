require "fileutils"
require 'yaml'

module Troops
  # This class will handle all things considering
  # loading and saving configuration. It should work
  # like this.
  #
  # There are 2 kinds of configurations:
  #  * the project dependent one, has a .troops file with 
  #    some configuration for the project
  #  * a user dependent one in the home directory of 
  #    the user
  #
  class Configuration
    class << self
        def config(environment)
            config_hash = yamlize
            if config_hash["team_token"].nil?
                puts ""
                puts "======================================================================================="
                puts "================================== TROOPS ============================================="
                puts "======================================================================================="
                puts "=== You have to set your TestFlight 'team_token' in your ~/.troops file.            ==="
                puts "=== Here is an example on how the .troop file should look:                          ==="
                puts "===                                                                                 ==="
                puts "=== team_token: 'thisisyourawesometeamtoken'                                        ==="
                puts "===                                                                                 ==="
                puts "=== You can find your Team Token on your Team Info page on http://testflightapp.com ==="
                puts "======================================================================================="
                puts "======================================================================================="
                puts ""
            elsif config_hash["api_token"].nil?
                puts ""
                puts "============================================================================================="
                puts "================================== TROOPS ==================================================="
                puts "============================================================================================="
                puts "=== You have to set your TestFlight 'api_token' in your .troops file inside this project. ==="
                puts "=== Here is an example on how the .troops file should look:                               ==="
                puts "===                                                                                       ==="
                puts "=== api_token: 'thisisyourawesomeapitoken'                                                ==="
                puts "=== production:                                                                           ==="
                puts "===     configuration: 'Release'                                                          ==="
                puts "===     target: 'The Release iOS App Name'                                                ==="
                puts "=== staging:                                                                              ==="
                puts "===     configuration: 'Ad Hoc'                                                           ==="
                puts "===     target: 'The Ad Hoc iOS App Name'                                                 ==="
                puts "===                                                                                       ==="
                puts "=== You can find your Team Token on Your Account page on http://testflightapp.com         ==="
                puts "============================================================================================="
                puts "============================================================================================="
                puts ""
            elsif config_hash[environment].nil?
                puts ""
                puts "============================================================================================="
                puts "================================== TROOPS ==================================================="
                puts "============================================================================================="
                puts "=== You have to set your environment variable in your .troops file.                       ==="
                puts "=== Here is an example on how the .troops file should look:                               ==="
                puts "===                                                                                       ==="
                puts "=== api_token: 'thisisyourawesomeapitoken'                                                ==="
                puts "=== production:                                                                           ==="
                puts "===     configuration: 'Release'                                                          ==="
                puts "===     target: 'The Release iOS App Name'                                                ==="
                puts "=== staging:                                                                              ==="
                puts "===     configuration: 'Ad Hoc'                                                           ==="
                puts "===     target: 'The Ad Hoc iOS App Name'                                                 ==="
                puts "============================================================================================="
                puts "============================================================================================="
                puts ""
            else
                config_hash
            end
        end

      # Setup the color theme with the hash.
      def yamlize
          user_hash = {}
          user_hash = YAML::load File.open(troops_user_config)
          user_hash = {} unless Hash === user_hash

          project_hash = {}
          project_hash = YAML::load File.open(troops_project_config)
          project_hash = {} unless Hash === project_hash

          project_hash.merge(user_hash)
      end

      # All user dependent config files are stored in `~/.troops`
      def troops_user_config
          configurize "HOME"
      end

      # All project dependent config files are stored in `.troops`
      def troops_project_config
          configurize "PWD"
      end

      private

      def configurize(env_type="HOME")
        troops_path = File.join(ENV[env_type], ".troops")
        unless File.exists?(troops_path) 
            File.open(troops_path, 'w') 
        end
        troops_path
      end
    end
  end
end
