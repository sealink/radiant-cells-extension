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
