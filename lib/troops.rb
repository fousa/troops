require "troops/configuration"

require "rubygems"
require "betabuilder"

module Troops
    class << self
        def archive(args)
            @environment = args[:environment]
            @log         = args[:log]

           configure do 
                beta_build = build_task 

                archive_build beta_build

                clear_builds unless @log
            end
        end

        def deploy(args)
            @environment         = args[:environment]
            @needs_to_archive    = args[:needs_to_archive]
            @needs_to_distribute = args[:needs_to_distribute]
            @log                 = args[:log]

            configure do
                beta_build  = build_task 
                beta_config = archive_build beta_build if @needs_to_archive

                deploy_build_to_testflight beta_build

                clear_builds unless @log
            end
        end

        private

        def configure(&block)
            @config = Troops::Configuration.config @environment
            unless @config.nil?
                yield
            end
        end

        def build_task
            task = BetaBuilder::Tasks.new do |beta_config|
                beta_config.xcode4_archive_mode = true

                beta_config.target              = @config[@environment]["target"]
                beta_config.configuration       = @config[@environment]["configuration"]

                beta_config.deploy_using(:testflight) do |testflight|
                    testflight.api_token          = @config["api_token"]
                    testflight.team_token         = @config["team_token"]
                    testflight.distribution_lists = @config[@environment]["distribution_list"] if @needs_to_distribute && @config[@environment]["distribution_list"]
                end
            end
            beta_build  = task.instance_eval { @configuration }

            build task, beta_build

            beta_build
        end

        def build(task, beta_build)
            task.xcodebuild beta_build.build_arguments, "build"
        end

        def archive_build(beta_build)
            beta_archive = BetaBuilder.archive(beta_build)
            beta_config = beta_archive.instance_eval { @configuration }
            output_path = beta_archive.save_to(beta_config.archive_path)

            puts "Archive saved to #{output_path}."

            beta_config
        end

        def deploy_build_to_testflight(beta_build)
            FileUtils.rm_rf('pkg') && FileUtils.mkdir_p('pkg')
            FileUtils.mkdir_p("pkg/Payload")
            FileUtils.mv(beta_build.built_app_path, "pkg/Payload/#{beta_build.app_file_name}")
            Dir.chdir("pkg") do
                system("zip -r '#{beta_build.ipa_name}' Payload")
            end
            FileUtils.mkdir('pkg/dist')
            FileUtils.mv("pkg/#{beta_build.ipa_name}", "pkg/dist")

            beta_build.deployment_strategy.prepare
            beta_build.deployment_strategy.deploy
        end

        def clear_builds
            %w{pkg build.output build}.each { |f| FileUtils.rm_rf f }
        end
    end
end
