# frozen_string_literal: true
require './db/config'
require './app/models/author'
require './app/models/book'
require './app/models/serie'
require './app/sluggify'

# Help creating slugs
def sluggify_params(field_to_sluggify, params)
  params.merge(slug: Sluggify.sluggify(params[field_to_sluggify]))
end

# Seed data to get the app started.
Serie.destroy_all
Book.destroy_all
Author.destroy_all

sanderson = Author.create(sluggify_params(:name, name: 'Brandon Sanderson'))
martin = Author.create(sluggify_params(:name, name: 'George R. R. Martin'))

mistborn = Serie.create(sluggify_params(:title, title: 'Mistborn'))
ice_and_fire = Serie.create(sluggify_params(:title,
                                            title: 'A Song of Ice and Fire'))

Book.create(sluggify_params(:title, title: 'Elantris', author: sanderson))
Book.create(sluggify_params(:title, title: 'The Final Empire',
                                    author: sanderson, serie: mistborn,
                                    position: 1))
Book.create(sluggify_params(:title, title: 'The Well of Ascension',
                                    author: sanderson, serie: mistborn,
                                    position: 2))
Book.create(sluggify_params(:title, title: 'The Hero of Ages',
                                    author: sanderson, serie: mistborn,
                                    position: 3))

Book.create(sluggify_params(:title, title: 'A Game of Thrones',
                                    author: martin, serie: ice_and_fire,
                                    position: 1))
Book.create(sluggify_params(:title, title: 'A Clash of Kings',
                                    author: martin, serie: ice_and_fire,
                                    position: 2))
Book.create(sluggify_params(:title, title: 'A Storm of Swords',
                                    author: martin, serie: ice_and_fire,
                                    position: 3))
Book.create(sluggify_params(:title, title: 'A Feast for Crows',
                                    author: martin, serie: ice_and_fire,
                                    position: 4))
Book.create(sluggify_params(:title, title: 'A Dance with Dragons',
                                    author: martin, serie: ice_and_fire,
                                    position: 5))
