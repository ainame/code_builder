# Helper methods defined here can be accessed in any controller or view in the application
require 'json'

CodeBuilderLite.helpers do
  def convert_array_params_to_hash(params)
    key_value_pairs = params.values
    key_value_pairs.map { |pair|
      { pair[:key] => pair[:value] }
    }.inject(&:merge)
  end

  def consequence_command(category_id, enviroment_access_token)
    category = Category.get_instance(category_id)
    path = url_for(:consequences, category.name.downcase.to_sym, :access_token => enviroment_access_token)
    link = request.scheme + "://" + request.host_with_port + path
    category.command_format % link
  end
end
