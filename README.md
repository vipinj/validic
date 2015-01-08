# Validic #

## Build Status
[![Codeship Status for Validic/validic](https://www.codeship.io/projects/cc4ff330-9f72-0130-3cf3-0e5a3e2104f7/status?branch=master)](https://www.codeship.io/projects/3456)

## Stable Version: 1.0.0

Ruby API Wrapper for [Validic](http://www.validic.com). It includes the
following functionality:

## Breaking Changes ##
- Methods for user provisioning, suspending, and deleting have been renamed
- Methods will now default to initialized values unless overridden in options

### Organization ###
- Organization metadata

### Users ###
- Provision new Validic users
- Update, Suspend, or Delete users
- Get users from organization credentials
- Find user id from authentication token
- Refresh user authentication token

### Profiles ###
- Get profile information from user authentication token
- Create and modify user profiles

### Apps ###
- List available third party apps
- List synced apps for a particular user

### Activities ###
- Fitness, Routine, Nutrition, Sleep, Weight, Diabetes, Biometrics, Tobacco
  Cessation
- Get activities scoped to user or organization
- Activities from specific sources
- Specified time ranges

### Connect ###
- Create activities as a Validic Connect partner
- Post extra data

### Latest Endpoint ###
- Get latest data recorded, regardless of when the activity occurred
- Scope to organization or user level
- Specify start and end points

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
```

# Create a Client Object provided you have an initializer
```ruby
validic = Validic::Client.new
```

### If you're using plain RUBY
### Create Validic::Client Object
```ruby
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

You can override initialized organization id and access tokens for all helper
methods by passing parameters in an options hash as a final parameter.

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
```

#   Organization methods

### Get current organization
```ruby
validic.get_organization
```

#   User methods

### Get users from organization credentials
```ruby
validic.get_users
```

###### Get user id from authentication token
```ruby
validic.me('USER_AUTHENTICATION_TOKEN')
```

### Provision new users
```ruby
validic.provision_user('UNIQUE_USER_ID')
```

### Updating a user
```ruby
validic.provision_user('VALIDIC_USER_ID', options)
```

### Suspend a user
```ruby
validic.suspend_user('VALIDIC_USER_ID')
```

### Unsuspend a user
```ruby
validic.unsuspend_user('VALIDIC_USER_ID')
```

### Refresh authentication token
```ruby
validic.refresh_token('VALIDIC_USER_ID')
```

### Delete a user
```ruby
validic.delete_user('VALIDIC_USER_ID')
```

#   Profile methods

### Get a user profile
```ruby
validic.get_profile('USER_AUTHENTICATION_TOKEN')
```

### Create a user profile
```ruby
validic.create_profile('USER_AUTHENTICATION_TOKEN', options)
```

#   Apps methods

### Get a list of available third-party-apps
```ruby
validic.get_apps
```

### Get a list of apps a user is synced to
```ruby
validic.get_synced_apps('USER_AUTHENTICATION_TOKEN')
```

#   Activity methods

### You can also filter the results of the following methods by passing an options hash

### Get an array of fitness records
```ruby
validic.get_fitness
```

### Get an array of routine records
```ruby
validic.get_routine
```

### Get an array of nutrition records
```ruby
validic.get_nutritions
```

### Get an array of weight records
```ruby
validic.get_weight
```

### Get an array of diabetes records
```ruby
validic.get_diabetes
```

### Get an array of biometrics records
```ruby
validic.get_biometrics
```

### Get an array of sleep records
```ruby
validic.get_sleep
```

### Get an array of tobacco cessation records
```ruby
validic.get_tobacco_cessations
```

#   Connect methods

# Connect helper methods are only available for apps registered with
# Validic Connect

### Fitness
```ruby
validic.create_fitness('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', options)
validic.update_fitness('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_fitness('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Routine
```ruby
validic.create_routine('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', options)
validic.update_routine('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_routine('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Nutrition
```ruby
validic.create_nutrition('VALIDIC_USER_ID', 'UNIQUE_ENTRY_ID', options)
validic.update_nutrition('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_nutrition('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Weight
```ruby
validic.create_weight('VALIDIC_USER_ID', 'UNIQUE_DATA_ID', options)
validic.update_weight('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_weight('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Diabetes
```ruby
validic.create_diabetes('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', options)
validic.update_diabetes('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_diabetes('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Biometrics
```ruby
validic.create_biometric('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', options)
validic.update_biometric('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_biometric('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Sleep
```ruby
validic.create_sleep('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', options)
validic.update_sleep('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_sleep('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### Tobacco Cessation
```ruby
validic.create_tobacco_cessation('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID' options)
validic.update_tobacco_cessation('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID', options)
validic.delete_tobacco_cessation('VALIDIC_USER_ID', 'VALIDIC_ACTIVITY_ID')
```

### You can also create data with your own custom extras as JSON
```ruby
validic.create_fitness('VALIDIC_USER_ID', 'UNIQUE_ACTIVITY_ID', extras: "{\"stars\": 3}")
```

###
#   Latest Records
###

### You can also pass an options hash to filter latest results

### Pull latest records for specified type
```ruby
validic.latest('routine')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
