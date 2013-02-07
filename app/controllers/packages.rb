CodeBuilderLite.controllers :packages do
  Slim::Engine.set_default_options pretty: true, sort_attrs: false if development?

  get :index do
    @packages = Package.all
    render 'packages/index'
  end

  get :new do
    @package = Package.new
    @package.affiliations.build
    @categories = Category.all
    @templates = Template.all

    render 'packages/show'
  end

  get :show, :with => :id do
    @package = Package.find(params[:id])
    render 'packages/show'
  end

  post :create, :map => '/packages' do
    affiliations_template_ids =
      params[:package].delete('template_ids')
    @package = Package.new(params[:package])

    if @package.save
      affiliations_template_ids.each do |template_id|
        affiliation = Affiliation.create(
          :package_id  => @package.id,
          :template_id => template_id
        )
        @package.affiliations << affiliation
      end
      redirect url_for(:packages, :show, :id => @package.id)
    else
      redirect url_for(:packages, :new)
    end
  end

  put :update, :map => '/packages/:id' do
    @package = Package.find(params[:id])

    if @package.update_attributes(params[:package])
      redirect url_for(:packages, :show, :id => @package.id)
    else
      redirect url_for(:packages, :new)
    end
  end

end
