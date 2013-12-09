Labrats.Views.SharedNotebook = Backbone.View.extend({
    events: {
        'click .page-select button': 'selectPage'
    },

    pages: [],

    selectedPage: 0,

    initialize: function() {
        var self = this;
        this.model.get('pages').forEach(function(page, index) {
            var ele = $('<div></div>');
            self.$el.children('div.pages').append(ele);
            var view = new Labrats.Views.FilledPage({
                model: page,
                el: ele
            });
            self.pages.push(view);
            var li = '<li><button href="#" id="page-<%= index %>" class="btn btn-default">Page <%= index + 1 %></button></li>'
            self.$el.find('ul.page-select').append(
                $(_.template(li, {
                    index: index
                }))
            );
        });
        this.render();
    },

    render: function() {
        this.$el.find('.page').hide();
        if(this.pages.length > 0) {
            this.$el.find('#page-' + this.pages[this.selectedPage].model.get('id')).show();
            this.$el.find("#page-title").text('Page ' + (this.selectedPage + 1 ));
        }
    },

    selectPage: function(event) {
        event.preventDefault();
        this.selectedPage = parseInt(event.currentTarget.getAttribute('id').split(/-/)[1]);
        this.render();
    }
});
