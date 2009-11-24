class TrustManager
  def add_to_trust(name, *dirs)
    FileUtils.mkdir_p trust_dir
    File.open(File.join(trust_dir, name), 'w') do |file|
      dirs = dirs.map { |dir| File.expand_path(dir) }
      file.puts(dirs.join("\n"))
    end
  end

  private
  # based on http://www.adobe.com/devnet/flashplayer/articles/flash_player_admin_guide/flash_player_admin_guide.pdf
  # around page 83
  def trust_dir
    if PLATFORM =~ /(mswin)|(mingw)/
      # vista
      # "C:\Users\username\AppData\Roaming\Macromedia\Flash Player\#Security\FlashPlayerTrust"

      # windows 2000 & XP
      File.join(ENV['HOME'], 'Application Data\Macromedia\Flash Player\#Security\FlashPlayerTrust')
    elsif PLATFORM =~ /darwin/  
      File.join(ENV['HOME'], 'Library/Preferences/Macromedia/Flash Player/#Security/FlashPlayerTrust')
    elsif PLATFORM =~ /linux/
        File.join(ENV['HOME'], '.macromedia/#Security/FlashPlayerTrust')
    else
      raise "Unsupported platform #{PLATFORM}"
    end
  end
end