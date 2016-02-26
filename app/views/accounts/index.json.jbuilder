json.array!(@accounts) do |account|
  json.extract! account, :id, :status_text, :percent, :created_at, :updated_at
  json.url account_url(account, format: :json)
end
