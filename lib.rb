module Action
  def call
    if first_run?
      first
    else
      if respond_to?(:tail)
        tail
      end
    end

    if respond_to?(:always)
      always
    end
  end
end

class Sloth
  include Action

  def dsm(name, &block)
    define_singleton_method(name, &block)
  end
end

class Dotfile
  def initialize(dotfile)
    link_name = dotfile.sub("_", ".")
    @target   = File.join(Dir.pwd, dotfile)
    @link     = File.join(ENV["HOME"], link_name)
  end

  def status
    if File.exist?(@link)
      if File.symlink?(@link)
        if File.readlink(@link) == @target
          :linked
        else
          :bad_link
        end
      else
        :not_link
      end
    else
      :not_exists
    end
  end

  attr_reader :target, :link
end

class DotfileLinker
  def initialize(dotfile)
    @dotfile = dotfile
  end

  def link
    dotfile = @dotfile

    linker = Sloth.new
    linker.dsm(:first_run?) { dotfile.status == :not_exists }
    linker.dsm(:first)      { File.symlink(dotfile.target, dotfile.link) }
    linker.dsm(:always)     { puts "#{dotfile.status} #{dotfile.link}" }
    linker.call
  end

  def unlink
    dotfile = @dotfile

    linker = Sloth.new
    linker.dsm(:first_run?) { dotfile.status == :linked }
    linker.dsm(:first)      { File.delete(dotfile.link) }
    linker.dsm(:always)     { puts "#{dotfile.status} #{dotfile.link}" }
    linker.call
  end
end
