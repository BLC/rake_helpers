require 'fileutils'

class RSLManager
  def copy_rsls(source_dir, output_dir, *rsls)
    FileUtils.mkdir_p output_dir
    rsls.each do |rsl|
      FileUtils.cp File.join(source_dir, 'frameworks/rsls', rsl), output_dir
    end
  end
end