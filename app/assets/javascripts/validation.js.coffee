class Form
    constructor: (form) ->
        # A map of fields that have been focused once before.
        # If something's not in this list, it will be ignored when validating.
        @form = $(form)
        @validateUrl = $(form).data('validate-url')
        thisf = this
        @form.find('input, textarea').blur(->
            unless $(this).data('validationActive')
                $(this).data('validationActive', true)
                thisf.forceValidate = true
            thisf.validate()
        ).keydown((event) ->
            if event.keyCode == 27
                $(this).blur()
        )
    validate: ->
        new_data = @form.serialize()
        if @data != new_data or @forceValidate
            @forceValidate = false
            response = $.ajax({
                type: 'POST',
                url: @validateUrl
                data: new_data,
                async: true
            }).done( =>
                json = response.responseJSON
                if json
                    @data = new_data
                    @status = json.status
                    @errors = json.errors
                    this.render()
            )
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
        for field in this.findFields() when $(field).find('input, textarea').data('validationActive') is true
            name = $(field).data('form-field')
            if @errors[name] == undefined
                this.cleanup(field)
            else
                this.renderError(field, @errors[name][0])

$(document).ready ->
    for form in $('[data-validate-url]')
        new Form(form)

