require 'sinatra'


configure do
  set :views, settings.root + '/views'
end

get '/' do
  links = ['memory', 'disk']
  erb :home, layout: :index, locals: { links: links }
end

get '/memory' do
  memory = `vm_stat`[/Pages free:\W+(\d+)/] + " MB"
  erb :memory, layout: :index, locals: { memory: memory }
end

get '/disk' do
  disk = `df -hl | grep 'disk1' | awk '{sum+=$4} END{print sum}' | column -t` + " GB"
  erb :disk, layout: :index, locals: { disk: disk }
end

