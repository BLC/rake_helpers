require 'rake'
require 'rake_helpers/build_info'

class BuildInfoTask < Rake::Task
  attr_accessor :file

  def self.define_task(args, &block)
    t = super
    if(t.is_a?(BuildInfoTask))
      yield t if block_given?
    end
    return t
  end

  protected
  def execute(*args)
    build_info = BuildInfo.new
    File.open(file, 'w') { |f| f.write(build_info.to_action_script) }
  end
end

def build_info_task(*args, &block)
  BuildInfoTask.define_task(*args, &block)
end
