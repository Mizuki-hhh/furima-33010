crumb :root do
  link "Home", items_index_path
end

crumb :item do |item|
  link "商品詳細", item_path(item)
  parent :root, item
end

crumb :record do |item|
  link "商品購入", item_records_path(item)
  parent :item, item
end

crumb :edit do |item|
  link "商品編集", edit_item_path(item)
  parent :item, item
end

crumb :user_new do
  link "新規登録", new_user_registration_path
  parent :root
end

crumb :login do |user|
  link "ログイン", new_user_session_path(user)
  parent :root, user
end

crumb :putup do
  link "商品出品", new_item_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).