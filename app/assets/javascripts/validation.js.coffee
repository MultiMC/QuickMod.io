class Form
    constructor: (selector) ->
        # A map of fields that have been focused once before.
        # If something's not in this list, it will be ignored when validating.
        @form = $(selector)
        thisf = this
        @form.find('input, textarea').blur(->
            unless $(this).data('validationActive')
                console.log("Now validating")
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
            console.log("validate")
            @forceValidate = false
            response = $.ajax({
                type: 'POST',
                url: document.URL + '/ajax_validate',
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
        console.log(this.activeFields)
        for field in this.findFields() when $(field).find('input, textarea').data('validationActive') is true
            name = $(field).data('form-field')
            if @errors[name] == undefined
                this.cleanup(field)
            else
                this.renderError(field, @errors[name][0])

$(document).ready ->
    new Form("form.validated-form").validate()

