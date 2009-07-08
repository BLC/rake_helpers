require 'erb'

class ErbHelper
  def self.write(template_name, target, binding)
    puts "Writing #{template_name} to #{target}"
    File.open(target, 'w') do |file|
      test_suite = ERB.new(File.read(template_name), nil, "%>").result(binding)

      file.puts(test_suite)
    end
  end
end