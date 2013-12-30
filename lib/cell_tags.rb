module CellTags
  include Radiant::Taggable
  class TagError < StandardError; end

  desc %{
    Renders the cell specified in the @name@ attribute _outside_ of
    the context of a page.

    The cell name and view are specified in the appropriate attributes,
    and local data required for rendering the view may be provided via
    additional tags, which will be passed through to cell in its @opts hash.

    *Usage:*

    <pre><code><r:cell name="cell_name/view_name" data_param_1="x" data_param_2="y"/></code></pre>
  }
  tag "cell" do |tag|
    render_cell(tag)
  end


  desc %{
    Renders an SSI (server side include) instruction for the cell specified
    in the @name@ attribute _outside_ of  the context of a page.

    When SSI is turned on within a front end apache/nginx server, this will 
    trigger a call back to the server, where the name_and_value
    will be decoded and checked.

    Also passes back initial params and page_path.
    
    *Usage:*

    <pre><code><r:cell_by_ssi name="cell_name/view_name" data_param_1="x" data_param_2="y"/></code></pre>
  }
  tag 'cell_by_ssi' do |tag|
    page_path = tag.globals.page.request.path
    params    = tag.globals.page.request.params

    name_and_value = tag.attr['name']

    cell_params_str = "name=#{name_and_value}"
    cell_params_str += "&page_pathname=#{page_path}"
    cell_params_str += params.to_query

    if Rails.env.development?
      render_cell(tag)
    else
      raw "<!--# include virtual='/cells?#{cell_params_str}' -->"
    end
  end

  def render_cell(tag)
    name = tag.attr.delete('name')
    name, view = name.split("/") if name
    if name && view
      cell_attrs = tag.attr.merge(:page => tag.locals.page).symbolize_keys
      tag.locals.page.response.template.controller.render_cell(name, view, cell_attrs)
    else
      raise TagError.new("'cell' tag must contain 'name' and 'view' attributes")
    end
  end
end
