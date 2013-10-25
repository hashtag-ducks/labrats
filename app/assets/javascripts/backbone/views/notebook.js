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
        this.model.get('pages').forEach(function(page) {
            var ele = $('<li></li>');
            self.$el.children('ul.pages').append(ele);
            var view = new Labrats.Views.Page({
                model: page,
                el: ele
            });
        });
    },

    newPage: function(event) {
        event.preventDefault();
        var page_model = new Labrats.Models.Page({
            notebook_id: this.$el.attr('id')
        });
        var self = this;
        page_model.save({}, {
            success: function(response) {
                // Create a new Page model so that it's got the correct ID.
                page_model = new Labrats.Models.Page(response.attributes);
                var pageEle = $('<li></li>');
                self.$el.children('ul.pages').append(pageEle);
                var pageView = new Labrats.Views.Page({
                    model: page_model,
                    el: pageEle
                });
                self.model.get('pages').add(page_model);
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
