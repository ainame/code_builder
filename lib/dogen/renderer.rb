require 'erb'

class Dogen::Renderer
  def initialize(template, enviroment)
    @template   = template
    @enivroment = enviroment
    @binding    = enviroment.get_binding
  end
  
  def render
    render_erb
  end

  private
  def render_erb
    # safe_level = 4, trim_mode = 1
    tmp = ERB.new(@template.raw_body, 4, 1).result(@binding)
    @template.rendered_body = tmp
  end
end
