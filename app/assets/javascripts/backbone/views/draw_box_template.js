Labrats.Views.DrawBoxTemplate = Labrats.Views.BoxTemplate.extend({
    events: {
        'click .save-box': 'save'
    },

    initialize: function() {
        var tpl = $('#draw_box_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
        }));
        this.render();
    }
});
