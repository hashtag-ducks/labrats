Labrats.Views.Notebook = Backbone.View.extend({
    events: {
        'click #new-page': 'newPage'
    },

    newPage: function(event) {
        event.preventDefault();
        var page_model = new Labrats.Models.Page({
            notebook_id: this.$el.attr('id')
        });
        page_model.save({}, {
            success: function() {
                var pageEle = $('<li></li>');
                $('.pages').append(pageEle);
                var page_view = new Labrats.Views.Page({
                    model: page_model,
                    el: pageEle
                });
                page_view.render();
            },
            error: function() {
                console.log('error');
            }
        });
    }
});
