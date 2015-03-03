task :default do
end

task :vim do
  path_to_vundle = File.join(ENV["HOME"], ".vim/bundle/Vundle.vim")

  unless File.exist?(path_to_vundle)
    `git clone https://github.com/gmarik/Vundle.vim.git #{path_to_vundle}`
  end

  `vim +PluginInstall +qall`
end

task :link do
  Dir.glob("_*").each do |file|
    to   = file.sub("_", ".")
    src  = File.join(Dir.pwd, file)
    dest = File.join(ENV["HOME"], to)

    if File.exist?(dest)
      fail "file `#{dest}` already exists" unless File.symlink?(dest)
      fail "symlink `#{dest}` exists" unless File.readlink(dest) == src
      puts "exists #{dest}"
    else
      File.symlink(src, dest)
      puts "linked #{dest}"
    end
  end
end
