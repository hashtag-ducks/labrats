Labrats.Views.OwnerNotebook = Backbone.View.extend({
    events: {
        'click .new-page': 'newPage',
        'click .grant-access': 'grantAccess',
        'click .revoke-access': 'revokeAccess',
        'click .page-select a': 'selectPage',
        'click .delete-page' : 'deletePage'
    },

    pages: [],

    selectedPage: 0,

    initialize: function() {
        var self = this;
        this.model.get('page_templates').forEach(function(page, index) {
            var ele = $('<div></div>');
            self.$el.children('div.pages').append(ele);
            var view = new Labrats.Views.PageTemplate({
                model: page,
                el: ele
            });
            self.pages.push(view);
            var li = '<li><a href="#" id="page-<%= index %>">Page <%= index + 1 %></a></li>'
            self.$el.find('ul.page-select').append(
                $(_.template(li, {
                    index: index
                }))
            );
        });
        this.render();
    },

    render: function() {
        this.resetPageNumbers();
        this.$el.find('.page').hide();
        this.$el.find('#page-' + this.pages[this.selectedPage].model.get('id')).show();
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
                var pageEle = $('<div></div>');
                self.$el.children('div.pages').append(pageEle);
                var pageView = new Labrats.Views.PageTemplate({
                    model: page_model,
                    el: pageEle
                });
                self.pages.push(pageView);
                self.selectedPage = self.pages.length - 1;
                var li = '<li><a href="#" id="page-<%= index %>">Page <%= index + 1 %></a></li>'
                self.$el.find('ul.page-select').append(
                    $(_.template(li, {
                        index: self.selectedPage
                    }))
                );
                self.model.get('page_templates').add(page_model);
                self.render();
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
    },

    selectPage: function(event) {
        event.preventDefault();
        this.selectedPage = parseInt(event.currentTarget.getAttribute('id').split(/-/)[1]);
        this.render();
    },

    deletePage: function(event) {
        event.preventDefault();
        var page = this.pages[this.selectedPage];
        page.model.destroy({
            url: page.model.url() + '/' + page.model.get('id')
        });
        page.$el.remove();
        this.pages.splice(this.selectedPage, 1);
        this.$el.find('a#page-' + this.selectedPage).parent().remove();
        this.selectedPage = 0;
        this.render();
    },

    resetPageNumbers: function() {
        this.$el.find('.page-select li a').each(function(index, ele) {
            ele.innerHTML = "Page " + (index+1);
        });
    }
});
