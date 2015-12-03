_ = require 'lodash'
module.exports = class Rect
	constructor: (obj) ->
		@x = 0
		@y = 0

		@width = 0
		@height = 0

		Object.defineProperties @,
			left:
				set: (v) => @x = v
				get: => @x
			top:
				set: (v) => @y = v
				get: => @y

			right:
				set: (v) => @width = v - @x
				get: => @x + @width
			bottom:
				set: (v) => @height = v - @y
				get: => @y + @height

			centerX:
				set: (v) => @x = v - @width / 2
				get: => @x + @width / 2
			centerY:
				set: (v) => @y = v - @height / 2
				get: => @y + @height / 2
			center:
				get: => x: @centerX, y: @centerY

		switch
			when obj.x? and obj.y? and obj.width? and obj.height?
				{@x, @y, @width, @height} = obj

			when obj.left? and obj.top? and obj.bottom? and obj.right?
				{@left, @top, @bottom, @right} = obj

			when obj.topLeft? and obj.bottomRight?
				{topLeft, bottomRight} = obj
				{@x, @y} = topLeft
				{x: @bottom, y: @right} = bottomRight

	overlaps: (rect) ->
		not (
			@left > rect.right or
			@right < rect.left or
			@top > rect.bottom or
			@bottom < rect.top
		)
		
	@revive: (rect, owner) ->
		return _.assign(new Rect(owner), rect)