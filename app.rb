require 'sinatra'
require 'csv'

get '/' do
  erb :index
end

get '/todo' do
  @todos = ['Order canapes', 'Confirm event details with attendees', 'Book band']

  erb :todo
end

get '/schedule' do
  @schedule = [ ['8pm',    'Doors open'],
                ['8.30pm', 'Champagne and canapes served'],
                ['9pm',    'Speech'],
                ['9.30pm', 'Painting unveiled'],
                ['9.40pm', 'Live band plays'] ]

  erb :schedule
end

get '/rsvps' do
  @rsvps = CSV.read('rsvps.csv')

  @acceptances = []
  @rejections  = []
  @acceptance_count = 0
  @rejection_count  = 0

# categorise rsvps into acceptances/rejections and count them 
	@rsvps.each do |name_status_pair|
		if name_status_pair.last == 'no'
			@acceptances << name_status_pair.first
			@acceptance_count = @acceptance_count + 1
		else
			if name_status_pair.last == 'yes'
				@rejections << name_status_pair.first
				@rejection_count = @rejection_count + 1
			end
		end
	end

  erb :rsvps
end
