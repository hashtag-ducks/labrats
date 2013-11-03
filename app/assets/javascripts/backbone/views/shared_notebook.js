Labrats.Views.SharedNotebook = Backbone.View.extend({
    initialize: function() {
        var self = this;
        this.model.get('pages').forEach(function(page) {
            var ele = $('<li></li>');
            self.$el.children('ul.pages').append(ele);
            var view = new Labrats.Views.Page({
                model: page,
                el: ele
            });
        });
    }
});
