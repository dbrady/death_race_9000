json.array!(@time_entries) do |time_entry|
  json.extract! time_entry, :id, :user_id, :task_id, :description, :hours
  json.url time_entry_url(time_entry, format: :json)
end
