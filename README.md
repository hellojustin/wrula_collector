# The WRULA Collector

[![Build Status](https://travis-ci.org/hellojustin/wrula_collector.svg?branch=master)](https://travis-ci.org/hellojustin/wrula_collector)

The WRULA Collector is a very lightweight Rack application that allows website
owners to instrument their pages with WRULA Metrics using just a single line of
code:

```html
  <script async src='http://wrulametrics.com/js/wrula.js' data-wrula-account-id='8675309'></script>
```

What do those attributes mean?

- **async:** Makes loading this script a non-blocking operation. The browser will
continue to parse and render the page as this script loads. This minimizes the
impact to page performance.
- **src:** This points to the script that will actually collect data about the
page and the browser, and send it off the the WRULA collector.
- **data-wrula-account-id:** That's a mouthful. This is the id number of the
WRULA metrics account that will own the data collected from this page. Site
owners can get this number when they log into their WRULA Metrics account.

Visit the [example user page](http://wrulametrics.com/sample_user_page.html)
to witness the script in action. *Tip:* open your browser console, inspect the DOM,
watch the network traffic, take a look the cookies, and confirm how unobtrusive
the JavaScript is.

### Components

The WRULA Collector consists of two components:

- wrula.js, the javascript used to instrument pages, as described above, and
- a lightweight rack app (built with [Scorched](http://scorchedrb.com)) that
receives data from wrula.js and persists it to DynamoDB.

Each of these will be discussed in a little more detail below.

### Development Setup Instructions

Requirements: The WRULA Collector project requires
[Ruby 2.0.0 or greater](https://www.ruby-lang.org/en/downloads/), and
[NodeJS](http://nodejs.org/download/). It's best to install each using your
platform's package management system.

1. Pull down the source.

   If you're reading this on GitHub, you might've guessed that the WRULA
   Collector source code is managed using Git. Go ahead and clone the repo:

   ```Shell
     git clone git@github.com:hellojustin/wrula_collector.git
   ```

2. Install all the gems.

   This project doesn't depend on a boatload of gems, but there are a few.

   ```Shell
     bundle install
   ```

3. Install the RequireJS optimizer.

   The Javascript in this project follows the Asynchronous Module Definition
   pattern. To compile it all down to one file, we need to have r.js installed.

   ```Shell
     npm install requirejs
   ```

4. Compile wrula.js

   Now that we have r.js available, we can compile a fresh version of wrula.js.
   You don't have to run r.js directly. We've wrapped it in a Rake task:

   ```Shell
     rake require_js
   ```

5. Run the tests.

   The Ruby test harness for the WRULA Collector is built with MiniTest::Spec.
   To run the tests use the following command:

   ```Shell
     rake test
   ```

   Javascript tests are coming soon!

6. Run the app.

   Scorched allows you to run the app at `http://localhost:9292` with a simple
   command:

   ```Shell
     rackup config.ru
   ```

   The WRULA Collector can run easily on any application server that supports Rack.
   We recommend [Pow](http://pow.cx).


### Provisioning and Deploying to Production

The WRULA Collector uses the Rubber gem to manage its production infrastructure.
Rubber is a suite of Capistrano tasks that make it easy to provision and manage
Amazon EC2 instances, deploy to them, and debug the app in production. The notes
below include some Rubber-specific lingo.

The WRULA Collector project is vulcanized with the role 'complete_passenger'.
You'll probably never have to re-vulcanize the project, but in case you do, just
run:

```Shell
  rubber vulcanize complete_passenger
```

To interact with EC2, you'll need an AWS key_pair. Contact Justin Molineaux for
that.

To create an EC2 instance that will run the WRULA Collector, execute these
commands:

```Shell
  cap rubber:create
  cap rubber:bootstrap
```

The `rubber:bootstrap` command may run for a while. It installs a number of
packages on the server and compiles Ruby from source. Once it's finished, you can
deploy code to production with:

```Shell
  cap deploy
```


### Additional notes

- The version of jQuery included into wrula.js is actually a custom jQuery build
that only includes $.ajax(). Soon we'll work this into the Javascript compilation
process.

- Scorched does not provide multi-environment configuration out-of-the-box. So
although you're running the app locally, wrula.js and the AWS gem are pointing at
production.
