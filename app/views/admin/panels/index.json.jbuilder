json.array!(@admin_panels) do |admin_panel|
  json.extract! admin_panel, :id, :title, :desc, :weight
  json.url admin_panel_url(admin_panel, format: :json)
end
