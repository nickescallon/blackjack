class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @busted  = false
    @standed  = false
    @

  hit: -> if (!@busted && !@standed) then @add(@deck.pop()).last()

  stand: ->
    if (!@standed && !@isDealer)
      @trigger('stand', @) 
      @standed = true

  reveal: -> 
    if (@isDealer)
      @.at(0).flip()

  play: ->
    while @scores()[0] < 17 && (!@scores()[1]? || (@scores()[1] < 18 || @scores()[1] >21)) 
      @hit()
      if (@scores()[0] > 21)
        @trigger('bust', @)
    @trigger('done', @)
    @standed = true
    console.log @scores()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then @score = [score, score + 10] else @score = [score]
    if [score][0] > 21
      @busted = true
      @trigger('bust', @)
    @score
    
  getScores: ->
    @score
