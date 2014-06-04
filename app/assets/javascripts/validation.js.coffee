# TODO: Re-implement form validation.

# class Form
#     constructor: (selector) ->
#         @form = $(selector)
#         this_f = this
#         @form.find('input, textarea').blur(->
#             alert("Val")
#             this_f.validate()
#         ).keydown((event) ->
#             if event.keyCode == 27
#                 $(this).blur()
#         )
#         @form.on('ajax:beforeSend', (event) ->
#             this_f.validate()
#             return false unless this_f.status
#         ).on('ajax:success', (e, data, status, xhr) ->
#             if data['status']
#                 Modal.load.show(data['uid'])
#             else
#                 $(this).removeClass('loading')
#                 this_f.validate()
#         ).on('ajax:error', (e, data, status, xhr) ->
#             $(this).removeClass('loading')
#             alert('An error occurred, please try again')
#         )
#     validate: ->
#         new_data = @form.serialize()
#         unless @data == new_data
#             response = $.ajax({
#                 type: 'POST',
#                 url: '/ajax/validate_quickmod',
#                 data: new_data,
#                 async: false
#             })
#             json = response.responseJSON
#             if json
#                 @data = new_data
#                 @status = json.status
#                 @errors = json.errors
#                 this.render()
#     findFields: ->
#         @form.find("[data-form-field]")
#     renderError: (field, error) ->
#         field = $(field)
#         field.addClass('error')
#         errorContainer = field.find('[data-error-container]')
#         errorContainer.removeClass('hidden')
#         errorContainer.html(error)
#     cleanup: (field) ->
#         field = $(field)
#         field.removeClass('error')
#         errorContainer = field.find('[data-error-container]')
#         errorContainer.addClass('hidden')
#         errorContainer.empty()
#     render: ->
#         for field in this.findFields()
#             name = $(field).data('form-field')
#             if @errors[name] == undefined
#                 this.cleanup(field)
#             else
#                 this.renderError(field, @errors[name][0])

# new Form("form.validated-form")

