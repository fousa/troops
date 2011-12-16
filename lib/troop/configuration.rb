require "fileutils"
require 'yaml'

module Troop
  # This class will handle all things considering
  # loading and saving configuration. It should work
  # like this.
  #
  # There are 2 kinds of configurations:
  #  * the project dependent one, has a .troop file with 
  #    some configuration for the project
  #  * a user dependent one in the home directory of 
  #    the user
  #
  class Configuration
    class << self
        def config
            config_hash = yamlize
            if config_hash["team_token"].nil?
                puts ""
                puts "======================================================================================="
                puts "================================== TROOP =============================================="
                puts "======================================================================================="
                puts "=== You have to set your TestFlight 'team_token' in your ~/.troop file.             ==="
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
                puts "============================================================================================"
                puts "================================== TROOP ==================================================="
                puts "============================================================================================"
                puts "=== You have to set your TestFlight 'api_token' in your .troop file inside this project. ==="
                puts "=== Here is an example on how the .troop file should look:                               ==="
                puts "===                                                                                      ==="
                puts "=== api_token: 'thisisyourawesomeapitoken'                                               ==="
                puts "=== production:                                                                          ==="
                puts "===     configuration: 'Release'                                                         ==="
                puts "===     target: 'The Release iOS App Name'                                               ==="
                puts "=== staging:                                                                             ==="
                puts "===     configuration: 'Ad Hoc'                                                          ==="
                puts "===     target: 'The Ad Hoc iOS App Name'                                                ==="
                puts "===                                                                                      ==="
                puts "=== You can find your Team Token on Your Account page on http://testflightapp.com        ==="
                puts "============================================================================================"
                puts "============================================================================================"
                puts ""
            else
                config_hash
            end
        end

      # Setup the color theme with the hash.
      def yamlize
          user_hash = {}
          user_hash = YAML::load File.open(troop_user_config)
          user_hash = {} unless Hash === user_hash

          project_hash = {}
          project_hash = YAML::load File.open(troop_project_config)
          project_hash = {} unless Hash === project_hash

          project_hash.merge(user_hash)
      end

      # All user dependent config files are stored in `~/.troop`
      def troop_user_config
          configurize "HOME"
      end

      # All project dependent config files are stored in `.troop`
      def troop_project_config
          configurize "PWD"
      end

      private

      def configurize(env_type="HOME")
        troop_path = File.join(ENV[env_type], ".troop")
        unless File.exists?(troop_path) 
            File.open(troop_path, 'w') 
        end
        troop_path
      end
    end
  end
end
