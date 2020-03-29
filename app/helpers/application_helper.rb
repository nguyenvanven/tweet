module ApplicationHelper
  def load_javascript_class(javascript_class, *options)
    "<script>$(function(){ (new #{javascript_class}()).init()\; })</script>".html_safe
  end
end
