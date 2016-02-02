json.array!(@bookings) do |booking|
  json.extract! booking, :id, :user_id, :job_id, :acceptance
  json.url booking_url(booking, format: :json)
end
