namespace :app do

    desc 'Tail remote log files'
    task :logs do
        on roles :app do
            logfile = ENV['LOG'] || fetch(:rails_env)
            execute %(tail -n0 -F #{shared_path}/log/#{logfile}.log | while read line; do echo "$(hostname): $line"; done)
        end
    end

end