# frozen_string_literal: true
require './db/config'
require './app/models/author'
require './app/models/book'
require './app/models/serie'

# Seed data to get the app started.
Serie.destroy_all
Book.destroy_all
Author.destroy_all

sanderson = Author.create(name: 'Brandon Sanderson')
martin = Author.create(name: 'George R. R. Martin')

mistborn = Serie.create(title: 'Mistborn')
ice_and_fire = Serie.create(title: 'A Song of Ice and Fire')

Book.create(title: 'Elantris', author: sanderson)
Book.create(title: 'The Final Empire', author: sanderson, serie: mistborn)
Book.create(title: 'The Well of Ascension', author: sanderson, serie: mistborn)
Book.create(title: 'The Hero of Ages', author: sanderson, serie: mistborn)

Book.create(title: 'A Game of Thrones', author: martin, serie: ice_and_fire)
Book.create(title: 'A Clash of Kings', author: martin, serie: ice_and_fire)
Book.create(title: 'A Storm of Swords', author: martin, serie: ice_and_fire)
Book.create(title: 'A Feast for Crows', author: martin, serie: ice_and_fire)
Book.create(title: 'A Dance with Dragons', author: martin, serie: ice_and_fire)
