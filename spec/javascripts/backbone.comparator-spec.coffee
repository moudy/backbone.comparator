describe 'backbone.comparator', ->
  collection = null

  describe 'attribute ordering', ->
    beforeEach ->
      data = [ { id: 1, name: 'B' }
               { id: 3, name: 'A' }
               { id: 2, name: 'C' } ]
      collection = new Backbone.Collection(data)

    it 'orders by attribute', ->
      collection.order = 'name'
      collection.sort()

      expect(collection.at(0).get('name')).toEqual('A')
      expect(collection.at(1).get('name')).toEqual('B')
      expect(collection.at(2).get('name')).toEqual('C')

    it 'orders by attribute in descending order', ->
      collection.order = 'name desc'
      collection.sort()

      expect(collection.at(0).get('name')).toEqual('C')
      expect(collection.at(1).get('name')).toEqual('B')
      expect(collection.at(2).get('name')).toEqual('A')

  describe 'attribute ordering with fallback', ->
    beforeEach ->
      data = [ { id: 1, name: 'A', price: 3 }
               { id: 3, name: 'C', price: 2 }
               { id: 2, name: 'A', price: 3} ]
      collection = new Backbone.Collection(data)

    it 'orders by attribute with a fallback', ->
      collection.order = 'name, id'
      collection.sort()

      expect(collection.at(0).id).toEqual(1)
      expect(collection.at(1).id).toEqual(2)
      expect(collection.at(2).id).toEqual(3)

    it 'orders by attribute with multiple fallbacks', ->
      collection.order = 'name, price, id'
      collection.sort()

      expect(collection.at(0).id).toEqual(1)
      expect(collection.at(1).id).toEqual(2)
      expect(collection.at(2).id).toEqual(3)

    it 'orders by attribute with a fallback in descending order', ->
      collection.order = 'name desc, id desc'
      collection.sort()

      expect(collection.at(0).id).toEqual(3)
      expect(collection.at(1).id).toEqual(2)
      expect(collection.at(2).id).toEqual(1)

    it 'orders by attribute with a fallback with a different order', ->
      collection.order = 'name, id desc'
      collection.sort()

      expect(collection.at(0).id).toEqual(2)
      expect(collection.at(1).id).toEqual(1)
      expect(collection.at(2).id).toEqual(3)

  describe 'method ordering', ->
    beforeEach ->
      class MyModel extends Backbone.Model
        reversedName: -> @get('name').split('').reverse().join('')

      class MyCollection extends Backbone.Collection
        model: MyModel

      data = [ { id: 1, name: 'AZ', price: 3 }
               { id: 3, name: 'CY', price: 2 }
               { id: 2, name: 'AX', price: 3} ]
      collection = new MyCollection(data)

    it 'orders by the result of a method on a model', ->
      collection.order = '@reversedName'
      collection.sort()

      expect(collection.at(0).id).toEqual(2)
      expect(collection.at(1).id).toEqual(3)
      expect(collection.at(2).id).toEqual(1)

    it 'orders by the result of a method on a model in descending order', ->
      collection.order = '@reversedName desc'
      collection.sort()

      expect(collection.at(2).id).toEqual(2)
      expect(collection.at(1).id).toEqual(3)
      expect(collection.at(0).id).toEqual(1)

    it 'orders by the attribute and falls back on method', ->
      collection.order = 'price desc, @reversedName'
      collection.sort()

      expect(collection.at(0).id).toEqual(2)
      expect(collection.at(1).id).toEqual(1)
      expect(collection.at(2).id).toEqual(3)





















