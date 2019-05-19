# Contractor management

Details
- Ruby version - 2+
- System dependencies - 
- Configuration - 
- Database creation - Create a SQLite DB that will be empty
- Database initialization - None
- How to run the test suite - chef exec bundle exec rake
- Services (job queues, cache servers, search engines, etc.) - None
- Deployment instructions - PaaS

## PaaS setup:
- CONTRACTOR_MANAGEMENT_EMAIL is the return email address in the emails
- CONTRACTOR_MANAGEMENT_SECRET is the application secret key

## PaaS Scalr Feature Setup
### Development Support
- APPLICATION_EMAIL = This can be any email the developer enters. 
- APPLICATION_SECRET =  eFUFeHaHt/aQ04FrE/xqKzah2RW7d36tt3HoAjIdLklIhPE7p929x+r34W/V\nMzXDgqa+mt4/t9QERDBprw11DB72fp2m5ewtkvtnKYgPPTtNlkJP42TfIgZN\nZmIBw1Gt2tl+X5o4AbD23GeazLzlC4oGuj0mVzoxcVaeNy4Gtsd4MK/8SIYR\nxmiv8roolIl8

### QA Support
- APPLICATION_EMAIL = user of the QA team.
- APPLICATION_SECRET =  eFUFeHaHt/aQ04FrE/xqKzah2RW7d36tt3HoAjIdLklIhPE7p929x+r34W/V\nMzXDgqa+mt4/t9QERDBprw11DB72fp2m5ewtkvtnKYgPPTtNlkJP42TfIgZN\nZmIBw1Gt2tl+X5o4AbD23GeazLzlC4oGuj0mVzoxcVaeNy4Gtsd4MK/8SIYR\nxmiv8roolIl8

### Production Support 
- APPLICATION_EMAIL = gpscarriers@gannett.com 
- APPLICATION_SECRET =
- URL = deliveryopportunities.gannett.com

### Application info
- Added support for email
- Initializer carrier_recruitment.rb

<tt>rake doc:app</tt>.
