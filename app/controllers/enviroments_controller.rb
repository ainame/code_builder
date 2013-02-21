require 'json'

CodeBuilderLite.controllers :enviroments do
  Slim::Engine.set_default_options pretty: true,
                                   sort_attrs: false if development?

  get :index, :map => '/e' do
    @builder_enviroments = BuilderEnviroment.latest.all
    render 'enviroments/index'
  end

  get :new, :map => '/e/new' do
    @builder_enviroment = BuilderEnviroment.new
    unless params[:mode] == "detail"
      @packages = Package.latest.all.group_by{|pa| pa.category }
    else
      @package = @builder_enviroment.package ||
        Package.find(params[:package_id])
    end

    render 'enviroments/show'
  end

  get :show, :map => '/e/:access_token' do
    @builder_enviroment =
      BuilderEnviroment.where(:access_token => params[:access_token]).first_or_initialize
    @package = @builder_enviroment.package ||
      Package.find(params[:package_id])
    @packages = Package.latest.all
    @category_name = @builder_enviroment.package.category.name.downcase || "perl"
    @category_name = "sql" if @category_name == "hive"
    @code = Code.new(@builder_enviroment) if @builder_enviroment

    render 'enviroments/show'
  end

  post :create, :map => '/e' do
    params[:builder_enviroment][:params_json] = 
      JSON.generate(convert_array_params_to_hash(params[:variables]))

    @builder_enviroment = BuilderEnviroment.new(
      params[:builder_enviroment]
    )

    if @builder_enviroment.save
      redirect url_for(:enviroments, :show, :access_token => @builder_enviroment.access_token)
    else
      redirect url_for(:enviroments, :new)
    end
  end

  put :update, :map => '/e/:id' do
    @builder_enviroment = BuilderEnviroment.find(params[:id])
    params[:builder_enviroment][:params_json] = 
      JSON.generate(convert_array_params_to_hash(params[:variables]))

    if @builder_enviroment.update_attributes(params[:builder_enviroment])
      redirect url_for(:enviroments, :show, :access_token => @builder_enviroment.access_token)
    else
      redirect url_for(:enviroments, :show, :access_token => @builder_enviroment.access_token)
    end
  end

end
