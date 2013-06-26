assert   = require 'assert'
_        = require 'underscore'
Backbone = require 'backbone'
Comparator = require '../sortable'

_.extend Backbone.Collection.prototype, Comparator
collection = new Backbone.Collection()
_.extend Backbone.Collection.prototype, Comparator


describe 'Backbone.Comparator', ->
  describe 'sort by attribute', ->
    data = [
      { id: 1, name: 'A' }
      { id: 2, name: 'B' }
      { id: 3, name: 'C' }
    ]

    beforeEach ->
      collection.reset _.shuffle(data)

    it 'foo', -> console.log collection.foo()

    #it 'defaults to ASC', ->
      #collection.order = 'name'
      #collection.sort()

      #assert.equal 'A', collection.at(0).get('name')
      #assert.equal 'B', collection.at(1).get('name')
      #assert.equal 'C', collection.at(2).get('name')

    #it 'sorts by DESC', ->
      #collection.order = 'name DESC'
      #collection.sort()

      #assert.equal 'A', collection.at(2).get('name')
      #assert.equal 'B', collection.at(1).get('name')
      #assert.equal 'C', collection.at(0).get('name')


    #describe 'sort with fallback', ->
      #data = [
        #{ id: 1, name: 'A' }
        #{ id: 2, name: 'A' }
        #{ id: 3, name: 'A' }
      #]

    #beforeEach ->
      #collection = new Backbone.Collection _.shuffle(data)
      #_.extend collection, Backbone.Comparator

    #it 'allows for a fallback attribute if tied', ->
      #collection.order = 'name, id'
      #collection.sort()

      #assert.equal 1, collecion.at(0)
      #assert.equal 2, collecion.at(1)
      #assert.equal 3, collecion.at(2)



