require 'rake_helpers/trust_manager'

class AddTrustPathsTask < Rake::Task
  attr_accessor :trusted_paths, :trust_name

  def execute(*args)
    super
    do_enable_trust
  end

  def do_enable_trust
    TrustManager.new.add_to_trust(trust_name, *trusted_paths)
  end
end