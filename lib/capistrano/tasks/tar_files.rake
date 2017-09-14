# Task to create and unpack tarball archives during deployment.
# Useful node_modules, vendor directories etc that don't usually change per deployment.

namespace :deploy do
    task :unpack_archives do
        next unless any? :tar_files
        on roles :app do
            fetch(:tar_files).each do |path|
                archive_file = "#{deploy_to}/#{fetch(:tar_location)}/#{path.gsub("/", "_")}.tar"
                unpack_dir = "#{release_path.to_s}/#{path}"

                if test "[ -f #{archive_file} ]"
                    execute :mkdir, "-p", unpack_dir
                    execute :tar, fetch(:tar_unpack_flags), archive_file, "-C " + unpack_dir
                else
                    warn "#{archive_file} does not exist. Skipping unpacking."
                end
            end
        end
    end

    task :create_archives do
        next unless any? :tar_files
        on roles :app do
            execute :mkdir, "-p", "#{deploy_to}/#{fetch(:tar_location)}"
            fetch(:tar_files).each do |path|
                if test "[ -r #{current_path.to_s}/#{path} ]"
                    execute :tar, fetch(:tar_create_flags), "#{deploy_to}/#{fetch(:tar_location)}/#{path.gsub("/", "_")}.tar", "-C #{current_path.to_s}/#{path} ."
                else
                    warn "#{current_path.to_s}/#{path} does not exist. Skipping creating archive."
                end
            end
        end
    end

    task :updating do
        invoke "deploy:unpack_archives"
    end
    before :publishing do
        invoke "deploy:create_archives"
    end
end

namespace :load do
    task :defaults do
        set :tar_files, []
        set :tar_location, "tarballs"
        set :tar_unpack_flags, "xf"
        set :tar_create_flags, "cf"
    end
end
