# Validic #

## Build Status
[![Codeship Status for Validic/validic](https://www.codeship.io/projects/cc4ff330-9f72-0130-3cf3-0e5a3e2104f7/status?branch=master)](https://www.codeship.io/projects/3456)

## Stable Version: 0.3.2

Ruby API Wrapper for [Validic](http://www.validic.com). It includes the
following functionality:

### Organization ###
- General information on organization
- Summary object of response
- Organization metadata

### Users ###
- Provision new Validic users
- Update or Suspend users
- Delete users
- Get users from organization credentials
- Find user id from authentication token
- Refresh user authentication token **Not yet implemented**

### Apps ###
- List available third party apps
- List synced apps for a particular user

### Profiles ###
- Get profile information from authentication token
- Create new profiles **Not yet implemented**

### Activities ###
- Fitness, Routine, Nutrition, Sleep, Weight, Diabetes, Biometrics, Tobacco
  Cessation
- Get activities scoped to user or organization
- Create activities **In progress**
- Activities from specific sources
- Specified time ranges
- Expanded data

### Latest Endpoint ###
- Latest data recorded, regardless of when the activity occurred
- Between designated start and end points

## Installation

Add this line to your application's Gemfile:

    gem 'validic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validic

## Usage

First, instantiate the client.
```ruby
require 'validic'

# If you're using Rails 3+
# config/initializers/validic.rb
Validic.configure do |config|
  config.api_url          = 'https://api.validic.com'
  config.api_version      = 'v1'
  config.access_token     = 'ORGANIZATION_ACCESS_TOKEN',
  config.organization_id  = 'ORGANIZATION_ID'
end

# Create a Client Object provided you have an initializer
validic = Validic::Client.new

# If you're using plain RUBY
# Create Validic::Client Object
options = {
  api_url:         'https://api.validic.com',
  api_version:     'v1',
  access_token:    'ORGANIZATION_ACCESS_TOKEN',
  organization_id: 'ORGANIZATION_ID'
}
validic = Validic::Client.new options
```

Now you can use the wrapper's helper methods to interface with the Validic API.
```ruby
# Get current organization metadata
validic.get_organization
```

The wrapper returns the JSON response as a [Hashie::Mash](https://github.com/intridea/hashie#mash) instance for easy
manipulation.
```ruby
# Get an array of apps for my current organization
validic.get_apps.apps.map(&:name)
```

You can pass a hash of options to calls that fetch data.
```ruby
validic.get_routine(start_date: '2015-01-01T00:00:00+00:00')
```

### More Examples ###

Below are examples of all helper methods.

```ruby
require 'validic'

# Alternatively you can use an initializer
options = {
  api_url:         'https://api.validic.com',
  api_version:     'v1',
  access_token:    'ORGANIZATION_ACCESS_TOKEN',
  organization_id: 'ORGANIZATION_ID'
}
validic = Validic::Client.new options

###
#   Organization methods
###

# Get current organization
validic.get_organization

# Get organization by organization_id and access_token
validic.get_organization(organization_id: 'ORGANIZATION_ID',
                         access_token: 'ORGANIZATION_ACCESS_TOKEN')

###
#   User methods
###

# Get users from organization credentials
validic.get_users(organization_id: 'ORGANIZATION_ID',
                  access_token: 'ORGANIZATION_ACCESS_TOKEN')

# Get user id from authentication token (WIP)
validic.me(authentication_token: 'USER_AUTHENTICATION_TOKEN')

# Provision new users
validic.user_provision(organization_id: 'ORGANIZATION_ID',
                       uid: 'UNIQUE_USER_ID')

# Suspend a user
validic.user_suspend(organization_id: 'ORGANIZATION_ID',
                     user_id: 'VALIDIC_USER_ID',
                     suspend: 1)

# Delete a user
validic.user_delete(organization_id: 'ORGANIZATION_ID',
                    uid: 'UNIQUE_USER_ID'

###
#   Profile methods
###

# Get a user profile (WIP)
validic.get_profile(authentication_token: 'USER_AUTHENTICATION_TOKEN')

###
#   Apps methods
###

# Get a list of available third-party-apps
validic.get_apps

# Get a list of apps a user is synced to
validic.get_synced_apps(authentication_token: 'USER_AUTHENTICATION_TOKEN')

###
#   Activity methods
###

# Get an array of fitness records
validic.get_fitness

# Get an array of routine records
validic.get_routine

# Get an array of nutrition records
validic.get_nutritions

# Get an array of weight records
validic.get_weight

# Get an array of diabetes records
validic.get_diabetes

# Get an array of biometrics records
validic.get_biometrics

# Get an array of sleep records
validic.get_sleep

# Get an array of tobacco cessation records
validic.get_tobacco_cessations

###
#   Latest method
###

# Pull latest records for specified type
validic.latest('routine')

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
