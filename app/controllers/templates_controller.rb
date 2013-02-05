CodeBuilderLite.controllers :templates do
  Slim::Engine.set_default_options pretty: true,
                                   sort_attrs: false if development?

  get :index do
    @templates = Template.latest.all
    render 'templates/index'
  end

  get :new  do
    @template = Template.new
    render 'templates/show'
  end

  get :show, :map => '/templates/:access_token' do
    @template =
      Template.where(:access_token => params[:access_token]).first_or_initialize
    render 'templates/show'
  end
  
  post :create, :map => '/templates' do
    @template = Template.new(params[:template])

    if @template.save
      redirect url_for(:templates, :show, :access_token => @template.access_token)
    else
      redirect url_for(:templates, :new)
    end
  end

  put :update, :map => '/templates/:id' do
    @template = Template.find(params[:id])

    if @template.update_attributes(params[:template])
      redirect url_for(:templates, :show, :access_token => @template.access_token)
    else
      redirect url_for(:templates, :new)
    end
  end

end
