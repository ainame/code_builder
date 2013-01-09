require 'json'
require 'dogen'

class Code
  attr_reader :templates

  def initialize(builder_enviroment)
    template = Template.find(builder_enviroment.template_id)
    begin
      env_params = JSON.parse(builder_enviroment.params_json)
      env = Dogen::Enviroment.new(env_params)
      builder = Dogen::Builder.new(env)
      builder.add_template Dogen::Template.new(
        :raw_body      => template.body,
        :template_path => template.name,
      )
      dogen = Dogen.new(builder)
      @templates = dogen.render
    rescue => e
      Padrino.logger.fatal(e.message)
      @templates = [Dogen::Template.new(
          :raw_body => template.body,
          :rendered_body => template.body,
          :template_path => template.name,
      )]
    end
  end
end
