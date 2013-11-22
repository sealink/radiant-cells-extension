class CellsExtension < Radiant::Extension
  version "1.0"
  description "Adds tags for Cells."
  url "http://github.com/sealink/radiant-cells-extension"

  def activate
    Page.send :include, CellTags
  end

  def deactivate
  end
end
