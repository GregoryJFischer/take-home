# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tea.create(title: 'Earl Grey', description: 'black tea', brew_time: 180, temperature: 90)
Tea.create(title: 'Green', description: 'green tea', brew_time: 150, temperature: 85)
Tea.create(title: 'Camomile', description: 'herbal tea', brew_time: 300, temperature: 70)

Customer.create(email: 'test@example', first_name: 'Greg', last_name: 'Fischer', address: '123 example st')
