# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('ready page:load', ->
	window.Modal =
		__self: null
		__parent: $('.ui.dimmer.page')
		visible: ->
			this.__parent.hasClass('visible')
		__settings:
			debug: false
			verbose: false
			closable: false
			selector: {
				close    : '.close, .actions .close'
				approve  : '.actions .positive, .actions .approve, .actions .ok'
				deny     : '.actions .negative, .actions .deny, .actions .cancel'
			}
		__current: null
		__wasVisible: false
		__form: null
		initialize: ->
			this.__self.modal(this.__settings)
		toggle: ->
			this.__self.modal('toggle') unless this.__self == null
		show: ->
			unless this.visible()
				this.__self.modal('show') unless this.__self == null
				unless this.__wasVisible
					this.cache_sizes()
					this.refresh()
					this.__wasVisible = true
		hide: ->
			if this.visible()
				this.__self.modal('hide') unless this.__self == null
		cache_sizes: ->
			this.__self.modal('cache sizes') unless this.__self == null
		refresh: ->
			this.__self.modal('refresh') unless this.__self == null
		__replace: (data, done_func) ->
			data = $(data)
			unless this.__self == null
				this.__self.modal('destroy')
				this.__wasVisible = false
			visible = this.visible()
			this.__parent.html(data)
			this.__self = $('.ui.dimmer.page .ui.modal')
			this.initialize()
			this.__self.click((event)->
				event.stopPropagation()
			)
			if visible
				this.__self.addClass('active visible')
				this.cache_sizes()
				this.refresh()
			done_func() unless done_func == undefined
		load:
			__show: (id, done_func) ->
				$.get("ajax/quickmods/show/"+id, (data) ->
					Modal.__replace(data, done_func)
				)
				Modal.__current = 'show/'+id
			__edit: (id, done_func) ->
				$.get("ajax/quickmods/edit/"+id, (data) ->
					Modal.__replace(data, done_func)
				)
				Modal.__current = 'edit/'+id
			__new: (done_func) ->
				$.get("ajax/quickmods/new", (data) ->
					Modal.__replace(data, done_func)
				)
				Modal.__current = 'new'
			show: (id, done_func) ->
				unless Modal.__current == 'show/' + id
					this.__show(id, (->
						$('.ui.modal .actions .button[data-editqm]').click((event) ->
							button = $(this)
							button.addClass('loading')
							Modal.load.edit(id, ->
								setTimeout (->Modal.show()), 500
							)
						)
						done_func() unless done_func == undefined
					))
				else
					done_func() unless done_func == undefined
			edit: (id, done_func) ->
				unless Modal.__current == 'edit/' + id
					this.__edit(id, (->
						$('.ui.modal .actions .button[data-cancel]').click((event) ->
							button = $(this)
							button.addClass('loading')
							Modal.load.show(id)
						)
						Modal.__form = new Form('form.ui.modal.form')
						done_func() unless done_func == undefined
					))
				else
					done_func() unless done_func == undefined

			new: (done_func) ->
				unless Modal.__current == 'new'
					this.__new(->
						Modal.__form = new Form('form.ui.modal.form')
						done_func() unless done_func == undefined
					)
				else
					done_func() unless done_func == undefined

	$('[data-qmuid]').click((event) ->
		element = $(this)
		element.dimmer('show')
		uid = element.data('qmuid')
		Modal.load.show(uid, ->
			element.dimmer('hide')
			Modal.show()
		)
	)

	$('[data-newqm]').click((event) ->
		event.preventDefault()
		Modal.load.new(->
			Modal.show()
		)
	)


	class window.Form
		constructor: (selector) ->
			@form = $(selector)
			this_f = this
			@form.find('input, textarea').blur(->
				this_f.validate()
			).keydown((event) ->
				if event.keyCode == 27
					$(this).blur()
			)
			@form.on('ajax:beforeSend', (event) ->
				this_f.validate()
				return false unless this_f.status
			).on('ajax:success', (e, data, status, xhr) ->
				if data['status']
					Modal.load.show(data['uid'])
				else
					$(this).removeClass('loading')
					this_f.validate()
			).on('ajax:error', (e, data, status, xhr) ->
				$(this).removeClass('loading')
				alert('An error occurred, please try again')
			)
		validate: ->
			new_data = @form.serialize()
			unless @data == new_data
				response = $.ajax({
					type: 'POST',
					url: '/ajax/validate_quickmod',
					data: new_data,
					async: false
				})
				json = response.responseJSON
				if json
					@data = new_data
					@status = json.status
					@errors = json.errors
					this.render()
		findFields: ->
			@form.find("[data-form-field]")
		renderError: (field, error) ->
			field = $(field)
			field.addClass('error')
			errorContainer = field.find('[data-error-container]')
			errorContainer.removeClass('hidden')
			errorContainer.html(error)
		cleanup: (field) ->
			field = $(field)
			field.removeClass('error')
			errorContainer = field.find('[data-error-container]')
			errorContainer.addClass('hidden')
			errorContainer.empty()
		render: ->
			for field in this.findFields()
				name = $(field).data('form-field')
				if @errors[name] == undefined
					this.cleanup(field)
				else
					this.renderError(field, @errors[name][0])

	$('body > .ui.dimmer.page').click(->
		Modal.hide()
	)
)