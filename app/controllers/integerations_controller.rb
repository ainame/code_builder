CodeBuilderLite.controllers :integrations do
  Slim::Engine.set_default_options pretty: true, sort_attrs: false if development?

  get :top, :map => '/' do
    @categories = Category.all
    render "integrations/select_category"
  end

  get :new, :map => '/i' do
    @categories = Category.all
    @templates  = Template.all
    @package    = Package.new
    @package.templates.build

    if params[:mode].blank?
      render "integrations/select_category"
    elsif params[:mode] == 'package'
      @category = Category.new(params[:category_id])
      render 'integrations/new'
    end
  end

  post :create, :map => '/i' do
    @package = Package.new(params[:package])

    if @package.save
      redirect url_for(:templates, :index)
    else
      redirect url_for(:templates, :index)
    end
  end

end
