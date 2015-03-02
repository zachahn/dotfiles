task :default do
end

task :link do
  Dir.glob("_*").each do |file|
    to   = file.sub("_", ".")
    src  = File.join(Dir.pwd, file)
    dest = File.join(ENV["HOME"], to)

    if File.exist?(dest)
      fail "file `#{dest}` already exists" unless File.symlink?(dest)
      fail "symlink `#{dest}` exists" unless File.readlink(dest) == src
    else
      File.symlink(src, dest)
    end
  end
end
