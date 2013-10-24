Low Fire Danger Bootstrap
=========================

This project provides a good base for most ruby on rails projects.

Some things to do before using it on a project:

- Search and replace all instances of 'lfd_bootstrap' and 'LfdBootstrap'
- in 'config/environments/production.rb', change 'config.action_mailer.default_url_options' url
- Make sure to set up the correct keys for AWS in amazon_ses.rb
- Change config.mailer_sender in devise.rb to be the appropriate email address