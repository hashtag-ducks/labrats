Labrats.Views.TabGroup = Backbone.View.extend({
    initialize: function() {
        this.render();
        var self = this;
        this.model.get('boxes').forEach(function(box) {
            var ele = $('<li></li>');
            self.$el.find('ul.boxes').append(ele);
            var box_view = new Labrats.Views[box.get('type')]({
                model: box,
                el: ele
            });
        });
    },

    render: function() {
        var tpl = $('#tab_group-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    }
});
