# JQueryTabs


class Tabs
  attr_accessor :data
  def initialize(context)
    @context = context
    @data = []
  end
  def add_tab(title, options={}, &block)
    id = options[:id] || "tab_"+(rand(899999)+100000).to_s
    @data << { :id => id, :title => title, :content => @context.capture(&block) }
  end
end

module JQueryTabs
  def content_tabs(options={}, &block)
    id    = options[:id] || "tabs_"+(rand(899999)+100000).to_s
    tabs  = Tabs.new(self)
    other = capture(tabs, &block)
    
    lis  = ""
    divs = ""
    tabs.data.each do |tab|
      lis  += "<li><a href='##{tab[:id]}'>#{tab[:title]}</a></li>"
      divs += "<div id='#{tab[:id]}'>#{tab[:content]}</div>"
    end
    
    out  = ""
    out += "<div id='#{id}'>"
    out += "  <ul>"
    out += "    #{lis}"
    out += "  </ul>"
    out += "  #{divs}"
    out += "</div>"
    out += "<script type='text/javascript'>jQuery('##{id}').tabs();</script>"
    concat("#{out}#{other}")
  end
end

