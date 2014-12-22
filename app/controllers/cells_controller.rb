class CellsController < SiteController

  # Return a cell as text for use in ajax
  #
  #  :name
  #  :value
  #  :extra_data...
  def show
    name, view = params.delete('name').split('/')
    set_monitoring_meta_data(name, view)
    if name && view
      cell_attrs = params

      if params[:page_pathname]
        cell_attrs[:page] = find_page(params[:page_pathname])
        cell_attrs[:page_pathname] = params[:page_pathname]
      end

      puts "Page pathname given: #{params[:page_pathname]}"
      puts "Found page; #{cell_attrs[:page]}"

      render :text => render_cell(name, view, cell_attrs)
    else
      raise "Cannot render cell without a cell name"

    end
  end


  private

  def set_monitoring_meta_data(controller, action)
    return unless defined?(NewRelic)
    NewRelic::Agent.set_transaction_name("#{controller}/#{action}")
  end
end
