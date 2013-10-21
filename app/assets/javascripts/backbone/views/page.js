Labrats.Views.Page = Backbone.View.extend({
    render: function() {
        var tpl = $('#page-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    }
});
