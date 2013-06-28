assert   = require 'assert'
_        = require 'underscore'
Backbone = require 'backbone'
Comparator = require '../backbone.comparator'

data = [
  { id:1, name:'a d', rating: 1 }
  { id:2, name:'b c', rating: 2 }
  { id:3, name:'c b', rating: 3 }
  { id:4, name:'d a', rating: 2 }
]

Backbone.Model.prototype.lastName = -> @get('name').split(' ')[1]
_.extend Backbone.Collection.prototype, Comparator
collection = new Backbone.Collection()
collection.order = 'name'

describe 'Backbone.Comparator', ->
  beforeEach ->
    collection.reset _.shuffle(data)

  it 'defaults to ASC', ->
    collection.order = 'name'
    collection.sort()

    assert.equal 'a d', collection.first().get('name')
    assert.equal 'd a', collection.last().get('name')

  it 'sorts by DESC', ->
    collection.order = 'name DESC'
    collection.sort()

    assert.equal 'd a', collection.first().get('name')
    assert.equal 'a d', collection.last().get('name')

  it 'allows for a fallback attribute if tied', ->
    collection.order = 'rating DESC, id'
    collection.sort()

    assert.equal 3, collection.at(0).id
    assert.equal 2, collection.at(1).id
    assert.equal 4, collection.at(2).id
    assert.equal 1, collection.at(3).id

  it 'allows for ordering by function on the model', ->
    collection.order = '@lastName'
    collection.sort()

    assert.equal 4, collection.at(0).id
    assert.equal 3, collection.at(1).id
    assert.equal 2, collection.at(2).id
    assert.equal 1, collection.at(3).id



