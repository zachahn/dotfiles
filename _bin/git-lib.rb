#!/usr/bin/env ruby --disable=gems
# frozen_string_literal: true

require "open3"
require "stringio"

def popen3(*command, stdout:, stderr:)
  out, err, status = Open3.popen3(*command) do |i, o, e, t|
    out_reader = Thread.new do
      buffer = StringIO.new
      o.each_line do |line|
        print line if stdout
        buffer << line
      end
      buffer.string
    end

    err_reader = Thread.new do
      buffer = StringIO.new
      e.each_line do |line|
        print line if stderr
        buffer << line
      end
      buffer.string
    end

    i.close

    [out_reader.value, err_reader.value, t.value]
  end

  [out, err, status]
end

def run(*command, say: true)
  out, _err, status = popen3(*command, stdout: say, stderr: say)

  if !status.success?
    exit(1)
  end

  out.rstrip
end

def which(cmd)
  ENV["PATH"]
    .split(File::PATH_SEPARATOR)
    .map { |path| File.join(path, cmd) }
    .find { |exe_path| File.executable?(exe_path) && !File.directory?(exe_path) }
end

def default_branch
  local_branches = `git branch --list`.split("\n").map { |b| b.sub(/^(?:\s+|\*\s)/, "") }

  if local_branches.include?("main")
    "main"
  else
    "master"
  end
end

def has_remote?(remote_name)
  has_remote = `git remote --verbose` =~ /^#{remote_name}\b/

  if remote_name == "origin" || has_remote
    return has_remote
  end

  warn %(warning: remote does not exist: #{remote_name})

  has_remote
end

def remote!
  return @remote if @remote
  return @remote = "origin" if ARGV.empty?

  require "optparse"
  @remote = "origin"
  OptionParser.new { |opts| opts.on("--remote=REMOTE") { |r| @remote = r } }.parse!
  @remote
end

if $0 == __FILE__
  puts <<~MSG
    #!/usr/bin/env ruby --disable=gems
    # frozen_string_literal: true

    load File.expand_path("../git-lib", File.realpath(__FILE__))
  MSG
end
