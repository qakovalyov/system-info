require 'sinatra'
require 'mongoid'
require 'json'
require 'pry'


Mongoid.load!('config/mongoid.yml')
require './models/systemInfo'


configure do
  set :views, settings.root + '/views'
end

get '/' do
  @links = [ 'memory', 'disk' ]
  @info = SystemInfo.all
  erb :home, layout: :index
end


get '/:task' do |task|
  @report = task.to_sym

  @data = case task
  when 'memory'
    `vm_stat`[/Pages free:\W+(\d+)/] + " MB"
  when 'disk'
    `df -hl | grep 'disk1' | awk '{sum+=$4} END{print sum}' | column -t` + " GB"
  else
    false
end
  SystemInfo.new(@report => @data).save if @data
  erb :report, layout: :index
end

get '/delete/all' do
  SystemInfo.delete_all
  'The old data was successfully deleted!'
end