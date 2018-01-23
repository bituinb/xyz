# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

# just add one record ; this is just for proving resque job fails with PG:ConnecitionBad
Account.destroy_all
Account.create(code: 'Star Wars')
Account.create(code: 'Lord of the rings')


