namespace :api do
  desc 'routes'
  task routes: :environment do
    V1::API.routes.each do |api|
      method = api.request_method.ljust(8)
      if api.version
        path = api.path.gsub(':version', api.version).ljust(55)
      else
        path = api.path.ljust(55)
      end
      description = api.description
      puts "     #{method} #{path} #{description}"
    end
  end
end