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
    path = url_for(:consequences, :installer, :access_token => enviroment_access_token)
    link = request.scheme + "://" + request.host_with_port + path
    Category.new(category_id).command_format % link
  end
end
