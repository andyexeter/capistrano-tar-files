capistrano-tar-files
=====================

Capistrano v3.* extension to speed up deployments by creating and unpacking tarball archives
for directories which don't change much between releases e.g `vendor` (Composer) and `node_modules` (npm/yarn)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.3.0'
gem 'capistrano-tar-files'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-tar-files

## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/tar_files'
```

Tarballs are unpacked during `deploy:updating` and created during `deploy:finishing` as part of Capistrano's default deploy

Configurable options:

```ruby
set :tar_files, []                       # default
set :tar_location, "tarballs"            # default
set :tar_unpack_flags, "xf"              # default
set :tar_create_flags, "cf"              # default
```

## Example
```ruby
# Create and unpack tarballs for these directories between releases
set :tar_files, ['vendor', 'node_modules', 'web/assets']
```

## Prior Art

This extension was inspired by [capistrano-copy-files](https://github.com/capistrano/copy-files)

## License

Released under the [MIT license](LICENSE)
