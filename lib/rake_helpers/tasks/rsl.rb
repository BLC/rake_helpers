require 'rake_helpers/rsl_manager'

class RSLCopyTask < Rake::Task
  attr_accessor :source_dir, :output_dir, :rsls

  def execute(*args)
    super
    do_copy
  end

  def do_copy
    if defined?(flex_config)
      self.source_dir ||= flex_config.flex_sdk_path
      self.output_dir ||= File.join(flex_config.swf_output_path, 'rsls')
    end

    rsls ||=  %w(framework_3.4.0.9271.swz
                 framework_3.4.0.9271.swf
                 datavisualization_3.4.0.9271.swz
                 datavisualization_3.4.0.9271.swf)
    RSLManager.new.copy_rsls(source_dir, output_dir, *rsls)
  end
end