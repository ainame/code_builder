require 'json'

CodeBuilderLite.controllers :consequences do
  get :installer, :map => '/i/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @templates = codes.templates

    render 'enviroments/installer', :layout => false
  end

  get :downloader, :map => '/d/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @templates = codes.templates

    render 'enviroments/downloader', :layout => false
  end
end
