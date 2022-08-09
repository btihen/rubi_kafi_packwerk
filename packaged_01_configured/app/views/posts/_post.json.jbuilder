json.extract! post, :id, :content, :user_id, :created_at, :updated_at
json.url blog_url(post, format: :json)
