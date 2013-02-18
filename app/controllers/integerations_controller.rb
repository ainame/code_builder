CodeBuilderLite.controllers :integrations do
  Slim::Engine.set_default_options pretty: true, sort_attrs: false if development?

  get :top, :map => '/' do
    @categories = Category.all
    render "integrations/select_category"
  end

  get :new, :map => '/p/new' do
    @categories = Category.all
    @templates  = Template.all
    @package    = Package.new
    @package.templates.build

    if params[:mode].blank?
      render "integrations/select_category"
    elsif params[:mode] == 'package'
      @package.category = Category.new(params[:category_id])
      render 'integrations/new'
    end
  end

  get :index, :map => '/p' do
    @categories = Category.all
    @packages   = Package.latest.all
    render 'integrations/index'
  end

  get :show, :map => '/p/:access_token' do
    @package = Package.where(:access_token => params[:access_token]).first
    render 'integrations/show'
  end

  post :create, :map => '/p' do
    @package = Package.new(params[:package])

    if @package.save
      redirect url_for(:integrations, :show, :access_token => @package.access_token)
    else
      redirect url_for(:integrations, :new)
    end
  end

  put :update, :map => '/p', :with => :id do
    p params
    @package = Package.find(params[:id])

    if @package.update_attributes(params[:package])
      redirect url_for(:integrations, :show, :access_token => @package.access_token)
    else
      redirect url_for(:integrations, :show, :access_token => @package.access_token)
    end
  end

end
