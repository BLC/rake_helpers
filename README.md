# Description
This gem provides some helpers we've found useful for managing rake tasks. This includes interacting with "sprouts":http://projectsprouts.org/.

# Config Usage

Example config file (rake_config.yml):

app:
  app_name: CoolNuggets

Example RakeFile:

    require 'rake_helpers/config'
    # Load up any settings that are manually configured
    MP::Config.global_settings_file = 'rake_config.yml' if File.exist?('rake_config.yml')

    class AppConfig < MP::Config
      def application_file_path
        File.join(code_path, app_file)
      end
    end

    AppConfig.configure do |config|
      # Make it so you can just type app_config to get at a AppConfig object
      config.expose_as_method
      
      # add 2 vars, 1 with a default, 1 without
      config.add(:code_path)
      config.add(:app_file, :default => 'main.rb')
      config.add(:app_name, :default => 'not yet set')
    end

    # override code_path with a setter
    test_config.code_path = 'spec'

    # override app_file through the environment, you generally would
    # do this by setting it as an environment variable before you run rake:
    # APP_FILE='startup.rb' rake do_something
    ENV['APP_FILE'] = 'startup.rb'

    # Assuming the above rake_config.yml was used, test_config.app_name would
    # now return the value set in that file
    test_config.app_name # 'CoolNuggets'

# Usage for flex projects
This also includes a default config useful for flex projects as MP::FlexConfig. This exposes a couple helpful properties such as flex_sdk_path which is determined by the normal config rules (those defined above) or if it hasn't been explicitly set it will try to determine it from the location of your mxmlc command.

Example FlexConfig usage:
    # build.rake
    require 'rake_helpers/config'
    class FlexConfig < MP::FlexConfig
    end

    FlexConfig.configure do |config|
     config.expose_as_method
    end

    # Now to get at the flex sdk path you'd do:
    # This will return either the environment variable FLEX_SDK, your set flex_sdk_path or
    # the path just above mxmlc (determined by which mxmlc)
    flex_config.flex_sdk_path
    
