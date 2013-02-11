require 'json'
require 'dogen'

class Code
  attr_reader :templates

  def initialize(builder_enviroment)
    begin
      env_params = JSON.parse(builder_enviroment.params_json)
      env = Dogen::Enviroment.new(env_params)
      builder = Dogen::Builder.new(env)
      builder_enviroment.package.templates.each do |tmpl|
        builder.add_template Dogen::Template.new(
          :raw_body      => tmpl.body,
          :template_path => tmpl.name,
        )
      end
      dogen = Dogen.new(builder)
      @templates = dogen.render
    rescue => e
      Padrino.logger.fatal(e.message)
      @templates = [Dogen::Template.new(
          :raw_body => '',
          :rendered_body => '',
          :template_path => '',
      )]
    end
  end
end
