bundle install

npm install r.js

r.js -o config/almond_config.js 

or, for easier debugging:

r.js -o config/almond_config.js optimize=none



project is vulcanized with base, apache, & passenger


To create an instance:
bx cap rubber:create

instance roles : web,app

then..

bx cap rubber:bootstrap

then to deploy code:

bx cap deploy


Connecting with AWS:

set access_key_id and secret_access_key in config/aws.rb
