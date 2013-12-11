Labrats.Views.Signup = Backbone.View.extend({
    events: {
        'input #user_name': 'checkFields',
        'input #user_organization': 'checkFields',
        'input #user_email': 'checkEmail',
        'input #user_password': 'checkPasswords',
        'input #user_password_confirmation': 'checkPasswords',
        'click input[type=submit]': 'checkSubmit'
    },

    EMAIL_REGEX: /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/,
    PASSWORD_LENGTH: 8,

    clearErrors: function($el) {
        $el.siblings('span.error').remove();
    },

    // This is a shitty name and a shitty function, but checkBlank was
    // already taken and requires a different input...
    checkFields: function(event) {
        var ele = $(event.currentTarget);
        this.clearErrors(ele);
        this.checkBlank(ele);
    },

    checkSubmit: function(event) {
        event.preventDefault();
        this.clearErrors($('.form-control'));
        var org = this.checkBlank($('#user_organization'));
        var email = this.checkEmail();
        var name = this.checkBlank($('#user_name'));
        var password = this.checkPasswords();
        if(org && email && name && password) {
            this.$el.find('input[type=submit]').submit();
        }
    },

    checkPasswords: function(event) {
        this.clearErrors($('#user_password'));
        var password = $('#user_password').val();
        var passwordConfirmation = $('#user_password_confirmation').val();
        if(password !== passwordConfirmation) {
            var span = $('<span class="error">Passwords don\'t match.</span>');
            $('#user_password').after(span);
            return false;
        }
        else if(password.length < this.PASSWORD_LENGTH) {
            var span = $('<span class="error">Passwords must be at least 8 characters.</span>');
            $('#user_password').after(span);
            return false;
        }
        return true;
    },

    checkEmail: function(event) {
        var email = $('#user_email').val();
        this.clearErrors($('#user_email'));
        if(!this.EMAIL_REGEX.test(email)) {
            var span = $('<span class="error">Email must be valid.</span>');
            $('#user_email').after(span);
            return false;
        }
        return true;
    },

    checkBlank: function($el) {
        if($el.val() === '') {
            var label = $el.siblings('label').text();
            var span = $('<span class="error">' + label + ' can\'t be blank.</span>')
            $el.after(span);
            return false;
        }
        return true;
    }
});
