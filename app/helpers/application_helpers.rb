CodeBuilderLite.helpers do
  def desired_method(obj)
    obj.respond_to?(:persisted?) && obj.persisted? ? :put : :post
  end

  def form_for_restful(obj, base_url, options = {}, &block)
    request_method = desired_method(obj)
    url = request_method == :put ? "#{base_url}/#{obj.id}" : base_url
    form_for obj, url, :method => request_method, &block
  end
end
