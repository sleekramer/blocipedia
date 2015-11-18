module Haml::Filters::Markdown
  require 'redcarpet'

  def render(text)
    markdown.render(text)
  end

  private
  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, {no_intra_emphasis: true, tables: true, fenced_code_blocks: true, autolink: true, disable_indented_code_blocks: true, strikethrough: true, lax_spacing: true, underline: true, superscript: true, quote: true, highlight: true})
  end
  def renderer
    Redcarpet::Render::HTML.new(hard_wrap: true)
  end

end
