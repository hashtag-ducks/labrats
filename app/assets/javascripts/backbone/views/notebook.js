Labrats.Views.Notebook = Backbone.View.extend({
    events: {
        'click .new-page': 'newPage',
        'click .grant-access': 'grantAccess',
        'click .revoke-access': 'revokeAccess'
    },

    initialize: function() {
        this.render();
    },

    render: function() {
        var self = this;
        this.model.get('page_templates').forEach(function(page) {
            var ele = $('<li></li>');
            self.$el.children('ul.pages').append(ele);
            var view = new Labrats.Views.PageTemplate({
                model: page,
                el: ele
            });
        });
    },

    newPage: function(event) {
        event.preventDefault();
        var page_model = new Labrats.Models.PageTemplate({
            notebook_id: this.$el.attr('id')
        });
        var self = this;
        page_model.save({}, {
            success: function(response) {
                // Create a new Page model so that it's got the correct ID.
                page_model = new Labrats.Models.PageTemplate(
                    _.extend({is_owner: true}, response.attributes)
                );
                var pageEle = $('<li></li>');
                self.$el.children('ul.pages').append(pageEle);
                var pageView = new Labrats.Views.PageTemplate({
                    model: page_model,
                    el: pageEle
                });
                self.model.get('page_templates').add(page_model);
            },
            error: function() {
                console.log('error saving page');
            }
        });
    },

    grantAccess: function(event) {
        event.preventDefault();
        var email = this.$el.find('.user-email').val();
        $.ajax('/notebook_access', {
            type: 'POST',
            data: {
                id: this.model.get('id'),
                user_email: email
            }
        });
    },

    revokeAccess: function(event) {
        event.preventDefault();
        var email = this.$el.find('.user-email').val();
        $.ajax('/notebook_access/' + this.model.get('id'), {
            type: 'DELETE',
            data: {
                user_email: email
            }
        });
    }
});
