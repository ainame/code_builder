# Helper methods defined here can be accessed in any controller or view in the application
require 'json'

CodeBuilderLite.helpers do
  def convert_array_params_to_hash(params)
    key_value_pairs = params.values
    key_value_pairs.map { |pair|
      { pair[:key] => pair[:value] }
    }.inject(&:merge)
  end

  def install_command(builder_enviroment_access_token)
    return 'This will shown after saving' if builder_enviroment_access_token.blank?

    link = request.scheme + "://" + request.host_with_port + 
      url_for(:codes, :installer, :access_token => builder_enviroment_access_token)
    "$ curl #{link} | ruby"
  end

  def download_command(builder_enviroment_access_token)
    link = request.scheme + "://" + request.host_with_port + 
      url_for(:codes, :downloader, :access_token => builder_enviroment_access_token)
    "$ hive -e \"$(curl #{link})\""
  end
end
