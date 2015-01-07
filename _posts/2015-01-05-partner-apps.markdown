---
layout: post
title : "Partner Apps"
date: 2015-01-05
author: Anthony Ross
categories: validic partner
---

##Getting started

The purpose of this post is two fold - 1.)  register yourself as a Partner Application in Validic and 2.) use the [Validic Ruby Gem](https://github.com/validic/validic).

#Why Validic Connect
Validic Connect was developed for app developers by app developers.  Registering your app with Validic will allow existing Validic users to see your app in our marketplace exposing your app to the millions of users we have.  Typically an organization like Fitbit already has an API that we are able to integrate into Validic.

Validic Connect does not require you have a standard API but instead allows you to POST data to Validic on behalf of users that request it.  We've written libraries in numerous languages to make this process as easy as possible.


#Registration and Obtaining your Credentials

In order to get started your application must be registered with us. To apply please go [here](https://validic.com/labs) and click on 'request developer account'.

Registration requires:

1. Your company name
2. Your app name
3. Authorization URL
  * our marketplace will need a link to your app so users can connect to it, see below for more information
4. Link to your data sharing Terms and Conditions
5. Link to your privacy policy
6. Your support email address
7. Application icon
  * jpg, jpeg, png, gif in 200 x 200 no more than 30kb
8. Which of our objects you plan to implement with
  * fitness, routine, nutrition, weight, sleep, diabetes, biometrics, tobacco_cessation
9. Short description of your application
10. Long description of your application

Once approved, you will receive back from us 3 things:

1. Authorization Signature
2. Organization ID
3. Organization Access Token


Authorization URL:

The Authorization URL is a defined resource in your application where Validic will redirect users who make authorization requests from third-party applications. Once received, your application must process this request, but you are free to define how your application will handle the authorization request. Typically, this would be a user login or sign up in your application.

We'll showcase a good method for implementing this in your app in a later section.

The authorization request is a 302 Redirect to your provided Authorization URL that includes a signature and sync_url. You must temporarily retain these information, such as storing in a session, for a later callback.

So all that means is your authorization page should be RESTful and look something like this:

{% highlight bash %}

https://yourdomain.com/validic/your_authorization_url?signature={VALIDIC_AUTH_SIGNATURE}&sync_url={VALIDIC_SYNC_PATH}

{% endhighlight %}

Once your application has processed the authorization (such as the user has successfully logged in), you must then make a POST request to the provided sync_url with the signature and your user's uid. You'll learn more about user's UID in the User Provisioning section below.

Once registered you may proceed below.

#Install the gem

Now that you have your organizations partner app credentials you can begin to use our libraries.

In ruby, you can add the gem to your Gemfile

{% highlight ruby %}
gem 'validic'
{% endhighlight %}

then run `bundle install`


#Set Up Your Application

If you're using a rails app we recommend storing your organization credentials into environment variables using something like [dotenv-rails.](https://github.com/bkeepers/dotenv)
We also recommend setting up an initializer for the gem so your calls automatically contain your organization's credentials.  In rails that would look like this(`config/initializers/validic.rb`)

{% highlight ruby %}
Validic.configure do |config|
  config.api_url        = 'https://api.validic.com'
  config.api_version    = 'v1'
  config.organization_id = ENV['VALIDIC_ORG_ID']
  config.access_token = ENV['VALIDIC_ACCESS_TOKEN']
end
{% endhighlight %}

Subsequently this requires you create a `.env` file with your credentials:

{% highlight ruby %}
VALIDIC_ORG_ID=YOUR_ORG_ID_HERE
VALIDIC_ACCESS_TOKEN=YOUR_ACCESS_TOKEN_HERE
{% endhighlight %}


#Add an Authorization Page

We've set up a fake partner application call HealthYet that now exists in our marketplace.  When a user clicks 'Connect' (as show in the screenshot below), they will land on your authorization page.

![marketplace]({{ sit.url}}/validic/assets/marketplace.jpg)

We set up the HealthYet authorization page in a two step process.  When a user clicks connect, they are redirected to the authorization URL we mentioned above.  For HealthYet that looks like:

{% highlight bash %}
https://healthyyet.herokuapp.com/authorize?signature=Mjg5MGVjMmIwODYzMzAyZTE1NzEwNDljZWJkMWE4MWFlYmQxODk1MWM3Nzg1YTAyNjRjNjBkMmU4ZTVlYzM4OS01NGFkNjU1ODU3ZmIzNWI4ZDUwMDZkYTktL2F1dGhvcml6ZXMvbmV3&sync_url=https://app.validic.com/authorization/new
{% endhighlight %}

Step 1 is we require the user login:

![login]({{ sit.url}}/validic/assets/login.jpg)

Step 2 comes from Validic, we ask the user to explicitly make the connection between the customers organization (here: VMS Healthcare) and your application (the page below is provided by Validic):

![auth]({{ sit.url}}/validic/assets/auth.jpg)

#First Steps - User Provisioning

In order to send your users data you must provision users in Validic.  Provisioning users is a critical step, you will be unable to post data without first provisioning.  In essence, provisioning users is simply creating a user in the Validic database.

We recommend that you provision users once they authorize you to share their data in our marketplace.  The only required field for provisioning users is a unique ID that you provide as a string.  Provisioning users looks like this:

{% highlight ruby %}
client = Validic::Client.new
response = client.provision_user('YourUniqueIDAsAString')
{% endhighlight %}

That response will look like this:

{% highlight json %}
{
  "code": 201,
  "message": "Ok",
  "user": {
    "_id": "{USER_ID}",
    "access_token": "{USER_ACCESS_TOKEN}"
  }
}
{% endhighlight %}

You need to store the `_id` and `access_token` in your database (this information is unique to each user) as we'll use that information in the forthcoming POST calls. The entire provision user method might look like this:

{% highlight ruby %}
class User < ActiveRecord::Base
  def provision_validic
    client = Validic::Client.new
    self.uid = SecureRandom.urlsafe_base64 #random string
    resp = client.user_provision(organization_id: ENV['VALIDIC_ORG_ID'],
                                 uid: uid)
    self._id = resp.user._id
    self.access_token = resp.user.access_token
    self.save
  end
end

user = User.find(18) #find the user who just authorized
user.provision_validic #provision in Validic
{% endhighlight %}

#Posting Data to Validic

We're going to assume that once a user has authorized their data be shared with Validic you want to immediately send all new data of that users to Validic.  For instance, let's say we have an Activity class that once new data has been validated and saved on your server, it should also be pushed to Validic.  You can use a `after_save` hook in rails to do just that:

{% highlight ruby %}
class Activity < ActiveRecord::Base
  validates :steps, presence: true
  belongs_to :user
  after_save :push_to_validic

  def push_to_validic
    #you can do some check here to make sure user has authorized sending data to Validic
    client = Validic::Client.new
    Validic.user_id = self.user._id # we have this _id from the provision call above
    client.post_to_validic("routine", { routine: {
        timestamp: DateTime.now.utc.to_s(:iso8601),
        steps: self.steps,
        activity_id: self.unique_activity_id,
        extras: "{ \"points\": 10}"
      }
    })
  end
end
{% endhighlight %}

If a new activity is created here, it will send information to Validic using the generic `post_to_validic` method which takes the object we're posting (in this case 'routine') and sends in hash of fields.

