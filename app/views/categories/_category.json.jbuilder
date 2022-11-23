json.extract! category, :id, :icon, :name, :created_at, :updated_at
json.url category_url(category, format: :json)
json.icon url_for(category.icon)
