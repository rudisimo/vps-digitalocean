require 'erb'

class Generator
  include ERB::Util
  attr_accessor :config, :template

  def initialize(config, template)
    @config = config
    @template = template
  end

  def render()
    ERB.new(File.read(@template)).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end
end
