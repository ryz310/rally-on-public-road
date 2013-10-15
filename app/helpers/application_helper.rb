module ApplicationHelper
  # content_for の override
  def content_for(name, content = nil, &block)
    @has_content ||= {}
    @has_content[name] = true
    super(name, content, &block)
  end

  # 
  def has_content?(name)
    (@has_content && @has_content[name]) || false
  end
  
  # 現在のページにサイドバーが含まれているかどうか。
  def sidebar_content?
    has_content? :sidebar
  end
end
