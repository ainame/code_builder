CodeBuilderLite.controllers :packages do
  Slim::Engine.set_default_options pretty: true, sort_attrs: false if development?

  get :index do
    @packages = Package.all
    render 'packages/index'
  end

  get :new do
    @package = Package.new
    @package.affiliation = Affiliation.new
    @categories = Category.all
    @templates = Template.all

    render 'packages/show'
  end

  post :create, :map => '/packages' do
    @package = Package.new(params[:package])

    if @package.save
      redirect url_for(:package, :show)
    else
      redirect url_for(:package, :new)
    end
  end

  put :update, :map => '/packages/:id' do
    @package = Package.find(params[:id])

    if @package.update_attributes(params[:package])
      redirect url_for(:packages, :show)
    else
      redirect url_for(:package, :new)
    end
  end

end
