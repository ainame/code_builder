require 'json'

CodeBuilderLite.controllers :codes do
  Slim::Engine.set_default_options pretty: true,
                                   sort_attrs: false if development?

  get :index do
    @builder_enviroments = BuilderEnviroment.all
    render 'codes/index'
  end

  get :new  do
    @builder_enviroment = BuilderEnviroment.new
    @templates = Template.latest.all
    render 'codes/show'
  end

  get :show, :map => '/codes/:access_token' do
    @builder_enviroment =
      BuilderEnviroment.where(:access_token => params[:access_token]).first_or_initialize
    @templates = Template.latest.all
    @code = Code.new(@builder_enviroment) if @builder_enviroment

    render 'codes/show'
  end

  post :create, :map => '/codes' do
    params[:builder_enviroment][:params_json] = 
      JSON.generate(convert_array_params_to_hash(params[:variables]))

    @builder_enviroment = BuilderEnviroment.new(
      params[:builder_enviroment]
    )

    if @builder_enviroment.save
      redirect url_for(:codes, :show, :access_token => @builder_enviroment.access_token)
    else
      redirect url_for(:codes, :new)
    end
  end

  put :update, :map => '/codes/:id' do
    @builder_enviroment = BuilderEnviroment.find(params[:id])
    params[:builder_enviroment][:params_json] = 
      JSON.generate(convert_array_params_to_hash(params[:variables]))

    if @builder_enviroment.update_attributes(params[:builder_enviroment])
      redirect url_for(:codes, :show, :access_token => @builder_enviroment.access_token)
    else
      redirect url_for(:codes, :show, :access_token => @builder_enviroment.access_token)
    end
  end

  get :installer, :map => '/i/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @templates = codes.templates

    render 'codes/installer', :layout => false
  end

  get :downloader, :map => '/d/:access_token' do
    builder_enviroment = BuilderEnviroment.where(
      :access_token => params[:access_token]
    ).first

    codes = Code.new(builder_enviroment)
    @templates = codes.templates

    render 'codes/downloader', :layout => false
  end

end
