require 'json'

CodeBuilderLite.controllers :consequences do
  get :installer, :map => '/i/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @description = ''
    @templates = codes.templates

    render 'consequences/installer', :layout => false
  end

  get :hive, :map => '/h/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @description = ''
    @templates = codes.templates

    render 'consequences/batch_hiveql', :layout => false
  end

  get :downloader, :map => '/d/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @templates = codes.templates

    render 'consequences/downloader', :layout => false
  end
end
